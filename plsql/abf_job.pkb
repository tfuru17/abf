CREATE OR REPLACE PACKAGE BODY abf_job
IS
/****************************************************************************＊
-- Package Name : abf_job
-- Meaning : ABFの共通ジョブ制御パッケージ
-- Creation Date : 2018-08-01
-- Created by TFURUKAW
***************************************************************************＊*/
  --============================================================================
  -- Variable define
  --============================================================================
  cv_mst_type_prog_name CONSTANT abf_gen_mst.mst_type%TYPE := 'PROGRAM_NAME';   -- 汎用マスタ定義
  cv_mst_type_prog_args CONSTANT abf_gen_mst.mst_type%TYPE := 'PROGRAM_ARGS';   -- 汎用マスタ定義
  cn_prog_arg_count CONSTANT NUMBER(3) := 10;       -- 有効業務パラメータ数
  cn_initial_param_count CONSTANT NUMBER(2) := 2;   -- システム用必須パラメータ数
  cv_job_type CONSTANT VARCHAR2(50) := 'STORED_PROCEDURE';
  cv_job_name_prefix CONSTANT VARCHAR2(10) := 'ABF$JOB_';
--
  /****************************************************************************＊
  -- Function Name : job_name
  -- Meaning : DBMS_SCHEDULERで使用するJOB_NAMEを生成
  ***************************************************************************＊*/
  FUNCTION job_name
  RETURN VARCHAR2
  IS
  BEGIN
    RETURN dbms_scheduler.generate_job_name(cv_job_name_prefix);
  END job_name;
--
  /****************************************************************************＊
  -- Function Name : ora_log_id
  -- Meaning :  ALL_SCHEDULER_JOB_LOGからのジョブ情報(log_id)取得
  ***************************************************************************＊*/
  FUNCTION ora_log_id(iv_job_name IN all_scheduler_job_log.job_name%TYPE)
  RETURN NUMBER
  IS
    CURSOR cur_log_id
    IS
    SELECT log_id
    FROM   all_scheduler_job_log
    WHERE  job_name = iv_job_name;
    ln_log_id NUMBER;
  BEGIN
    OPEN cur_log_id;
    FETCH cur_log_id INTO ln_log_id;
    CLOSE cur_log_id;
    RETURN ln_log_id;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN NULL;
  END ora_log_id;
--
  /****************************************************************************＊
  -- Function Name : prog_info
  -- Meaning : 汎用マスタ[PROGRAM_NAME]からパッケージ・プロシージャ名を取得
  ***************************************************************************＊*/
  FUNCTION prog_info(iv_proc_name IN VARCHAR2)
  RETURN VARCHAR2
  IS
    rec_pkg_info abfapi_gen_mst_dtl.cur_gen_mst%ROWTYPE;
  BEGIN
    rec_pkg_info := abfapi_gen_mst_dtl.get_rec(cv_mst_type_prog_name, iv_proc_name);
    RETURN rec_pkg_info.val1 || abf_c.cv_pd || rec_pkg_info.val2;
  END prog_info;
--
  /****************************************************************************＊
  -- Function Name : prog_arg_count
  -- Meaning : 汎用マスタ[PROGRAM_ARGS]から引数情報の件数を取得
  ***************************************************************************＊*/
  FUNCTION prog_arg_count(iv_proc_name IN VARCHAR2)
  RETURN NUMBER
  IS
    ln_arg_count NUMBER(3);
  BEGIN
    SELECT COUNT(*) INTO ln_arg_count
    FROM   abf_gen_mst_dtl
    WHERE  mst_type = cv_mst_type_prog_args
    AND    key1 = iv_proc_name;
--
    RETURN ln_arg_count;
  END prog_arg_count;
--
  /****************************************************************************＊
  -- Function Name : prog_arg_info
  -- Meaning : 汎用マスタ[PROGRAM_ARGS]から引数情報を取得
  ***************************************************************************＊*/
  FUNCTION prog_arg_info(iv_proc_name IN VARCHAR2, in_arg_num IN NUMBER)
  RETURN VARCHAR2
  IS
    rec_pkg_info abfapi_gen_mst_dtl.cur_gen_mst%ROWTYPE;
  BEGIN
    rec_pkg_info := abfapi_gen_mst_dtl.get_rec(cv_mst_type_prog_name, iv_proc_name, in_arg_num);
    RETURN rec_pkg_info.val1;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END prog_arg_info;
--
  /****************************************************************************＊
  -- Procedure Name : exec
  -- Meaning : ジョブ起動処理
  -- Creation Date : 2018-08-01
  -- Created by TFURUKAW
  -- 外部からPL/SQLプログラムを起動するためのプロシージャ
  -- 事前に汎用マスタ[PROGRAM_NAME]へプログラム登録が必要
  ***************************************************************************＊*/
  PROCEDURE exec(
    iv_proc_name IN VARCHAR2    -- 汎用マスタ[PROGRAM_NAME]に登録した処理名
    ,iv_arg1 IN VARCHAR2 DEFAULT NULL
    ,iv_arg2 IN VARCHAR2 DEFAULT NULL
    ,iv_arg3 IN VARCHAR2 DEFAULT NULL
    ,iv_arg4 IN VARCHAR2 DEFAULT NULL
    ,iv_arg5 IN VARCHAR2 DEFAULT NULL
    ,iv_arg6 IN VARCHAR2 DEFAULT NULL
    ,iv_arg7 IN VARCHAR2 DEFAULT NULL
    ,iv_arg8 IN VARCHAR2 DEFAULT NULL
    ,iv_arg9 IN VARCHAR2 DEFAULT NULL
    ,iv_arg10 IN VARCHAR2 DEFAULT NULL
  ) IS
    lv_job_name VARCHAR2(100);
    lv_arg_val  VARCHAR2(1000);
  BEGIN
    -- job_name関数から所定のルールに基づいたジョブ名を取得
    lv_job_name := job_name;
--
    -- ジョブの作成。パッケージ名・引数数は、処理名から汎用マスタを参照して取得
    -- enabledにはFALSEを指定し、この後で引数を指定してからrun_jobで実行
-- dbms_output.put_line(prog_info(iv_proc_name));
-- dbms_output.put_line(prog_arg_count(iv_proc_name));
    dbms_scheduler.create_job(
      job_name => lv_job_name,
      job_type => cv_job_type,
      job_action => prog_info(iv_proc_name), -- 'abf_sample_pkg.main',
      number_of_arguments => prog_arg_count(iv_proc_name) + cn_initial_param_count,
      enabled => FALSE,   -- 即時実行しない。一旦保留。
      auto_drop => TRUE); -- 処理が終わったら自動削除
--
    -- 引数の設定。
    FOR i IN 1..prog_arg_count(iv_proc_name) + cn_initial_param_count
    LOOP
      CASE i
        WHEN 1 THEN lv_arg_val := lv_job_name;
        WHEN 2 THEN lv_arg_val := iv_proc_name;
        WHEN 3 THEN lv_arg_val := iv_arg1;
        WHEN 4 THEN lv_arg_val := iv_arg2;
        WHEN 5 THEN lv_arg_val := iv_arg3;
        WHEN 6 THEN lv_arg_val := iv_arg4;
        WHEN 7 THEN lv_arg_val := iv_arg5;
        WHEN 8 THEN lv_arg_val := iv_arg6;
        WHEN 9 THEN lv_arg_val := iv_arg7;
        WHEN 10 THEN lv_arg_val := iv_arg8;
      END CASE;
      IF lv_arg_val IS NOT NULL THEN
        dbms_scheduler.set_job_argument_value(
          job_name => lv_job_name,
          argument_position => i,
          argument_value => lv_arg_val);
      END IF;
    END LOOP;
--
    -- 実行。TRUE:同一セッション、FALSE:別セッション
    dbms_scheduler.run_job(lv_job_name, FALSE);
    -- dbms_scheduler.run_job(lv_job_name, TRUE);
--
  END exec;
END abf_job;
/
