CREATE OR REPLACE PACKAGE BODY ABFAPI_LOG_DTL IS
/****************************************************************************＊
-- Package Name : ABF_LOG_DTL
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
    I_ABF_LOG_ID IN NUMBER
    ,I_DTL_DESC IN NVARCHAR2
    ,I_UPD_DT IN DATE
    ) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    INSERT INTO ABF_LOG_DTL(
      LOG_DTL_ID
      ,ABF_LOG_ID
      ,DTL_DESC
      ,UPD_DT
    ) VALUES (
      ABF_LOG_DTL_SQ.NEXTVAL
      ,I_ABF_LOG_ID
      ,I_DTL_DESC
      ,I_UPD_DT
    );
    COMMIT;
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
    I_LOG_DTL_ID IN NUMBER
    ,I_ABF_LOG_ID IN NUMBER
    ,I_DTL_DESC IN NVARCHAR2
    ,I_UPD_DT IN DATE
    ) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    UPDATE ABF_LOG_DTL
    SET ABF_LOG_ID = I_ABF_LOG_ID
       ,DTL_DESC = I_DTL_DESC
       ,UPD_DT = I_UPD_DT
    WHERE LOG_DTL_ID = I_LOG_DTL_ID
    ;
    COMMIT;
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
    I_LOG_DTL_ID IN NUMBER
    ) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    DELETE ABF_LOG_DTL
    WHERE LOG_DTL_ID = I_LOG_DTL_ID
    ;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END del;
--
END ABFAPI_LOG_DTL;
/
