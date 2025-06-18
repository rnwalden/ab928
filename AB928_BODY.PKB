create or replace PACKAGE BODY       "AB928_IMPL" AS

    CURSOR local_learner (l_pidm NUMBER, p_term_code_eff VARCHAR2) IS
        SELECT
            sgbstdn_stst_code,
            sgbstdn_levl_code,
            sgbstdn_styp_code,
            sgbstdn_term_code_matric,
            sgbstdn_term_code_admit,
            sgbstdn_exp_grad_date,
            sgbstdn_camp_code,
            sgbstdn_full_part_ind,
            sgbstdn_sess_code,
            sgbstdn_resd_code,
            sgbstdn_coll_code_1,
            sgbstdn_degc_code_1,
            sgbstdn_majr_code_1,
            sgbstdn_majr_code_minr_1,
            sgbstdn_majr_code_minr_1_2,
            sgbstdn_majr_code_conc_1,
            sgbstdn_majr_code_conc_1_2,
            sgbstdn_majr_code_conc_1_3,
            sgbstdn_coll_code_2,
            sgbstdn_degc_code_2,
            sgbstdn_majr_code_2,
            sgbstdn_majr_code_minr_2,
            sgbstdn_majr_code_minr_2_2,
            sgbstdn_majr_code_conc_2,
            sgbstdn_majr_code_conc_2_2,
            sgbstdn_majr_code_conc_2_3,
            sgbstdn_orsn_code,
            sgbstdn_prac_code,
            sgbstdn_advr_pidm,
            sgbstdn_grad_credit_appr_ind,
            sgbstdn_capl_code,
            sgbstdn_leav_code,
            sgbstdn_leav_from_date,
            sgbstdn_leav_to_date,
            sgbstdn_astd_code,
            sgbstdn_term_code_astd,
            sgbstdn_rate_code,
            sgbstdn_activity_date,
            sgbstdn_majr_code_1_2,
            sgbstdn_majr_code_2_2,
            sgbstdn_edlv_code,
            sgbstdn_incm_code,
            sgbstdn_admt_code,
            sgbstdn_emex_code,
            sgbstdn_aprn_code,
            sgbstdn_trcn_code,
            sgbstdn_gain_code,
            sgbstdn_voed_code,
            sgbstdn_blck_code,
            sgbstdn_term_code_grad,
            sgbstdn_acyr_code,
            sgbstdn_dept_code,
            sgbstdn_site_code,
            sgbstdn_dept_code_2,
            sgbstdn_egol_code,
            sgbstdn_degc_code_dual,
            sgbstdn_levl_code_dual,
            sgbstdn_dept_code_dual,
            sgbstdn_coll_code_dual,
            sgbstdn_majr_code_dual,
            sgbstdn_bskl_code,
            sgbstdn_prim_roll_ind,
            sgbstdn_program_1,
            sgbstdn_term_code_ctlg_1,
            sgbstdn_dept_code_1_2,
            sgbstdn_majr_code_conc_121,
            sgbstdn_majr_code_conc_122,
            sgbstdn_majr_code_conc_123,
            sgbstdn_secd_roll_ind,
            sgbstdn_term_code_admit_2,
            sgbstdn_admt_code_2,
            sgbstdn_program_2,
            sgbstdn_term_code_ctlg_2,
            sgbstdn_levl_code_2,
            sgbstdn_camp_code_2,
            sgbstdn_dept_code_2_2,
            sgbstdn_majr_code_conc_221,
            sgbstdn_majr_code_conc_222,
            sgbstdn_majr_code_conc_223,
            sgbstdn_curr_rule_1,
            sgbstdn_cmjr_rule_1_1,
            sgbstdn_ccon_rule_11_1,
            sgbstdn_ccon_rule_11_2,
            sgbstdn_ccon_rule_11_3,
            sgbstdn_cmjr_rule_1_2,
            sgbstdn_ccon_rule_12_1,
            sgbstdn_ccon_rule_12_2,
            sgbstdn_ccon_rule_12_3,
            sgbstdn_cmnr_rule_1_1,
            sgbstdn_cmnr_rule_1_2,
            sgbstdn_curr_rule_2,
            sgbstdn_cmjr_rule_2_1,
            sgbstdn_ccon_rule_21_1,
            sgbstdn_ccon_rule_21_2,
            sgbstdn_ccon_rule_21_3,
            sgbstdn_cmjr_rule_2_2,
            sgbstdn_ccon_rule_22_1,
            sgbstdn_ccon_rule_22_2,
            sgbstdn_ccon_rule_22_3,
            sgbstdn_cmnr_rule_2_1,
            sgbstdn_cmnr_rule_2_2,
            sgbstdn_prev_code,
            sgbstdn_term_code_prev,
            sgbstdn_cast_code,
            sgbstdn_term_code_cast,
            sgbstdn_data_origin,
            sgbstdn_user_id,
            sgbstdn_scpc_code,
            sgbstdn_surrogate_id,
            sgbstdn_version,
            sgbstdn_vpdi_code,
            sgbstdn_guid
        FROM sgbstdn
        WHERE sgbstdn_pidm = l_pidm
            AND sgbstdn_term_code_eff = p_term_code_eff;

        local_learner_rec   local_learner%rowtype;


    CURSOR student_cursor_ab928 IS
        SELECT
            ab928_pidm,
            ab928_term_code_eff,
            ab928_source,
            ab928_exceptions_processed,
            ab928_adt_processed
        FROM
            ab928_staging_data
        WHERE
            ab928_exceptions_processed = 0;

        student_rec    student_cursor_ab928%rowtype;


    CURSOR student_cursor_adt_ab928 IS
        SELECT
            ab928_pidm,
            ab928_term_code_eff,
            ab928_source,
            ab928_exceptions_processed,
            ab928_adt_processed
        FROM
            ab928_staging_data
        WHERE
            ab928_adt_processed = 0;

        student_adt_rec     student_cursor_adt_ab928%rowtype;


    CURSOR adt_local_degree_cursor IS
        SELECT
            major_code
        FROM
            adt_local_degree_mapping;

        local_degree_rec    adt_local_degree_cursor%rowtype;


    CURSOR adt_localcte_degree_cursor IS
        SELECT
            maj_code
        FROM
            cte;

        localcte_degree_rec adt_localcte_degree_cursor%rowtype;


    CURSOR local_sorlcur (l_pidm NUMBER,l_sorlcur_term_code_ctlg VARCHAR2,l_end_date VARCHAR2) IS
        SELECT
            sorlcur_pidm,
            sorlcur_seqno,
            sorlcur_lmod_code,
            sorlcur_term_code,
            sorlcur_key_seqno,
            sorlcur_priority_no,
            sorlcur_roll_ind,
            sorlcur_cact_code,
            sorlcur_user_id,
            sorlcur_data_origin,
            sorlcur_activity_date,
            sorlcur_levl_code,
            sorlcur_coll_code,
            sorlcur_degc_code,
            sorlcur_term_code_ctlg,
            sorlcur_term_code_end,
            sorlcur_term_code_matric,
            sorlcur_term_code_admit,
            sorlcur_admt_code,
            sorlcur_camp_code,
            sorlcur_program,
            sorlcur_start_date,
            sorlcur_end_date,
            sorlcur_curr_rule,
            sorlcur_rolled_seqno,
            sorlcur_styp_code,
            sorlcur_rate_code,
            sorlcur_leav_code,
            sorlcur_leav_from_date,
            sorlcur_leav_to_date,
            sorlcur_exp_grad_date,
            sorlcur_term_code_grad,
            sorlcur_acyr_code,
            sorlcur_site_code,
            sorlcur_appl_seqno,
            sorlcur_appl_key_seqno,
            sorlcur_user_id_update,
            sorlcur_activity_date_update,
            sorlcur_gapp_seqno,
            sorlcur_current_cde,
            sorlcur_surrogate_id,
            sorlcur_version,
            sorlcur_vpdi_code,
            sorlcur_guid,
            sorlcur_outcome_guid
        FROM
            sorlcur
        WHERE
                sorlcur_pidm = l_pidm
            AND sorlcur_lmod_code = 'LEARNER'
            AND sorlcur_priority_no = 1
            AND sorlcur_cact_code = 'ACTIVE'
            AND sorlcur_term_code_ctlg = l_sorlcur_term_code_ctlg
            AND ( ( l_end_date IS NULL AND sorlcur_term_code_end IS NULL )
                  OR sorlcur_term_code_end = l_end_date );

        local_sorlcur_rec   local_sorlcur%rowtype;


    CURSOR local_sorlfos (l_pidm NUMBER, l_sorlfos_lcur_seqno NUMBER) IS
        SELECT
            sorlfos_pidm,
            sorlfos_lcur_seqno,
            sorlfos_seqno,
            sorlfos_lfst_code,
            sorlfos_term_code,
            sorlfos_priority_no,
            sorlfos_csts_code,
            sorlfos_cact_code,
            sorlfos_data_origin,
            sorlfos_user_id,
            sorlfos_activity_date,
            sorlfos_majr_code,
            sorlfos_term_code_ctlg,
            sorlfos_term_code_end,
            sorlfos_dept_code,
            sorlfos_majr_code_attach,
            sorlfos_lfos_rule,
            sorlfos_conc_attach_rule,
            sorlfos_start_date,
            sorlfos_end_date,
            sorlfos_tmst_code,
            sorlfos_rolled_seqno,
            sorlfos_user_id_update,
            sorlfos_activity_date_update,
            sorlfos_current_cde,
            sorlfos_surrogate_id,
            sorlfos_version,
            sorlfos_vpdi_code
        FROM
            sorlfos
        WHERE
                sorlfos_pidm = l_pidm
            AND sorlfos_lcur_seqno = l_sorlfos_lcur_seqno;

        local_sorlfos_rec   local_sorlfos%rowtype;


    PROCEDURE insertdata_soartest (pidm IN VARCHAR2, error_code IN VARCHAR2, get_current_term IN VARCHAR2) IS
        v_count         INTEGER;
        v_most_eff_term VARCHAR2(6);
        PRAGMA autonomous_transaction;

        BEGIN
            dbms_output.put_line('279 PROCEDURE INSERTDATA_SOARTEST: ' || ' pidm: ' || pidm || ' error_code: ' || error_code || ' current term: ' || get_current_term);

            SELECT COUNT(*)
            INTO v_count
            FROM sortest
            WHERE sortest_pidm = pidm AND sortest_user_id = 'AB928';

            SELECT
                avc.get_current_term()
            INTO v_most_eff_term
            FROM
                dual;

            IF ( v_count = 0 ) THEN
                INSERT INTO sortest (
                    sortest_pidm,
                    sortest_tesc_code, --exceptipn
                    sortest_test_date,
                    sortest_test_score,-- 77
                    sortest_activity_date, --sysdate
                    sortest_user_id, --, ab928
                    sortest_data_origin,
                    sortest_camp_code,
                    sortest_term_code_entry,
                    sortest_equiv_ind,
                    sortest_tsrc_code
                ) VALUES (
                    pidm,
                    error_code,
                    sysdate,
                    '77',
                    sysdate,
                    'AB928',
                    'Banner',
                    'L',
                    v_most_eff_term,
                    'N',
                    'A928'
                );

                UPDATE ab928_staging_data
                SET
                    ab928_exceptions_processed = 2
                WHERE
                    ab928_pidm = pidm
                    AND ab928_term_code_eff = get_current_term;

                COMMIT;
            ELSE
                dbms_output.put_line('328 in uPDATE sortest');
                UPDATE sortest
                SET
                    sortest_tesc_code = error_code,
                    sortest_test_date = sysdate,
                    sortest_activity_date = sysdate,
                    sortest_term_code_entry = get_current_term
                WHERE
                    sortest_pidm = pidm
                    AND sortest_user_id = 'AB928';

                dbms_output.put_line('339 in uPDATE1 ab928_staging_data');
                UPDATE ab928_staging_data
                SET
                    ab928_exceptions_processed = 2
                WHERE
                    ab928_pidm = pidm
                    AND ab928_term_code_eff = get_current_term;

                COMMIT;
            END IF;

        EXCEPTION
            WHEN OTHERS THEN
                dbms_output.put_line('352 EXCEPTION no insert'|| ' pidm: ' || pidm || ' get_current_term: ' || get_current_term);
                log_error(sqlcode, sqlerrm, 'INSERTDATA_SOARTEST');
    END insertdata_soartest;

    PROCEDURE getmajorcodeandprocesserror IS
        major_code_local VARCHAR2(20);
        majormatch       INTEGER;

        BEGIN
            majormatch := 0;

            OPEN student_cursor_ab928;
                LOOP
                    FETCH student_cursor_ab928 INTO student_rec;
                    EXIT WHEN student_cursor_ab928%notfound;
                END LOOP;
            CLOSE student_cursor_ab928;

            OPEN adt_local_degree_cursor;
                LOOP
                    FETCH adt_local_degree_cursor INTO local_degree_rec;
                    EXIT WHEN adt_local_degree_cursor%notfound;
                END LOOP;
            CLOSE adt_local_degree_cursor;

            OPEN adt_localcte_degree_cursor;
                LOOP
                    FETCH adt_localcte_degree_cursor INTO localcte_degree_rec;
                    EXIT WHEN adt_localcte_degree_cursor%notfound;
                END LOOP;
            CLOSE adt_localcte_degree_cursor;

            FOR stagingdata IN student_cursor_ab928 LOOP
                dbms_output.put_line('385 For stagingdata in cursor ab928: ' || 'pidm: ' || to_char(stagingdata.ab928_pidm) || ' Eff Term Code: ' || to_char(stagingdata.ab928_term_code_eff));
                BEGIN
                    SELECT sgbstdn_majr_code_1
                    INTO major_code_local
                    FROM
                        (SELECT a1.sgbstdn_majr_code_1
                            FROM sgbstdn a1
                            WHERE a1.sgbstdn_term_code_eff = (SELECT MAX(a2.sgbstdn_term_code_eff)
                                                              FROM sgbstdn a2
                                                              WHERE a1.sgbstdn_pidm = a2.sgbstdn_pidm
                                                              AND a1.sgbstdn_pidm = stagingdata.ab928_pidm
                                                             )
                        )
                    WHERE ROWNUM <= 1;

                    dbms_output.put_line('400 Major code local: ' || to_char(major_code_local));

                EXCEPTION
                    WHEN no_data_found THEN
                        log_error(sqlcode, sqlerrm, 'major_code_local');
                END;

                IF major_code_local IS NOT NULL THEN
                    dbms_output.put_line('408 IF major_code_local IS NOT NULL major code local: ' || to_char(major_code_local));
                    FOR local_major IN adt_local_degree_cursor LOOP
                        dbms_output.put_line('410 in loop: ' || to_char(local_major.major_code));
                        IF local_major.major_code = major_code_local THEN
                            majormatch := 1;
                        END IF;
                    END LOOP;

                    FOR localcte_major IN adt_localcte_degree_cursor LOOP
                        IF localcte_major.maj_code = major_code_local THEN
                            majormatch := 2;
                        END IF;
                    END LOOP;

                    IF ( majormatch = 1 ) THEN
                        UPDATE ab928_staging_data
                        SET ab928_exceptions_processed = 1
                        WHERE ab928_pidm = stagingdata.ab928_pidm
                              AND ab928_term_code_eff = stagingdata.ab928_term_code_eff;

                        COMMIT;
                    END IF;

                    IF ( majormatch = 0 ) THEN
                        dbms_output.put_line('431 majormatch = 0');
                        insertdata_soartest(stagingdata.ab928_pidm, 'ADTX', stagingdata.ab928_term_code_eff);
                        dbms_output.put_line('433 pidm: ' || stagingdata.ab928_pidm || ' ADTX ' || 'Eff Term Code: ' || stagingdata.ab928_term_code_eff);
                    END IF;

                    IF ( majormatch = 2 ) THEN
                        dbms_output.put_line('436 CTE');
                        insertdata_soartest(stagingdata.ab928_pidm, 'ADTC', stagingdata.ab928_term_code_eff);
                        dbms_output.put_line('438 pidm: ' || stagingdata.ab928_pidm || ' ADTC ' || 'Eff Term Code: ' || stagingdata.ab928_term_code_eff);
                    END IF;

                    IF ( major_code_local IN ( 'AFMT', 'RSP2' ) ) THEN
                        dbms_output.put_line('UG');
                        insertdata_soartest(stagingdata.ab928_pidm, 'ADTB', stagingdata.ab928_term_code_eff);
                        dbms_output.put_line('444 pidm: ' || stagingdata.ab928_pidm || ' ADTB ' || 'Eff Term Code: ' || stagingdata.ab928_term_code_eff);
                    ELSE
                        dbms_output.put_line('448 NO Majors Exception');
                    END IF;

                ELSE
                    dbms_output.put_line('No major code found for the given criteria.');
                END IF;

                dbms_output.put_line('455 In loop for pidm: ' || to_char(stagingdata.ab928_pidm));
            END LOOP;

    END getmajorcodeandprocesserror;

    PROCEDURE p_update_current (
        p_pidm          sorlcur.sorlcur_pidm%TYPE,
        p_seqno         sorlcur.sorlcur_seqno%TYPE,
        p_user_id       sorlcur.sorlcur_user_id%TYPE,
        p_data_origin   sorlcur.sorlcur_data_origin%TYPE,
        p_current_cde   sorlcur.sorlcur_current_cde%TYPE,
        p_term_code_end sorlcur.sorlcur_term_code_end%TYPE DEFAULT NULL,
        p_rowid         VARCHAR2 DEFAULT NULL
        ) IS

        lv_activity_date sorlcur.sorlcur_activity_date%TYPE;

        BEGIN
            lv_activity_date := sysdate;
            dbms_output.put_line('474 pidm: ' || to_char(p_pidm));
            dbms_output.put_line('474 seqno: ' || to_char(p_seqno));
            dbms_output.put_line('474 user id: ' || to_char(p_user_id));
            dbms_output.put_line('474 data origin: ' || to_char(p_data_origin));
            dbms_output.put_line('474 term code end: ' || to_char(p_term_code_end));
            dbms_output.put_line('474 rowid: ' || to_char(p_rowid));

            IF p_rowid IS NOT NULL THEN
                UPDATE sorlcur
                SET
                    sorlcur_user_id_update = p_user_id,
                    sorlcur_data_origin = p_data_origin,
                    sorlcur_activity_date_update = lv_activity_date,
                    sorlcur_current_cde = p_current_cde,
                    sorlcur_term_code_end = p_term_code_end
                WHERE
                    ROWID = p_rowid;

            ELSE
                UPDATE sorlcur
                SET
                    sorlcur_user_id_update = p_user_id,
                    sorlcur_data_origin = p_data_origin,
                    sorlcur_activity_date_update = lv_activity_date,
                    sorlcur_current_cde = p_current_cde,
                    sorlcur_term_code_end = p_term_code_end
                WHERE
                    sorlcur_seqno = p_seqno
                    AND sorlcur_pidm = p_pidm;

            END IF;

            IF ( SQL%rowcount != 1 ) THEN
                raise_application_error(gb_common_strings.err_code, gb_common.f_err_msg_add_delim(dml_common.dml_update_failed));
            END IF;

            -- were is the commit
            --COMMIT;

    END p_update_current;

    PROCEDURE p_upd_sorlfos_current_cde (
        p_pidm        IN spriden.spriden_pidm%TYPE,
        p_lcur_seqno  IN sorlcur.sorlcur_seqno%TYPE,
        p_lfos_seqno  IN sorlfos.sorlfos_seqno%TYPE,
        p_data_origin IN sorlfos.sorlfos_data_origin%TYPE,
        p_user_id     IN sorlfos.sorlfos_user_id%TYPE
        ) IS

        lv_major_code sorlfos.sorlfos_majr_code%TYPE := NULL;
        e_enddate_leser_than_startdate EXCEPTION;
        error_message gb_common_strings.err_type;

        BEGIN
            UPDATE sorlfos
            SET
                sorlfos_current_cde = NULL,
                sorlfos_data_origin = p_data_origin,
                sorlfos_user_id_update = p_user_id,
                sorlfos_activity_date_update = sysdate
            WHERE
                sorlfos_pidm = p_pidm
                AND sorlfos_lcur_seqno = p_lcur_seqno
                AND sorlfos_seqno = p_lfos_seqno;

        EXCEPTION
            WHEN OTHERS THEN
                RAISE;
    END p_upd_sorlfos_current_cde;

    PROCEDURE adt_process (
        pidm             IN NUMBER,
        get_current_term IN VARCHAR2,
        l_ab928_source   IN VARCHAR2
        ) IS

        lv_seqno             sorlcur.sorlcur_seqno%TYPE := NULL;
        l_current_term       VARCHAR2(6);
        lfos_rowid           VARCHAR2(18);
        curr_err             NUMBER := NULL;
        lv_lcur_seqno        sorlcur.sorlcur_seqno%TYPE;
        lv_sorlfos_seqno_cnt sorlfos.sorlfos_seqno%TYPE;
        severity_level       VARCHAR2(1) := NULL;
        l_lfos_seqno         sorlfos.sorlfos_seqno%TYPE;
        l_new_major          VARCHAR2(6) := NULL;
        l_end_date           VARCHAR2(6);
        l_effect_term        VARCHAR2(6) := NULL;
        l_new_lfos_rule      sorlfos.sorlfos_lfos_rule%TYPE;
        l_end_term           VARCHAR2(10);
        sorlcur_l_end_term   VARCHAR2(10);
        v_rowid_varchar      VARCHAR2(18);
        v_styp_code          sgbstdn.sgbstdn_styp_code%TYPE;
        v_stst_code          sgbstdn.sgbstdn_stst_code%TYPE;
        v_egol_code          sgbstdn.sgbstdn_egol_code%TYPE;
        d_out_rowid          VARCHAR2(18);

        BEGIN
            dbms_output.put_line('Entered adt Process');
            SELECT avc.get_current_term()
            INTO l_current_term
            FROM dual;

            dbms_output.put_line('576 l_current_term: ' || l_current_term);

            IF get_current_term LIKE '%50%' OR get_current_term LIKE '%10%' THEN
                BEGIN
                    SELECT
                        CASE
                            WHEN get_current_term LIKE '%50%' THEN
                                replace(get_current_term, '50', '70')
                            WHEN get_current_term LIKE '%10%' THEN
                                replace(get_current_term, '10', '30')
                            ELSE
                                NULL
                        END
                    INTO l_end_date
                    FROM dual;

                    dbms_output.put_line('592 Result4: ' || 'l_end_date: ' || l_end_date || 'get_current_term: ' || get_current_term);

                    BEGIN
                        SELECT sgbstdn_term_code_eff
                        INTO l_effect_term
                        FROM sgbstdn
                        WHERE sgbstdn_pidm = pidm
                              AND sgbstdn_term_code_admit = l_end_date;

                    EXCEPTION
                        WHEN no_data_found THEN
                            BEGIN
                                dbms_output.put_line('604 Exception Result Start: ' || ' l_effect_term: ' || l_effect_term || ' l_current_term: ' || l_current_term);
                                SELECT sgbstdn_term_code_eff
                                INTO l_effect_term
                                FROM sgbstdn
                                WHERE sgbstdn_pidm = pidm
                                    AND sgbstdn_term_code_admit = l_current_term;

                                dbms_output.put_line('611 Exception Result End: ' || ' l_effect_term: ' || l_effect_term);
                            EXCEPTION
                                WHEN no_data_found THEN
                                    l_effect_term := NULL;
                            END;
                    END;

                    dbms_output.put_line('618 Result5: ' || 'l_effect_term: ' || l_effect_term);

                    IF l_effect_term IS NULL THEN
                        l_end_date := NULL;
                    END IF;

                    dbms_output.put_line('624 Result6: ' || 'l_effect_term: ' || l_effect_term);
                    dbms_output.put_line('625 Result7: ' || 'l_end_date: ' || l_end_date || 'get_current_term: ' || get_current_term);
                END;
            END IF;

            dbms_output.put_line('629 get_current_term: ' || get_current_term);

            IF get_current_term LIKE '%70%' THEN
                dbms_output.put_line('632 get_current_term: ' || get_current_term);
                BEGIN
                    SELECT sgbstdn_term_code_eff
                    INTO l_effect_term
                    FROM sgbstdn
                    WHERE sgbstdn_pidm = pidm
                        AND sgbstdn_term_code_admit = (SELECT to_char(TO_NUMBER(get_current_term) + 60) FROM dual);

                    dbms_output.put_line('640 l_effect_term: ' || l_effect_term);

                EXCEPTION
                    WHEN no_data_found THEN
                        dbms_output.put_line('644 Exception on line 642 lvl 1');
                        BEGIN
                            SELECT sgbstdn_term_code_eff
                            INTO l_effect_term
                            FROM sgbstdn
                            WHERE sgbstdn_pidm = pidm
                             AND sgbstdn_term_code_admit = (SELECT to_char(TO_NUMBER(get_current_term) + 40) FROM dual);

                            dbms_output.put_line('652 l_effect_term: ' || l_effect_term);

                        EXCEPTION
                            WHEN no_data_found THEN
                                dbms_output.put_line('656 Exception 1vl 2');
                                BEGIN
                                    SELECT sgbstdn_term_code_eff
                                    INTO l_effect_term
                                    FROM sgbstdn
                                    WHERE sgbstdn_pidm = pidm
                                        AND sgbstdn_term_code_admit = l_current_term;

                                    dbms_output.put_line('664 l_current_term: ' || l_current_term || ' l_effect_term: ' || l_effect_term);

                                EXCEPTION
                                    WHEN no_data_found THEN
                                        dbms_output.put_line('667 Exception 1vl 3');
                                        l_effect_term := NULL;
                                END;
                        END;
                END;
            END IF;

            IF get_current_term LIKE '%30%' THEN
                BEGIN
                    SELECT sgbstdn_term_code_eff
                    INTO l_effect_term
                    FROM sgbstdn
                    WHERE sgbstdn_pidm = pidm
                        AND sgbstdn_term_code_admit = (SELECT to_char(TO_NUMBER(get_current_term) + 20) FROM dual);

                EXCEPTION
                    WHEN no_data_found THEN
                     BEGIN
                        SELECT sgbstdn_term_code_eff
                        INTO l_effect_term
                        FROM sgbstdn
                        WHERE sgbstdn_pidm = pidm
                            AND sgbstdn_term_code_admit = (SELECT to_char(TO_NUMBER(get_current_term) + 40) FROM dual);

                    EXCEPTION
                        WHEN no_data_found THEN
                            BEGIN
                                SELECT sgbstdn_term_code_eff
                                INTO l_effect_term
                                FROM sgbstdn
                                WHERE sgbstdn_pidm = pidm
                                    AND sgbstdn_term_code_admit = l_current_term;

                                dbms_output.put_line('Result8: ' || l_effect_term || l_effect_term);

                            EXCEPTION
                                WHEN no_data_found THEN
                                    l_effect_term := NULL;
                            END;
                    END;
                END;
            END IF;

            dbms_output.put_line('l_effect_term: ' || to_char(l_effect_term));

            IF l_effect_term IS NULL THEN
                IF ((l_ab928_source LIKE 'SVREDGL' OR l_ab928_source LIKE 'UPSVREDG') AND ( get_current_term < l_current_term )) THEN
                    l_end_date := l_current_term;
                END IF;
            END IF;

            IF l_effect_term IS NOT NULL THEN
                IF ( ( get_current_term = l_current_term ) ) THEN
                    l_end_date := NULL;
                END IF;
            END IF;

            BEGIN
                dbms_output.put_line('726 l_end_date: ' || to_char(l_end_date) || 'get_current_term: ' || get_current_term  || 'pidm: ' || pidm);

                -- Step 1: Try fetching with l_end_date
                BEGIN
                    OPEN local_sorlcur(pidm, get_current_term, l_end_date);
                        LOOP
                            FETCH local_sorlcur INTO local_sorlcur_rec;
                            dbms_output.put_line('733 local_sorlcur_rec.sorlcur_seqno: ' || local_sorlcur_rec.sorlcur_seqno);
                            EXIT WHEN local_sorlcur%NOTFOUND;
                            dbms_output.put_line('735 local_sorlcur_rec.sorlcur_seqno' || local_sorlcur_rec.sorlcur_seqno);
                        END LOOP;
                        IF local_sorlcur%NOTFOUND THEN
                            RAISE no_data_found;
                        END IF;
                    CLOSE local_sorlcur;
                EXCEPTION
                    WHEN no_data_found THEN
                        CLOSE local_sorlcur;
                        -- Move to Step 2 if no data found
                        BEGIN
                            dbms_output.put_line('746 pidm: ' || pidm || 'get_current_term: ' || get_current_term || 'l_effect_term: ' || to_char(l_effect_term));
                            OPEN local_sorlcur(pidm, get_current_term, l_effect_term);
                                LOOP
                                    FETCH local_sorlcur INTO local_sorlcur_rec;
                                    EXIT WHEN local_sorlcur%NOTFOUND;
                                    dbms_output.put_line('751 local_sorlcur_rec.sorlcur_seqno' || local_sorlcur_rec.sorlcur_seqno);
                                END LOOP;
                                IF local_sorlcur%NOTFOUND THEN
                                    RAISE no_data_found;
                                END IF;
                            CLOSE local_sorlcur;
                        EXCEPTION
                            WHEN no_data_found THEN
                                CLOSE local_sorlcur;

                            -- Move to Step 3 if no data found
                            BEGIN
                            dbms_output.put_line('763 get_current_term: ' || get_current_term);
                            OPEN local_sorlcur(pidm, get_current_term, NULL);
                                LOOP
                                    FETCH local_sorlcur INTO local_sorlcur_rec;
                                    EXIT WHEN local_sorlcur%NOTFOUND;
                                    dbms_output.put_line('768 local_sorlcur_rec.sorlcur_seqno: ' || local_sorlcur_rec.sorlcur_seqno);
                                END LOOP;
                                IF local_sorlcur%NOTFOUND THEN
                                    RAISE no_data_found;
                                END IF;
                            CLOSE local_sorlcur;
                            EXCEPTION
                                WHEN no_data_found THEN
                                    CLOSE local_sorlcur;

                            -- Move to Step 4 if no data found
                                IF get_current_term LIKE '%70%' THEN
                                    BEGIN
                                        dbms_output.put_line('780 get_current_term: ' || get_current_term || ' l_effect_term: ' || l_effect_term);
                                        SELECT to_char(TO_NUMBER(get_current_term) + 40) INTO l_effect_term FROM dual;
                                        dbms_output.put_line('782 get_current_term: ' || get_current_term);
                                        OPEN local_sorlcur(pidm, get_current_term, l_effect_term);
                                        LOOP
                                            FETCH local_sorlcur INTO local_sorlcur_rec;
                                            EXIT WHEN local_sorlcur%NOTFOUND;
                                            dbms_output.put_line('787 local_sorlcur_rec.sorlcur_seqno: ' || local_sorlcur_rec.sorlcur_seqno);
                                        END LOOP;
                                        IF local_sorlcur%NOTFOUND THEN
                                            RAISE no_data_found;
                                        END IF;
                                        CLOSE local_sorlcur;
                                    EXCEPTION
                                        WHEN no_data_found THEN
                                            CLOSE local_sorlcur;
                                            -- Move to Step 5 if no data found
                                            IF get_current_term LIKE '%70%' THEN
                                                BEGIN
                                                    SELECT (get_current_term + 60) INTO l_effect_term FROM dual;
                                                    dbms_output.put_line('800 get_current_term: ' || get_current_term || ' l_effect_term: ' || l_effect_term);
                                                    OPEN local_sorlcur(pidm, get_current_term, l_effect_term);
                                                        LOOP
                                                            FETCH local_sorlcur INTO local_sorlcur_rec;
                                                            EXIT WHEN local_sorlcur%NOTFOUND;
                                                            dbms_output.put_line('805 local_sorlcur_rec.sorlcur_seqno' || local_sorlcur_rec.sorlcur_seqno);
                                                        END LOOP;
                                                        IF local_sorlcur%NOTFOUND THEN
                                                            RAISE no_data_found;
                                                        END IF;
                                                    CLOSE local_sorlcur;
                                                EXCEPTION
                                                    WHEN no_data_found THEN
                                                        CLOSE local_sorlcur;
                                                        log_error(sqlcode, sqlerrm, 'ndata');
                                                END;
                                            END IF;
                                    END;
                                END IF;
                            END;
                        END;
                END;

            EXCEPTION
                WHEN too_many_rows THEN
                    dbms_output.put_line('825 You got more than 1 row!');
                WHEN OTHERS THEN
                    log_error(sqlcode, sqlerrm, 'Sumanth');
                    dbms_output.put_line('828 Error!');
            END;


            OPEN local_sorlfos(pidm, local_sorlcur_rec.sorlcur_seqno);
                LOOP
                    FETCH local_sorlfos INTO local_sorlfos_rec;
                    EXIT WHEN local_sorlfos%notfound;
                END LOOP;
            CLOSE local_sorlfos;
            dbms_output.put_line('838 local_sorlfos_rec.sorlfos_majr_code' || local_sorlfos_rec.sorlfos_majr_code || 'pidm: ' || pidm || 'SORLFOS_LCUR_SEQNO: ' || local_sorlfos_rec.SORLFOS_LCUR_SEQNO);


            SELECT adt_major_code
            INTO l_new_major
            FROM adt_local_degree_mapping
            WHERE major_code = local_sorlfos_rec.sorlfos_majr_code;

            dbms_output.put_line('846 l_new_major: ' || to_char(l_new_major) || ' adt - term code: ' || local_sorlfos_rec.sorlfos_term_code);


            SELECT sorcmjr_cmjr_rule
            INTO l_new_lfos_rule
            FROM sorcmjr
            WHERE sorcmjr_majr_code = l_new_major
                AND sorcmjr_term_code_eff = (SELECT MAX(sorcmjr_term_code_eff) FROM sorcmjr
                                             WHERE sorcmjr_majr_code = l_new_major
                                             AND sorcmjr_term_code_eff <= local_sorlfos_rec.sorlfos_term_code);

            sorlcur_l_end_term := local_sorlcur_rec.sorlcur_term_code_end;


            IF ( l_ab928_source LIKE 'SVREDGL' OR l_ab928_source LIKE 'UPSVREDG' ) THEN
                sorlcur_l_end_term := l_current_term;
            END IF;

            lv_seqno := sb_curriculum_rules.f_seqno(local_sorlcur_rec.sorlcur_pidm);

            dbms_output.put_line('866 in l_new_lfos_rule' || to_char(l_new_lfos_rule) || local_sorlcur_rec.sorlcur_seqno);
            dbms_output.put_line('867 local_sorlcur_rec.sorlcur_term_code_end' || local_sorlcur_rec.sorlcur_term_code_end || local_sorlcur_rec.sorlcur_rolled_seqno);


            p_update_current(
                p_pidm => local_sorlcur_rec.sorlcur_pidm,
                p_seqno => local_sorlcur_rec.sorlcur_seqno,
                p_user_id => 'AB928',
                p_data_origin => local_sorlcur_rec.sorlcur_data_origin,
                p_current_cde => NULL,
                p_term_code_end => l_current_term,
                p_rowid => NULL);

            dbms_output.put_line('879 p_update_current after');


            p_upd_sorlfos_current_cde(
                p_pidm => local_sorlfos_rec.sorlfos_pidm,
                p_lcur_seqno => local_sorlfos_rec.sorlfos_lcur_seqno,
                p_lfos_seqno => local_sorlfos_rec.sorlfos_seqno,
                p_data_origin => local_sorlfos_rec.sorlfos_data_origin,
                p_user_id => 'AB928');

            dbms_output.put_line('889 sorlcur_l_end_term: ' || sorlcur_l_end_term);


            IF (( l_ab928_source LIKE 'SVREDGL' OR l_ab928_source LIKE 'UPSVREDG' ) AND ( get_current_term < l_current_term )) THEN
                BEGIN
                    OPEN local_learner(pidm, get_current_term);
                        LOOP
                            FETCH local_learner INTO local_learner_rec;
                            EXIT WHEN local_learner%notfound;
                        END LOOP;
                    CLOSE local_learner;

                    dbms_output.put_line( '901 l_current_term: ' || l_current_term);
                    dbms_output.put_line('902 IN');

                    sb_learner.p_copy_learner(
                        p_pidm => pidm,
                        p_term_code_old => get_current_term,
                        p_term_code_new => l_current_term);

                    --Added here
                    --- The inactive section we are looking for
                    sb_curriculum.p_create(
                        p_pidm => local_sorlcur_rec.sorlcur_pidm,
                        p_seqno => NULL,
                        p_lmod_code => 'LEARNER',
                        p_term_code => l_current_term,
                        p_key_seqno => 99,
                        p_priority_no => local_sorlcur_rec.sorlcur_priority_no,
                        p_roll_ind => local_sorlcur_rec.sorlcur_roll_ind,
                        p_cact_code => 'INACTIVE',
                        p_user_id => 'AB928',
                        p_data_origin => local_sorlcur_rec.sorlcur_data_origin,
                        p_levl_code => local_sorlcur_rec.sorlcur_levl_code,
                        p_coll_code => local_sorlcur_rec.sorlcur_coll_code,
                        p_degc_code => local_sorlcur_rec.sorlcur_degc_code,
                        p_term_code_ctlg => l_current_term, --local_sorlcur_rec.sorlcur_term_code_ctlg,
                        p_term_code_end => l_current_term, --local_sorlcur_rec.sorlcur_term_code_end,
                        p_camp_code => local_sorlcur_rec.sorlcur_camp_code,
                        p_program => local_sorlcur_rec.sorlcur_program,
                        p_term_code_matric => local_sorlcur_rec.sorlcur_term_code_matric,
                        p_term_code_admit => local_sorlcur_rec.sorlcur_term_code_admit,
                        p_admt_code => local_sorlcur_rec.sorlcur_admt_code,
                        p_curr_rule => local_sorlcur_rec.sorlcur_curr_rule,
                        p_site_code => local_sorlcur_rec.sorlcur_site_code,
                        p_rate_code => local_sorlcur_rec.sorlcur_rate_code,
                        p_leav_code => local_sorlcur_rec.sorlcur_leav_code,
                        p_leav_from_date => local_sorlcur_rec.sorlcur_leav_from_date,
                        p_leav_to_date => local_sorlcur_rec.sorlcur_leav_to_date,
                        p_acyr_code => local_sorlcur_rec.sorlcur_acyr_code,
                        p_term_code_grad => local_sorlcur_rec.sorlcur_term_code_grad,
                        p_exp_grad_date => local_sorlcur_rec.sorlcur_exp_grad_date,
                        p_styp_code => local_sorlcur_rec.sorlcur_styp_code,
                        p_appl_key_seqno => NULL,
                        p_appl_seqno => local_sorlcur_rec.sorlcur_rolled_seqno,
                        p_rolled_seqno => NULL,
                        p_gapp_seqno => local_sorlcur_rec.sorlcur_gapp_seqno,
                        p_rowid_out => lfos_rowid,
                        p_curr_error_out => curr_err,
                        p_seqno_out => lv_lcur_seqno,
                        p_override_severity => 'N',
                        p_severity_out => severity_level,
                        p_current_cde => NULL
                        );

                    sb_fieldofstudy.p_create(
                        p_pidm => local_sorlfos_rec.sorlfos_pidm,
                        p_lcur_seqno => lv_lcur_seqno,
                        p_seqno => NULL,
                        p_lfst_code => local_sorlfos_rec.sorlfos_lfst_code,
                        p_term_code => l_current_term, --local_sorlfos_rec.sorlfos_term_code,
                        p_priority_no => local_sorlfos_rec.sorlfos_priority_no,
                        p_csts_code => 'CHANGED',
                        p_cact_code => 'INACTIVE',
                        p_data_origin => local_sorlfos_rec.sorlfos_data_origin,
                        p_user_id => 'AB928',
                        p_majr_code => local_sorlfos_rec.sorlfos_majr_code,
                        p_dept_code => local_sorlfos_rec.sorlfos_dept_code,
                        p_term_code_ctlg => l_current_term, --local_sorlfos_rec.sorlfos_term_code_ctlg,
                        p_lfos_rule => local_sorlfos_rec.sorlfos_lfos_rule,
                        p_conc_attach_rule => local_sorlfos_rec.sorlfos_conc_attach_rule,
                        p_rolled_seqno => NULL,
                        p_term_code_end => local_sorlfos_rec.sorlfos_term_code_end,
                        p_start_date => local_sorlfos_rec.sorlfos_start_date,
                        p_end_date => local_sorlfos_rec.sorlfos_end_date,
                        p_tmst_code => local_sorlfos_rec.sorlfos_tmst_code,
                        p_majr_code_attach => local_sorlfos_rec.sorlfos_majr_code_attach,
                        p_rowid_out => lfos_rowid,
                        p_curr_error_out => curr_err,
                        p_override_severity => 'N', p_severity_out => severity_level,
                        p_lfos_seqno_out => l_lfos_seqno,
                        p_current_cde => NULL
                        );
                    --- The inactive section we are looking for
                    -- End add

                    -- Active
                    sb_curriculum.p_create(
                        p_pidm => local_sorlcur_rec.sorlcur_pidm,
                        p_seqno => NULL,
                        p_lmod_code => 'LEARNER',
                        p_term_code => l_current_term,
                        p_key_seqno => 99,
                        p_priority_no => local_sorlcur_rec.sorlcur_priority_no,
                        p_roll_ind => 'Y',
                        p_cact_code => 'ACTIVE',
                        p_user_id => 'AB928',
                        p_data_origin => local_sorlcur_rec.sorlcur_data_origin,
                        p_levl_code => local_sorlcur_rec.sorlcur_levl_code,
                        p_coll_code => local_sorlcur_rec.sorlcur_coll_code,
                        p_degc_code => 'AS',
                        p_term_code_ctlg => l_current_term,
                        p_term_code_end => NULL,
                        p_camp_code => local_sorlcur_rec.sorlcur_camp_code,
                        p_program => 'AS',
                        p_term_code_matric => NULL,
                        p_term_code_admit => local_sorlcur_rec.sorlcur_term_code_admit,
                        p_admt_code => local_sorlcur_rec.sorlcur_admt_code,
                        p_curr_rule => local_sorlcur_rec.sorlcur_curr_rule,
                        p_site_code => NULL,
                        p_rate_code => NULL,
                        p_leav_code => NULL,
                        p_leav_from_date => NULL,
                        p_leav_to_date => NULL,
                        p_acyr_code => NULL,
                        p_term_code_grad => NULL,
                        p_exp_grad_date => NULL,
                        p_styp_code => local_sorlcur_rec.sorlcur_styp_code,
                        p_appl_key_seqno => NULL,
                        p_appl_seqno => NULL,
                        p_rolled_seqno => NULL,
                        p_gapp_seqno => NULL,
                        p_rowid_out => lfos_rowid,
                        p_curr_error_out => curr_err,
                        p_seqno_out => lv_lcur_seqno,
                        p_override_severity => 'N',
                        p_severity_out => severity_level,
                        p_current_cde => 'Y');  -- CURRENT INDICATOR: Will be Y if this is the current curriculum, NULL if not.

                    sb_fieldofstudy.p_create(
                        p_pidm => local_sorlcur_rec.sorlcur_pidm,
                        p_lcur_seqno => lv_lcur_seqno,
                        p_seqno => NULL,
                        p_lfst_code => local_sorlfos_rec.sorlfos_lfst_code,
                        p_term_code => l_current_term,
                        p_priority_no => local_sorlfos_rec.sorlfos_priority_no,
                        p_csts_code => 'INPROGRESS',
                        p_cact_code => 'ACTIVE',
                        p_data_origin => local_sorlfos_rec.sorlfos_data_origin,
                        p_user_id => 'AB928',
                        p_majr_code => l_new_major,
                        p_dept_code => local_sorlfos_rec.sorlfos_dept_code,
                        p_term_code_ctlg => l_current_term,
                        p_lfos_rule => l_new_lfos_rule,
                        p_conc_attach_rule => local_sorlfos_rec.sorlfos_conc_attach_rule,
                        p_rolled_seqno => NULL,
                        p_term_code_end => NULL,
                        p_start_date => local_sorlfos_rec.sorlfos_start_date,
                        p_end_date => local_sorlfos_rec.sorlfos_end_date,
                        p_tmst_code => local_sorlfos_rec.sorlfos_tmst_code,
                        p_majr_code_attach => local_sorlfos_rec.sorlfos_majr_code_attach,
                        p_rowid_out => lfos_rowid,
                        p_curr_error_out => curr_err,
                        p_override_severity => 'N',
                        p_severity_out => severity_level,
                        p_lfos_seqno_out => l_lfos_seqno,
                        p_current_cde => 'Y'); --CURRENT INDICATOR: Will be Y if this is the current curriculum, NULL if not.
                    -- Active

                    dbms_output.put_line('1058 sb_curriculum.p_create');
                    dbms_output.put_line('1059 lv_lcur_seqno ' || 'lv_lcur_seqno: ' || lv_lcur_seqno);

                    SELECT
                        sgbstdn_styp_code,
                        sgbstdn_stst_code,
                        sgbstdn_egol_code
                    INTO
                        v_styp_code,
                        v_stst_code,
                        v_egol_code
                    FROM
                        sgbstdn
                    WHERE
                        sgbstdn_term_code_eff = get_current_term
                        AND sgbstdn_pidm = local_sorlcur_rec.sorlcur_pidm;

                    soklcur.p_backload_curr(
                        p_lmod => local_sorlcur_rec.sorlcur_lmod_code,
                        p_term_code => local_sorlcur_rec.sorlcur_term_code,
                        p_keyseqno => 99,
                        p_pidm => local_sorlcur_rec.sorlcur_pidm);

                    UPDATE ab928_staging_data
                    SET ab928_adt_processed = 2
                    WHERE ab928_pidm = pidm;

                    COMMIT;

                    dbms_output.put_line('1087 sb_fieldofstudy.p_create');

                END;


            ELSE
                BEGIN

                    dbms_output.put_line('1095 sb_curriculum.p_create');
                    dbms_output.put_line('1096 lv_lcur_seqno: ' || lv_lcur_seqno);

                    --- Inactive we are looking for
                    sb_curriculum.p_create(
                        p_pidm => local_sorlcur_rec.sorlcur_pidm,
                        p_seqno => NULL,
                        p_lmod_code => 'LEARNER',
                        p_term_code => local_sorlcur_rec.sorlcur_term_code,
                        p_key_seqno => 99,
                        p_priority_no => local_sorlcur_rec.sorlcur_priority_no,
                        p_roll_ind => local_sorlcur_rec.sorlcur_roll_ind,
                        p_cact_code => 'INACTIVE',
                        p_user_id => 'AB928',
                        p_data_origin => local_sorlcur_rec.sorlcur_data_origin,
                        p_levl_code => local_sorlcur_rec.sorlcur_levl_code,
                        p_coll_code => local_sorlcur_rec.sorlcur_coll_code,
                        p_degc_code => local_sorlcur_rec.sorlcur_degc_code,
                        p_term_code_ctlg => local_sorlcur_rec.sorlcur_term_code_ctlg,
                        p_term_code_end => local_sorlcur_rec.sorlcur_term_code_end,
                        p_camp_code => local_sorlcur_rec.sorlcur_camp_code,
                        p_program => local_sorlcur_rec.sorlcur_program,
                        p_term_code_matric => local_sorlcur_rec.sorlcur_term_code_matric,
                        p_term_code_admit => local_sorlcur_rec.sorlcur_term_code_admit,
                        p_admt_code => local_sorlcur_rec.sorlcur_admt_code,
                        p_curr_rule => local_sorlcur_rec.sorlcur_curr_rule,
                        p_site_code => local_sorlcur_rec.sorlcur_site_code,
                        p_rate_code => local_sorlcur_rec.sorlcur_rate_code,
                        p_leav_code => local_sorlcur_rec.sorlcur_leav_code,
                        p_leav_from_date => local_sorlcur_rec.sorlcur_leav_from_date,
                        p_leav_to_date => local_sorlcur_rec.sorlcur_leav_to_date,
                        p_acyr_code => local_sorlcur_rec.sorlcur_acyr_code,
                        p_term_code_grad => local_sorlcur_rec.sorlcur_term_code_grad,
                        p_exp_grad_date => local_sorlcur_rec.sorlcur_exp_grad_date,
                        p_styp_code => local_sorlcur_rec.sorlcur_styp_code,
                        p_appl_key_seqno => NULL,
                        p_appl_seqno => local_sorlcur_rec.sorlcur_rolled_seqno,
                        p_rolled_seqno => NULL,
                        p_gapp_seqno => local_sorlcur_rec.sorlcur_gapp_seqno,
                        p_rowid_out => lfos_rowid,
                        p_curr_error_out => curr_err,
                        p_seqno_out => lv_lcur_seqno,
                        p_override_severity => 'N',
                        p_severity_out => severity_level,
                        p_current_cde => NULL
                        );

                    sb_fieldofstudy.p_create(
                        p_pidm => local_sorlfos_rec.sorlfos_pidm,
                        p_lcur_seqno => lv_lcur_seqno,
                        p_seqno => NULL,
                        p_lfst_code => local_sorlfos_rec.sorlfos_lfst_code,
                        p_term_code => local_sorlfos_rec.sorlfos_term_code,
                        p_priority_no => local_sorlfos_rec.sorlfos_priority_no,
                        p_csts_code => 'CHANGED',
                        p_cact_code => 'INACTIVE',
                        p_data_origin => local_sorlfos_rec.sorlfos_data_origin,
                        p_user_id => 'AB928',
                        p_majr_code => local_sorlfos_rec.sorlfos_majr_code,
                        p_dept_code => local_sorlfos_rec.sorlfos_dept_code,
                        p_term_code_ctlg => local_sorlfos_rec.sorlfos_term_code_ctlg,
                        p_lfos_rule => local_sorlfos_rec.sorlfos_lfos_rule,
                        p_conc_attach_rule => local_sorlfos_rec.sorlfos_conc_attach_rule,
                        p_rolled_seqno => NULL,
                        p_term_code_end => local_sorlfos_rec.sorlfos_term_code_end,
                        p_start_date => local_sorlfos_rec.sorlfos_start_date,
                        p_end_date => local_sorlfos_rec.sorlfos_end_date,
                        p_tmst_code => local_sorlfos_rec.sorlfos_tmst_code,
                        p_majr_code_attach => local_sorlfos_rec.sorlfos_majr_code_attach,
                        p_rowid_out => lfos_rowid,
                        p_curr_error_out => curr_err,
                        p_override_severity => 'N', p_severity_out => severity_level,
                        p_lfos_seqno_out => l_lfos_seqno,
                        p_current_cde => NULL
                        );
                    --- Inactive we are looking for

                    sb_curriculum.p_create(
                        p_pidm => local_sorlcur_rec.sorlcur_pidm,
                        p_seqno => NULL,
                        p_lmod_code => 'LEARNER',
                        p_term_code => local_sorlcur_rec.sorlcur_term_code,
                        p_key_seqno => 99,
                        p_priority_no => local_sorlcur_rec.sorlcur_priority_no,
                        p_roll_ind => 'Y',
                        p_cact_code => 'ACTIVE',
                        p_user_id => 'AB928',
                        p_data_origin => local_sorlcur_rec.sorlcur_data_origin,
                        p_levl_code => local_sorlcur_rec.sorlcur_levl_code,
                        p_coll_code => local_sorlcur_rec.sorlcur_coll_code,
                        p_degc_code => 'AS',
                        p_term_code_ctlg => local_sorlcur_rec.sorlcur_term_code_ctlg,
                        p_camp_code => local_sorlcur_rec.sorlcur_camp_code,
                        p_program => 'AS',
                        p_term_code_matric => NULL,
                        p_term_code_admit => local_sorlcur_rec.sorlcur_term_code_admit,
                        p_admt_code => local_sorlcur_rec.sorlcur_admt_code,
                        p_curr_rule => local_sorlcur_rec.sorlcur_curr_rule,
                        p_site_code => NULL,
                        p_rate_code => NULL,
                        p_leav_code => NULL,
                        p_leav_from_date => NULL,
                        p_leav_to_date => NULL,
                        p_acyr_code => NULL,
                        p_term_code_grad => NULL,
                        p_exp_grad_date => NULL,
                        p_styp_code => local_sorlcur_rec.sorlcur_styp_code,
                        p_appl_key_seqno => NULL,
                        p_appl_seqno => NULL,
                        p_rolled_seqno => NULL,
                        p_gapp_seqno => NULL,
                        p_rowid_out => lfos_rowid,
                        p_curr_error_out => curr_err,
                        p_seqno_out => lv_lcur_seqno,
                        p_override_severity => 'N',
                        p_severity_out => severity_level,
                        p_current_cde => 'Y'
                                          );

                    sb_fieldofstudy.p_create(
                        p_pidm => local_sorlcur_rec.sorlcur_pidm,
                        p_lcur_seqno => lv_lcur_seqno,
                        p_seqno => NULL,
                        p_lfst_code => local_sorlfos_rec.sorlfos_lfst_code,
                        p_term_code => local_sorlfos_rec.sorlfos_term_code,
                        p_priority_no => local_sorlfos_rec.sorlfos_priority_no,
                        p_csts_code => 'INPROGRESS',
                        p_cact_code => 'ACTIVE',
                        p_data_origin => local_sorlfos_rec.sorlfos_data_origin,
                        p_user_id => 'AB928',
                        p_majr_code => l_new_major,
                        p_dept_code => local_sorlfos_rec.sorlfos_dept_code,
                        p_term_code_ctlg => local_sorlfos_rec.sorlfos_term_code_ctlg,
                        p_lfos_rule => l_new_lfos_rule,
                        p_conc_attach_rule => local_sorlfos_rec.sorlfos_conc_attach_rule,
                        p_rolled_seqno => NULL,
                        p_term_code_end => NULL,
                        p_start_date => local_sorlfos_rec.sorlfos_start_date,
                        p_end_date => local_sorlfos_rec.sorlfos_end_date,
                        p_tmst_code => local_sorlfos_rec.sorlfos_tmst_code,
                        p_majr_code_attach => local_sorlfos_rec.sorlfos_majr_code_attach,
                        p_rowid_out => lfos_rowid,
                        p_curr_error_out => curr_err,
                        p_override_severity => 'N',
                        p_severity_out => severity_level,
                        p_lfos_seqno_out => l_lfos_seqno,
                        p_current_cde => 'Y'
                        );

                    soklcur.p_backload_curr(
                        p_lmod => local_sorlcur_rec.sorlcur_lmod_code,
                        p_term_code => local_sorlcur_rec.sorlcur_term_code,
                        p_keyseqno => 99,
                        p_pidm => local_sorlcur_rec.sorlcur_pidm
                        );

                    dbms_output.put_line('1251 BEFORE UPDATE');

                    UPDATE ab928_staging_data
                    SET ab928_adt_processed = 2
                    WHERE ab928_pidm = pidm
                        AND ab928_term_code_eff = get_current_term;


                    COMMIT;
                END;
        END IF;

        dbms_output.put_line('1263 p_sendemail ' || 'pidm: ' || pidm || 'get_current_term: ' || get_current_term);
        p_sendemail(pidm, get_current_term);

        dbms_output.put_line('1266 sorlcur_seqno' || to_char(local_sorlcur_rec.sorlcur_seqno));

    EXCEPTION
        WHEN no_data_found THEN
            log_error(sqlcode, sqlerrm, 'performing adt');
    END adt_process;

    PROCEDURE getmajorcodeandadt IS

        major_code_local VARCHAR2(20);
        majormatch       INTEGER;
        l_end_date_test  VARCHAR2(10);
        l_effect_term    VARCHAR2(10);
        l_effectsv_term  VARCHAR2(10);
        l_current_term   VARCHAR2(10);

    BEGIN
        majormatch := 0;
        OPEN student_cursor_adt_ab928;
            LOOP
                FETCH student_cursor_adt_ab928 INTO student_adt_rec;
                EXIT WHEN student_cursor_adt_ab928%notfound;
            END LOOP;
        CLOSE student_cursor_adt_ab928;

        OPEN adt_local_degree_cursor;
            LOOP
                FETCH adt_local_degree_cursor INTO local_degree_rec;
                EXIT WHEN adt_local_degree_cursor%notfound;
            END LOOP;
        CLOSE adt_local_degree_cursor;

        FOR stagingdata IN student_cursor_adt_ab928 LOOP
            dbms_output.put_line('1299 ab928_pidm: ' || to_char(stagingdata.ab928_pidm));
            dbms_output.put_line('1300 ab928_term_code_eff: ' || to_char(stagingdata.ab928_term_code_eff));
            BEGIN
                SELECT
                    sgbstdn_majr_code_1
                INTO major_code_local
                FROM
                    (SELECT a1.sgbstdn_majr_code_1 FROM sgbstdn a1
                        WHERE a1.sgbstdn_pidm = stagingdata.ab928_pidm
                            AND a1.sgbstdn_term_code_eff = (SELECT MAX(a2.sgbstdn_term_code_eff) FROM sgbstdn a2
                                WHERE a1.sgbstdn_pidm = a2.sgbstdn_pidm
                                    AND a2.sgbstdn_term_code_eff <= stagingdata.ab928_term_code_eff)
                    )
                WHERE ROWNUM <= 1;

            EXCEPTION
                WHEN no_data_found THEN
                    BEGIN
                        SELECT sgbstdn_majr_code_1
                        INTO major_code_local
                        FROM (SELECT a1.sgbstdn_majr_code_1 FROM sgbstdn a1
                                WHERE a1.sgbstdn_pidm = stagingdata.ab928_pidm
                                    AND a1.sgbstdn_term_code_eff = (SELECT MAX(a2.sgbstdn_term_code_eff) FROM sgbstdn a2
                                        WHERE a1.sgbstdn_pidm = a2.sgbstdn_pidm
                                            AND a2.sgbstdn_term_code_eff <= (SELECT MAX(sgbstdn_term_code_eff) FROM sgbstdn
                                                WHERE sgbstdn_pidm = stagingdata.ab928_pidm)
                                                                   )
                             )
                        WHERE ROWNUM <= 1;

                        dbms_output.put_line('1329 major_code_local: ' || major_code_local);

                    EXCEPTION
                        WHEN no_data_found THEN
                            log_error(sqlcode, sqlerrm, 'major_code_local');
                    END;
            END;

            IF major_code_local IS NOT NULL THEN
    --dbms_output.put_line(to_char(major_code_local));
                FOR local_major IN adt_local_degree_cursor LOOP
                    dbms_output.put_line('1340 check');
                    dbms_output.put_line('1341 major_code: ' || to_char(local_major.major_code));
                    dbms_output.put_line('1342 major_code_local: ' || major_code_local);
                    IF local_major.major_code = major_code_local THEN
                        majormatch := 1;
                        dbms_output.put_line('1345 Success');
                    END IF;

                END LOOP;
            END IF;

            IF ( majormatch = 0 ) THEN
                dbms_output.put_line('1352 Hello major');
                UPDATE ab928_staging_data
                SET ab928_adt_processed = 1
                WHERE ab928_pidm = stagingdata.ab928_pidm
                    AND ab928_term_code_eff = stagingdata.ab928_term_code_eff;

                COMMIT;
            END IF;

            IF ( majormatch = 1 ) THEN
                IF ( stagingdata.ab928_source LIKE 'SGBSTDN' ) THEN
                    adt_process(stagingdata.ab928_pidm, stagingdata.ab928_term_code_eff, stagingdata.ab928_source);
                END IF;

                SELECT avc.get_current_term()
                INTO l_current_term
                FROM dual;

                IF (( stagingdata.ab928_source LIKE 'SVREDGL' OR stagingdata.ab928_source LIKE 'UPSVREDG' )
                    AND ( stagingdata.ab928_term_code_eff <= l_current_term )) THEN

                    dbms_output.put_line('1373 part1: ' || stagingdata.ab928_source);

                    BEGIN

                        SELECT sgbstdn_term_code_ctlg_1
                        INTO l_effectsv_term
                        FROM sgbstdn
                        WHERE sgbstdn_pidm = stagingdata.ab928_pidm
                            AND sgbstdn_term_code_eff = stagingdata.ab928_term_code_eff;

                    EXCEPTION

                        WHEN no_data_found THEN

                            BEGIN
                                SELECT sgbstdn_term_code_ctlg_1
                                INTO l_effectsv_term
                                FROM sgbstdn
                                WHERE sgbstdn_pidm = stagingdata.ab928_pidm
                                    AND sgbstdn_term_code_eff = (SELECT MAX(sgbstdn_term_code_eff) FROM sgbstdn
                                        WHERE sgbstdn_pidm = stagingdata.ab928_pidm);

                            EXCEPTION
                                WHEN no_data_found THEN
                                    l_effectsv_term := NULL;
                            END;
                    END;

                    dbms_output.put_line('1401 Result9: ' || 'l_effectsv_term: ' || l_effectsv_term || 'ab928_pidm: ' || stagingdata.ab928_pidm);

                    BEGIN
                        adt_process(stagingdata.ab928_pidm, l_effectsv_term, stagingdata.ab928_source);
                    EXCEPTION
                        WHEN OTHERS THEN
                            log_error(sqlcode, sqlerrm, 'in calling the process');
                    END;

                END IF;

                IF (stagingdata.ab928_source LIKE 'SVREDGL' OR stagingdata.ab928_source LIKE 'UPSVREDG')
                    AND ( stagingdata.ab928_term_code_eff LIKE '%50%' OR stagingdata.ab928_term_code_eff LIKE '%10%' )
                THEN
                    BEGIN
                        SELECT
                            CASE
                                WHEN stagingdata.ab928_term_code_eff LIKE '%50%' THEN
                                    replace(stagingdata.ab928_term_code_eff, '50', '70')
                                WHEN stagingdata.ab928_term_code_eff LIKE '%10%' THEN
                                    replace(stagingdata.ab928_term_code_eff, '10', '30')
                                ELSE
                                    NULL
                            END
                        INTO l_end_date_test
                        FROM dual;

                        dbms_output.put_line('1428 Result1: ' || ' ab928_term_code_eff: ' || stagingdata.ab928_term_code_eff || 'l_end_date_test: ' || l_end_date_test || 'l_current_term: ' || l_current_term);

                        BEGIN
                            SELECT sgbstdn_term_code_eff
                            INTO l_effect_term
                            FROM sgbstdn
                            WHERE sgbstdn_pidm = stagingdata.ab928_pidm
                                AND sgbstdn_term_code_admit = l_end_date_test;

                        EXCEPTION
                            WHEN no_data_found THEN
                                BEGIN
                                    SELECT to_char(TO_NUMBER(stagingdata.ab928_term_code_eff) + 40)
                                    INTO l_end_date_test
                                    FROM dual;

                                    SELECT sgbstdn_term_code_eff
                                    INTO l_effect_term
                                    FROM sgbstdn
                                    WHERE sgbstdn_pidm = stagingdata.ab928_pidm
                                        AND sgbstdn_term_code_admit = l_end_date_test;

                                EXCEPTION
                                    WHEN no_data_found THEN
                                        BEGIN
                                            SELECT to_char(TO_NUMBER(stagingdata.ab928_term_code_eff) + 60)
                                            INTO l_end_date_test
                                            FROM dual;

                                            SELECT sgbstdn_term_code_eff
                                            INTO l_effect_term
                                            FROM sgbstdn
                                            WHERE sgbstdn_pidm = stagingdata.ab928_pidm
                                                AND sgbstdn_term_code_admit = l_end_date_test;

                                        EXCEPTION
                                            WHEN no_data_found THEN
                                                BEGIN
                                                    SELECT to_char(TO_NUMBER(stagingdata.ab928_term_code_eff))
                                                    INTO l_end_date_test
                                                    FROM dual;

                                                    SELECT sgbstdn_term_code_eff
                                                    INTO l_effect_term
                                                    FROM sgbstdn
                                                    WHERE sgbstdn_pidm = stagingdata.ab928_pidm
                                                        AND sgbstdn_term_code_admit = l_end_date_test;

                                                EXCEPTION
                                                    WHEN no_data_found THEN
                                                        l_effect_term := NULL;
                                                END;
                                        END;
                                END;
                        END;

                        dbms_output.put_line('1484 Result51: ' || 'l_effect_term: ' || l_effect_term || 'ab928_term_code_eff: ' || stagingdata.ab928_term_code_eff);
                        dbms_output.put_line('1485 l_current_term: ' || l_current_term || 'l_end_date_test: ' || l_end_date_test);

                        IF ( l_effect_term IS NOT NULL ) AND ( stagingdata.ab928_term_code_eff <= l_current_term )
                        THEN adt_process(stagingdata.ab928_pidm, l_end_date_test, stagingdata.ab928_source);
                        END IF;

--                        IF
--                            ( l_effect_term IS  NULL )
--                            AND ( stagingdata.ab928_term_code_eff = l_current_term )
--                        THEN
--
--                            adt_process(stagingdata.ab928_pidm, l_end_date_test, stagingdata.ab928_source);
--
--                        END IF;




--        select SGBSTDN_TERM_CODE_EFF into l_effect_term from sgbstdn where SGBSTDN_PIDM=pidm and SGBSTDN_TERM_CODE_ADMIT=l_end_date_test;
--
                        dbms_output.put_line('1505 Result2: ' || 'l_effect_term: ' || l_effect_term);
                        dbms_output.put_line('1506 Result3: ' || 'l_end_date_test: ' || l_end_date_test || 'get_current_term: ' || get_current_term);
                    END;
                END IF;

                majormatch := 0;
            END IF;

        END LOOP;

            -- dbms_output.put_line(to_char(stagingdata.ab928_pidm));

    END getmajorcodeandadt;

    PROCEDURE p_sendemail (p_pidm NUMBER, p_term VARCHAR2) IS
        -- Email variables
        conn         utl_smtp.connection;
        msg_body     VARCHAR2(6000 CHAR);
        senderaddy   VARCHAR2(50 CHAR) := 'AVC Student Services <no-reply@avc.edu>';
        emailaddy    VARCHAR2(100 CHAR);
        stufullname  VARCHAR2(50 CHAR);
        stufirstname VARCHAR2(50 CHAR);
        termdesc     VARCHAR2(25 CHAR);
        acyr         VARCHAR2(9 CHAR);
    BEGIN
    -- Get student's email address
        BEGIN
            SELECT goremal_email_address
            INTO emailaddy
            FROM goremal
            WHERE goremal_pidm = p_pidm
                AND goremal_emal_code = 'AVC';

        EXCEPTION
            WHEN OTHERS THEN
                log_error(sqlcode, sqlerrm, 'email_not_fOUND');
        END;

        emailaddy := 'kimberly.covell@avc.edu';

    -- Get student's full name
        SELECT f_format_name(p_pidm, 'FL')
        INTO stufullname
        FROM dual;

    -- Get the term description
--    select stvterm_desc,
--           stvterm_acyr_code||'-'||(stvterm_acyr_code + 1)
--      into termDesc,
--           acyr
--      from stvterm
--     where stvterm_code = p_term;

    -- start building the email
        conn := demo_mail.begin_mail(sender => senderaddy, recipients => emailaddy, subject => 'Attention! Your Major has Changed.', mime_type => 'text/html');

--demo_mail.MULTIPART_MIME_TYPE
    -- message body
        msg_body := '<style type="text/css">'
                    || '  #main {'
                    || '    font-size: 14px; '
                    || '    font-family: Arial, "sans-serif"; '
                    || '    text-align: left; '
                    || '    padding-right: 10%; '
                    || '    padding-left: 10%'
                    || '  }'
                    || '</style>'
                    || '<div id="main">'
                    || '  <p><img src="https://www.avc.edu/sites/default/files/avclogocolor_sm.png" height="76px" width="225px" alt="AVC Logo"></p>'
                    || '  <p>Dear '
                    || stufullname
                    || ',</p>'
                    || '  <p>'
                    || '   Your major at Antelope Valley College was changed recently due to Assembly Bill 928 '
                    || '   becoming law on November 26, 2021. AB 928 helps students complete their transfer degree '
                    || '   in a timely manner while minimizing the accrual of excess units.'
                    || '  </p>'
                    || '  <p>Here is what you need to know:</p>'
                    || '  <ul>'
                    || '    <li>Administration of Justice (ADMJ) is now Administration of Justice for Transfer (ADJT).</li>'
                    || '    <li>Biology (BIOL) is now Biology for Transfer (BIOT).</li>'
                    || '    <li>Childhood and Family Education (CFE) is now Early Childhood Education for Transfer (ECET).</li>'
                    || '    <li>General Business (BUS) is now Business Administration 2.0 for Transfer (BUS2).</li>'
                    || '  </ul>'
                    || '  To understand how this affects your degree requirements, please schedule an appointment to meet with a Counselor to obtain an updated education plan.</p>'
                    || '  <p>You can make an appointment:</p>'
                    || '  <ul>'
                    || '    <li>In person on the second floor of the Student Services building.</li>'
                    || '    <li>By calling 661-722-6300, extension 6338.</li>'
                    || '    <li>Or emailing <a href="mailto:counseling@avc.edu">counseling@avc.edu</a>.</li>'
                    || '  </ul>'
                    || '  <p>We are here to help you!</p>'
                    || '  <p>Best regards,</p>'
                    || '  <p>Antelope Valley College</p>'
                    || '</div>';

        demo_mail.write_text(conn => conn, message => msg_body);
        demo_mail.end_mail(conn => conn);
    EXCEPTION
        WHEN OTHERS THEN
            log_error(sqlcode, sqlerrm, 'sEND_MAIL');
    END p_sendemail;

END ab928_impl;

