SET search_path TO insurance;

-- Dynamic bi-temporal versioning function
CREATE OR REPLACE FUNCTION insurance.bitemporal_versioning_fn()
RETURNS TRIGGER AS $$
DECLARE
    col_names TEXT;
BEGIN
    -- Dynamically extract the column names of the active table. 
    -- This guarantees that when we insert into the history table, the columns align 
    -- perfectly, bypassing the auto-generated history_id column at the end.
    SELECT string_agg(quote_ident(column_name), ', ' ORDER BY ordinal_position)
    INTO col_names
    FROM information_schema.columns
    WHERE table_schema = TG_TABLE_SCHEMA
      AND table_name = TG_TABLE_NAME;

    IF (TG_OP = 'UPDATE') THEN
        -- 1. Close the OLD record (timestamping the exact moment it expired)
        OLD.valid_to := CURRENT_TIMESTAMP;
        OLD.transaction_to := CURRENT_TIMESTAMP;
        OLD.is_current := FALSE;
        
        -- 2. Archive the closed OLD record into the corresponding _history table
        EXECUTE format('INSERT INTO %I.%I (%s) SELECT ($1).*', 
                       TG_TABLE_SCHEMA, 
                       TG_TABLE_NAME || '_history', 
                       col_names) 
        USING OLD;
        
        -- 3. Prepare the NEW record for the active table
        NEW.version_number := OLD.version_number + 1;
        NEW.valid_from := CURRENT_TIMESTAMP;
        NEW.transaction_from := CURRENT_TIMESTAMP;
        -- Keep 'to' dates open (infinity) for the active record
        NEW.valid_to := '9999-12-31 23:59:59';
        NEW.transaction_to := '9999-12-31 23:59:59';
        NEW.is_current := TRUE;
        
        -- Fallback: If legacy applications didn't provide a change_reason, assign a default
        IF NEW.change_reason = OLD.change_reason THEN
            NEW.change_reason := 'Automated Application Update';
        END IF;

        -- 4. Commit the new record to the active table
        RETURN NEW;
        
    ELSIF (TG_OP = 'DELETE') THEN
        -- 1. Close the OLD record
        OLD.valid_to := CURRENT_TIMESTAMP;
        OLD.transaction_to := CURRENT_TIMESTAMP;
        OLD.is_current := FALSE;
        OLD.change_reason := 'Logical Delete (Application Request)';
        
        -- 2. Archive to the _history table
        EXECUTE format('INSERT INTO %I.%I (%s) SELECT ($1).*', 
                       TG_TABLE_SCHEMA, 
                       TG_TABLE_NAME || '_history', 
                       col_names) 
        USING OLD;
        
        -- 3. Allow PostgreSQL to physically remove the row from the active table.
        -- Since the data is perfectly preserved in the history table, this constitutes 
        -- a true Logical Delete from an enterprise perspective.
        RETURN OLD;
    END IF;
    
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
