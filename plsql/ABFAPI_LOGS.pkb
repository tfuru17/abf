CREATE OR REPLACE PACKAGE BODY ABFAPI_LOGS IS
/****************************************************************************＊
-- Package Name : ABF_LOGS_API
-- Meaning :
-- Creation Date : 2016-04-26
-- Created by API AUTO CREATOR
***************************************************************************＊*/
/****************************************************************************＊
-- Procedure Name : ins
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
    ) IS
    BEGIN
      -- proc_idがNULLの場合は、所定のsequenceから取得し、グローバル変数に保持
      IF I_PROC_ID IS NULL THEN
        SELECT abf_logs_procid_sq.nextval
        INTO abfapi_logs.gn_proc_id
        FROM dual;
      END IF;
--
        SELECT abf_logs_sq.nextval
        INTO abfapi_logs.gn_abf_log_id
        FROM dual;

      -- insert.
      INSERT INTO ABF_LOGS(
        ABF_LOG_ID
        ,PROC_ID
        ,ORA_LOG_ID
        ,FUNC_NAME
        ,START_DT
        ,STATUS
        ,RESULT
        ,DESCRIPTION
        ,CREATE_USER
        ,CREATION_DATE
        ,UPDATE_USER
        ,UPDATE_DATE
      ) VALUES (
        abfapi_logs.gn_abf_log_id
        ,abfapi_logs.gn_proc_id
        ,I_ORA_LOG_ID
        ,I_FUNC_NAME
        ,I_START_DT
        ,I_STATUS
        ,I_RESULT
        ,I_DESCRIPTION
        ,abf_c.cv_app_user
        ,SYSDATE
        ,abf_c.cv_app_user
        ,SYSDATE
      );
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END ins;
--
/****************************************************************************＊
-- Procedure Name : upd
-- Meaning :
-- Creation Date : 2016-04-26
-- Created by API AUTO CREATOR
***************************************************************************＊*/
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
    ) IS
    BEGIN
      UPDATE ABF_LOGS
      SET PROC_ID = I_PROC_ID
         ,ORA_LOG_ID = NVL(I_ORA_LOG_ID, ORA_LOG_ID)
         ,FUNC_NAME = NVL(I_FUNC_NAME, FUNC_NAME)
         ,START_DT = NVL(I_START_DT, START_DT)
         ,END_DT = I_END_DT
         ,STATUS = NVL(I_STATUS, STATUS)
         ,RESULT = NVL(I_RESULT, RESULT)
         ,DESCRIPTION = I_DESCRIPTION
         ,UPDATE_USER = abf_c.cv_app_user
         ,UPDATE_DATE = SYSDATE
      WHERE ABF_LOG_ID = I_ABF_LOG_ID
      ;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END upd;
--
/****************************************************************************＊
-- Procedure Name : del
-- Meaning :
-- Creation Date : 2016-04-26
-- Created by API AUTO CREATOR
***************************************************************************＊*/
  PROCEDURE del(
    I_ABF_LOG_ID IN NUMBER
    ) IS
    BEGIN
      DELETE ABF_LOGS
      WHERE ABF_LOG_ID = I_ABF_LOG_ID
    ;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END del;
--
END ABFAPI_LOGS;
/
