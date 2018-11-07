CREATE OR REPLACE PACKAGE ABFAPI_LOGS IS
/****************************************************************************＊
-- Package Name : ABF_LOGS
-- Meaning :
-- Creation Date : 2016-04-26
-- Created by API AUTO CREATOR
***************************************************************************＊*/
  PROCEDURE ins(
    I_PROC_ID IN NUMBER DEFAULT NULL
    ,I_ORA_LOG_ID IN NUMBER
    ,I_FUNC_NAME IN NVARCHAR2
    ,I_START_DT IN DATE
    ,I_STATUS IN NVARCHAR2
    ,I_RESULT IN NVARCHAR2 DEFAULT NULL
    ,I_DESCRIPTION IN NVARCHAR2 DEFAULT NULL
    );
  PROCEDURE upd(
    I_ABF_LOG_ID IN NUMBER
    ,I_PROC_ID IN NUMBER
    ,I_ORA_LOG_ID IN NUMBER DEFAULT NULL
    ,I_FUNC_NAME IN NVARCHAR2 DEFAULT NULL
    ,I_START_DT IN DATE DEFAULT NULL
    ,I_END_DT IN DATE
    ,I_STATUS IN NVARCHAR2 DEFAULT abf_c.cv_log_exec
    ,I_RESULT IN NVARCHAR2 DEFAULT NULL
    ,I_DESCRIPTION IN NVARCHAR2
    );
  PROCEDURE del(
    I_ABF_LOG_ID IN NUMBER
    );
--
  gn_abf_log_id abf_logs.abf_log_id%TYPE;  -- ABF_LOG_ID保持用グローバル変数
  gn_proc_id abf_logs.proc_id%TYPE;     -- PROC_ID保持用グローバル変数
--
END ABFAPI_LOGS;
/
