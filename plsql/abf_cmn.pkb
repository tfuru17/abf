CREATE OR REPLACE PACKAGE BODY abf_cmn IS
/****************************************************************************＊
-- Package Name : abf_cmn
-- Meaning : ABFの共通モジュールパッケージ
-- Creation Date : 2018-08-01
-- Created by TFURUKAW
***************************************************************************＊*/
--
  /****************************************************************************＊
  -- Procedure Name : err
  -- Meaning : 共通例外処理
  -- Creation Date : 2018-08-01
  -- Created by TFURUKAW
  -- 引数で受け取ったerror_trace,back_traceからメッセージを取得・出力
  ***************************************************************************＊*/
  PROCEDURE err(
    err_depth IN PLS_INTEGER    -- エラースタックにおける階層の深さ
    ,back_trace_depth IN PLS_INTEGER    -- バックトレースにおける階層の深さ
    ,subprg_unit IN VARCHAR2)    -- エラーが発生したプロシージャ
  IS
  BEGIN
    -- エラーメッセージの出力
    dbms_output.put_line('.... ERROR INFO ....');
    dbms_output.put_line(
         'PROC_NAME:' || subprg_unit || abf_c.cv_lf
--      || RPAD(err_depth, 5)
--      || RPAD(back_trace_depth, 9)
      || 'ERR_NUM  :' || utl_call_stack.error_number(err_depth) || abf_c.cv_lf
      || 'LINE_NUM :' || TO_CHAR(utl_call_stack.backtrace_line(back_trace_depth), '99099') || abf_c.cv_lf
      || 'ERR_MSG  :' || utl_call_stack.error_msg(err_depth)
      );
  EXCEPTION
    WHEN OTHERS THEN
      dbms_output.put_line(SQLERRM);
      RAISE;
  END err;
--
  /****************************************************************************＊
  -- Procedure Name : log
  -- Meaning : ログ出力処理
  -- Creation Date : 2018-08-01
  -- Created by TFURUKAW
  -- ABF_LOG_DTLのラッパー。ログ出力用。汎用マスタのログレベルに基づいて出力内容を制御
  -- ※未実装
  ***************************************************************************＊*/
  PROCEDURE log(iv_msg IN VARCHAR2)
  IS
  BEGIN
    -- dbms_scheduleのjob_idから、実行ユーザー情報を取得
    --
    -- 実行ユーザー情報から、汎用マスタのログレベル情報を取得し、出力内容を制御
    --
    -- メッセージの標準出力
    dbms_output.put_line(abfapi_logs.gn_abf_log_id || ':' || iv_msg);
    -- メッセージログ出力
    --
  END log;
--
  /****************************************************************************＊
  -- Procedure Name : init
  -- Meaning : 処理開始時　共通処理
  -- Creation Date : 2018-08-01
  -- Created by TFURUKAW
  ***************************************************************************＊*/
  PROCEDURE init(
    iv_job_name IN all_scheduler_job_log.job_name%TYPE
    ,iv_proc_name IN VARCHAR2)
  IS
  BEGIN
    -- ログ情報の出力
    abfapi_logs.ins(
      I_PROC_ID => NULL
      ,I_ORA_LOG_ID => abf_job.ora_log_id(iv_job_name)
      ,I_FUNC_NAME => iv_proc_name
      ,I_START_DT => SYSDATE
      ,I_STATUS => abf_c.cv_log_exec
--      ,I_RESULT IN NVARCHAR2
--      ,I_DESCRIPTION IN NVARCHAR2
      );
--    NULL;
  END init;
--
  /****************************************************************************＊
  -- Procedure Name : fin
  -- Meaning : 処理終了時　共通処理
  -- Creation Date : 2018-08-01
  -- Created by TFURUKAW
  ***************************************************************************＊*/
  PROCEDURE fin
  IS
  BEGIN
    -- ログ情報の出力
    abfapi_logs.upd(
      I_ABF_LOG_ID => abfapi_logs.gn_abf_log_id
      ,I_PROC_ID => abfapi_logs.gn_proc_id
      ,I_END_DT => SYSDATE
      ,I_STATUS => abf_c.cv_log_fin
      ,I_RESULT => abf_cmn.gv_status
      ,I_DESCRIPTION => abf_cmn.gv_result_description
      );
  END fin;
--
END abf_cmn;
/
