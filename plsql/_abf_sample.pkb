CREATE OR REPLACE PACKAGE BODY ABF_SAMPLE_PKG IS
/****************************************************************************＊
-- Package Name : ABF_SAMPLE_PKG
-- Meaning : emp表から取得したデータをCSVファイルに出力するサンプルプログラム
--           →項目定義に基づいてemp表からemp_sample表にデータを移送するサンプルプログラム
-- Creation Date : 2016-05-03
-- Created by TFURUKAW
-- Update Date : 2018-10-07
-- Updated by TFURUKAW
***************************************************************************＊*/
--
  -- ローカル変数定義
--
  /****************************************************************************＊
  -- Procedure Name : output
  -- Meaning :
  -- Creation Date : 2016-05-03
  -- Created by TFURUKAW
  ***************************************************************************＊*/
--   PROCEDURE output(
--     iv_deptno IN emp.deptno%TYPE
--     )
--   IS
--     CURSOR cur_emp
--     IS
--     SELECT e.empno
--           ,e.ename
--           ,e.job
--           ,e.mgr
--           ,em.ename AS mgrname
--           ,e.hiredate
--           ,e.sal
--           ,e.comm
--           ,e.deptno
--           ,d.dname
--     FROM   emp e
--            LEFT OUTER JOIN emp em
--            ON e.mgr = em.empno
--            LEFT OUTER JOIN dept d
--            ON e.deptno = d.deptno
--     WHERE  e.deptno = NVL(iv_deptno, e.deptno)
--     ;
--     rec_emp cur_emp%ROWTYPE;
--   BEGIN
--     --
--     FOR rec_emp IN cur_emp
--     LOOP
--       dbms_output.put_line(rec_emp.empno || abf_c.cv_cm
--                         || rec_emp.ename || abf_c.cv_cm
--                         || rec_emp.job || abf_c.cv_cm
--                         || rec_emp.mgr || abf_c.cv_cm
--                         || rec_emp.mgrname || abf_c.cv_cm
--                         || rec_emp.hiredate || abf_c.cv_cm
--                         || rec_emp.deptno || abf_c.cv_cm
--                         || rec_emp.dname);
--     END LOOP;
--     --
--   EXCEPTION
--     WHEN OTHERS THEN
--       RAISE;
--   END output;
--
  /****************************************************************************＊
  -- Procedure Name : ctrl
  -- Meaning :
  -- Creation Date : 2018-07-14
  -- Created by TFURUKAW
  -- Update Date : 2018-10-07
  -- Updated by TFURUKAW
  ***************************************************************************＊*/
  PROCEDURE ctrl(
    iv_job_name IN all_scheduler_job_log.job_name%TYPE
    ,iv_item_mapping_mst IN abf_item_mapping_mst.mst_type%TYPE
    ,iv_prm1 IN VARCHAR2
    ,iv_prm2 IN VARCHAR2
    ,iv_prm3 IN VARCHAR2
    ,iv_prm4 IN VARCHAR2
    ,iv_prm5 IN VARCHAR2
    ,iv_prm6 IN VARCHAR2
    ,iv_prm7 IN VARCHAR2
    ,iv_prm8 IN VARCHAR2)
  IS
    lc_sql NCLOB;   -- SQL文字列(ログ出力用に一旦変数保持)
  BEGIN
    -- SQL文文字列の作成(INSERT-SELECT)
    abf_cmn.log('Mapping Master Type:' || iv_item_mapping_mst);
    lc_sql := abf_sql.ins_sel_sql(iv_item_mapping_mst);
--
    -- SQL文実行
    abf_cmn.log(lc_sql);
    CASE abf_job.prog_arg_count(iv_item_mapping_mst)
    WHEN 1 THEN
      EXECUTE IMMEDIATE TO_CLOB(lc_sql)
        USING iv_prm1;
    WHEN 2 THEN
      EXECUTE IMMEDIATE TO_CLOB(lc_sql)
        USING iv_prm1, iv_prm2;
    WHEN 3 THEN
      EXECUTE IMMEDIATE TO_CLOB(lc_sql)
        USING iv_prm1, iv_prm2, iv_prm3;
    WHEN 4 THEN
      EXECUTE IMMEDIATE TO_CLOB(lc_sql)
        USING iv_prm1, iv_prm2, iv_prm3, iv_prm4;
    WHEN 5 THEN
      EXECUTE IMMEDIATE TO_CLOB(lc_sql)
        USING iv_prm1, iv_prm2, iv_prm3, iv_prm4, iv_prm5;
    WHEN 6 THEN
      EXECUTE IMMEDIATE TO_CLOB(lc_sql)
        USING iv_prm1, iv_prm2, iv_prm3, iv_prm4, iv_prm5, iv_prm6;
    WHEN 7 THEN
      EXECUTE IMMEDIATE TO_CLOB(lc_sql)
        USING iv_prm1, iv_prm2, iv_prm3, iv_prm4, iv_prm5, iv_prm6, iv_prm7;
    WHEN 8 THEN
      EXECUTE IMMEDIATE TO_CLOB(lc_sql)
        USING iv_prm1, iv_prm2, iv_prm3, iv_prm4, iv_prm5, iv_prm6, iv_prm7, iv_prm8;
    ELSE
      EXECUTE IMMEDIATE TO_CLOB(lc_sql);
    END CASE;
--
  EXCEPTION
    WHEN OTHERS THEN
      abf_cmn.err(
        utl_call_stack.error_depth
        ,utl_call_stack.backtrace_depth
        ,utl_call_stack.concatenate_subprogram(utl_call_stack.subprogram(utl_call_stack.error_depth))
        );
      RAISE;
  END ctrl;
--
  /****************************************************************************＊
  -- Procedure Name : init
  -- Meaning :
  -- Creation Date : 2018-07-14
  -- Created by TFURUKAW
  -- Update Date : 2018-10-07
  -- Updated by TFURUKAW
  ***************************************************************************＊*/
  PROCEDURE init(
    iv_job_name IN all_scheduler_job_log.job_name%TYPE
    ,iv_item_mapping_mst IN abf_item_mapping_mst.mst_type%TYPE
    ,iv_prm1 IN VARCHAR2
    ,iv_prm2 IN VARCHAR2
    ,iv_prm3 IN VARCHAR2
    ,iv_prm4 IN VARCHAR2
    ,iv_prm5 IN VARCHAR2
    ,iv_prm6 IN VARCHAR2
    ,iv_prm7 IN VARCHAR2
    ,iv_prm8 IN VARCHAR2
    )
  IS
    t TIMESTAMP := SYSTIMESTAMP;
  BEGIN
    -- output start log
    abf_cmn.init(iv_job_name, iv_item_mapping_mst);
--
    -- parameter check.
    abf_cmn.log('start.');
    abf_cmn.log('prm1 : ' || iv_job_name);
    abf_cmn.log('prm2 : ' || iv_item_mapping_mst);
    abf_cmn.log('prm3 : ' || iv_prm1);
    abf_cmn.log('prm4 : ' || iv_prm2);
    abf_cmn.log('prm5 : ' || iv_prm3);
    abf_cmn.log('prm6 : ' || iv_prm4);
    abf_cmn.log('prm7 : ' || iv_prm5);
    abf_cmn.log('prm8 : ' || iv_prm6);
    abf_cmn.log('prm9 : ' || iv_prm7);
    abf_cmn.log('prm10: ' || iv_prm8);
--
    -- 5秒間待機
    WHILE SYSTIMESTAMP - t < INTERVAL '5' SECOND LOOP NULL; END LOOP;
--
  EXCEPTION
    WHEN OTHERS THEN
      abf_cmn.err(
        utl_call_stack.error_depth
        ,utl_call_stack.backtrace_depth
        ,utl_call_stack.concatenate_subprogram(utl_call_stack.subprogram(utl_call_stack.error_depth))
        );
      RAISE;
  END init;
--
  /****************************************************************************＊
  -- Procedure Name : fin
  -- Meaning :
  -- Creation Date : 2018-07-14
  -- Created by TFURUKAW
  -- Update Date : 2018-10-07
  -- Updated by TFURUKAW
  ***************************************************************************＊*/
  PROCEDURE fin
  IS
    t TIMESTAMP := SYSTIMESTAMP;
  BEGIN
    -- 
    WHILE SYSTIMESTAMP - t < INTERVAL '3' SECOND LOOP NULL; END LOOP;
--
    -- output start log
    abf_cmn.fin;
--
    -- 処理終了メッセージ
    abf_cmn.log('End.');
--
  EXCEPTION
    WHEN OTHERS THEN
      abf_cmn.err(
        utl_call_stack.error_depth
        ,utl_call_stack.backtrace_depth
        ,utl_call_stack.concatenate_subprogram(utl_call_stack.subprogram(utl_call_stack.error_depth))
        );
      RAISE;
  END fin;
--
  /****************************************************************************＊
  -- Procedure Name : main
  -- Meaning :
  -- Creation Date : 2016-05-03
  -- Created by TFURUKAW
  -- Update Date : 2018-10-07
  -- Updated by TFURUKAW
  ***************************************************************************＊*/
  PROCEDURE main(
    iv_job_name IN all_scheduler_job_log.job_name%TYPE
    ,iv_item_mapping_mst IN abf_item_mapping_mst.mst_type%TYPE
    ,iv_prm1 IN VARCHAR2 DEFAULT NULL
    ,iv_prm2 IN VARCHAR2 DEFAULT NULL
    ,iv_prm3 IN VARCHAR2 DEFAULT NULL
    ,iv_prm4 IN VARCHAR2 DEFAULT NULL
    ,iv_prm5 IN VARCHAR2 DEFAULT NULL
    ,iv_prm6 IN VARCHAR2 DEFAULT NULL
    ,iv_prm7 IN VARCHAR2 DEFAULT NULL
    ,iv_prm8 IN VARCHAR2 DEFAULT NULL
    )
  IS
  BEGIN
--
    -- 1.init.
    init(iv_job_name, iv_item_mapping_mst
        ,iv_prm1
        ,iv_prm2
        ,iv_prm3
        ,iv_prm4
        ,iv_prm5
        ,iv_prm6
        ,iv_prm7
        ,iv_prm8);
--
    -- 2.main
    ctrl(iv_job_name, iv_item_mapping_mst
        ,iv_prm1
        ,iv_prm2
        ,iv_prm3
        ,iv_prm4
        ,iv_prm5
        ,iv_prm6
        ,iv_prm7
        ,iv_prm8);
--    output(iv_deptno);
--
    -- 9.fin
    fin;
--
  EXCEPTION
    WHEN OTHERS THEN
      abf_cmn.err(
        utl_call_stack.error_depth
        ,utl_call_stack.backtrace_depth
        ,utl_call_stack.concatenate_subprogram(utl_call_stack.subprogram(utl_call_stack.error_depth))
        );
      RAISE;
  END main;
--
END ABF_SAMPLE_PKG;
/
