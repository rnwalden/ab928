BEGIN
    -- === SGBSTDN Logic === --
    FOR rec IN (
        SELECT sgbstdn_pidm, sgbstdn_term_code_eff
        FROM sgbstdn
        WHERE sgbstdn_egol_code = 'A'
          AND sgbstdn_activity_date >= TRUNC(SYSDATE) - 2
    ) LOOP
        BEGIN
            INSERT INTO ab928_staging_data (
                ab928_pidm,
                ab928_term_code_eff,
                ab928_source,
                ab928_exceptions_processed,
                ab928_adt_processed
            ) VALUES (
                rec.sgbstdn_pidm,
                rec.sgbstdn_term_code_eff,
                'SGBSTDN',
                0,
                0
            );
        EXCEPTION
            WHEN OTHERS THEN
                log_error(SQLCODE, SQLERRM, 'avc_sgbstdn_script');
        END;
    END LOOP;

    -- === SVREDGL Logic === -- 
    FOR rec IN (
        SELECT svredgl_pidm, svredgl_eff_term
        FROM svredgl
        WHERE svredgl_goal_code = 'A'
          AND svredgl_goal_opt = 'P'
          AND svredgl_activity_date >= TRUNC(SYSDATE) - 2
    ) LOOP
        BEGIN
            UPDATE ab928_staging_data
            SET ab928_source = 'UPSVREDG',
                ab928_exceptions_processed = 0,
                ab928_adt_processed = 0
            WHERE ab928_pidm = rec.svredgl_pidm
              AND ab928_term_code_eff = rec.svredgl_eff_term;

            IF SQL%ROWCOUNT = 0 THEN
                INSERT INTO ab928_staging_data (
                    ab928_pidm,
                    ab928_term_code_eff,
                    ab928_source,
                    ab928_exceptions_processed,
                    ab928_adt_processed
                ) VALUES (
                    rec.svredgl_pidm,
                    rec.svredgl_eff_term,
                    'SVREDGL',
                    0,
                    0
                );
            END IF;
        EXCEPTION
            WHEN OTHERS THEN
                log_error(SQLCODE, SQLERRM, 'avc_svredgl_script');
        END;
    END LOOP;
END;
/

