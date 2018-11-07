CREATE OR REPLACE PACKAGE abf_cmn IS
/****************************************************************************＊
-- Package Name : abf_cmn
-- Meaning : ABFの共通モジュールパッケージ
-- Creation Date : 2018-08-01
-- Created by TFURUKAW
***************************************************************************＊*/
--
  -- 共通変数
  gv_status abf_logs.result%TYPE := abf_c.cv_log_normal;
  gv_result_description abf_logs.description%TYPE;
--
  /****************************************************************************＊
  -- Procedure Name : err
  -- Meaning : 共通例外処理
  -- Creation Date : 2018-08-01
  -- Created by TFURUKAW
  -- 引数で受け取ったerror_trace,back_traceからメッセージを取得・出力
  ***************************************************************************＊*/
  PROCEDURE err(
    err_depth IN PLS_INTEGER,
    back_trace_depth IN PLS_INTEGER,
    subprg_unit IN VARCHAR2
    );
--
  /****************************************************************************＊
  -- Procedure Name : log
  -- Meaning : ログ出力処理
  -- Creation Date : 2018-08-01
  -- Created by TFURUKAW
  -- ABF_LOG_DTLのラッパー。ログ出力用。汎用マスタのログレベルに基づいて出力内容を制御
  ***************************************************************************＊*/
  PROCEDURE log(iv_msg IN VARCHAR2);
--
  /****************************************************************************＊
  -- Procedure Name : init
  -- Meaning : 共通例外処理
  -- Creation Date : 2018-08-01
  -- Created by TFURUKAW
  ***************************************************************************＊*/
  PROCEDURE init(
    iv_job_name IN all_scheduler_job_log.job_name%TYPE
    ,iv_proc_name IN VARCHAR2
    );
--
  /****************************************************************************＊
  -- Procedure Name : fin
  -- Meaning : 共通例外処理
  -- Creation Date : 2018-08-01
  -- Created by TFURUKAW
  ***************************************************************************＊*/
  PROCEDURE fin;
--
END abf_cmn;
/
