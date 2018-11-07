CREATE OR REPLACE PACKAGE ABFAPI_LOG_DTL IS
/****************************************************************************＊
-- Package Name : ABF_LOG_DTL
-- Meaning :
-- Creation Date : 2016-04-26
-- Created by API AUTO CREATOR
***************************************************************************＊*/
  PROCEDURE ins(
    I_ABF_LOG_ID IN NUMBER
    ,I_DTL_DESC IN NVARCHAR2
    ,I_UPD_DT IN DATE
    );
  PROCEDURE upd(
    I_LOG_DTL_ID IN NUMBER
    ,I_ABF_LOG_ID IN NUMBER
    ,I_DTL_DESC IN NVARCHAR2
    ,I_UPD_DT IN DATE
    );
  PROCEDURE del(
    I_LOG_DTL_ID IN NUMBER
    );
END ABFAPI_LOG_DTL;
/
