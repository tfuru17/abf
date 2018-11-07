CREATE OR REPLACE PACKAGE abf_job
IS
/****************************************************************************＊
-- Package Name : abf_job
-- Meaning : ABFの共通ジョブ制御パッケージ
-- Creation Date : 2018-08-01
-- Created by TFURUKAW
***************************************************************************＊*/
--
  /****************************************************************************＊
  -- Procedure Name : exec
  -- Meaning : ジョブ起動処理
  -- Creation Date : 2018-08-01
  -- Created by TFURUKAW
  -- 外部からPL/SQLプログラムを起動するためのプロシージャ
  -- 事前に汎用マスタへプログラム登録が必要
  ***************************************************************************＊*/
  PROCEDURE exec(
    iv_proc_name IN VARCHAR2
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
  );
--
  /****************************************************************************＊
  -- Function Name : ora_log_id
  -- Meaning :  ALL_SCHEDULER_JOB_LOGからのジョブ情報(log_id)取得
  ***************************************************************************＊*/
  FUNCTION ora_log_id(iv_job_name IN all_scheduler_job_log.job_name%TYPE)
  RETURN NUMBER;
--
  /****************************************************************************＊
  -- Function Name : prog_arg_count
  -- Meaning : 汎用マスタ[PROGRAM_ARGS]から引数情報の件数を取得
  ***************************************************************************＊*/
  FUNCTION prog_arg_count(iv_proc_name IN VARCHAR2)
  RETURN NUMBER;
--
END abf_job;
/
