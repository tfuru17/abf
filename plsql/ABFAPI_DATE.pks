CREATE OR REPLACE PACKAGE ABFAPI_DATE IS
/****************************************************************************＊
-- Package Name : ABF_DATE
-- Meaning :
-- Creation Date : 2016-04-17
-- Created by API AUTO CREATOR
***************************************************************************＊*/
  PROCEDURE ins(
    I_DATE_TYPE IN NVARCHAR2
    ,I_DATE_VALUE IN DATE
    ,I_ENABLE_FLG IN NVARCHAR2
    );
  PROCEDURE upd(
    I_DATE_TYPE IN NVARCHAR2
    ,I_DATE_VALUE IN DATE
    ,I_ENABLE_FLG IN NVARCHAR2
    );
  PROCEDURE del(
    I_DATE_TYPE IN NVARCHAR2
    );
  FUNCTION get(
    I_DATE_TYPE IN NVARCHAR2
    ) RETURN DATE;
  PROCEDURE set_now(
    I_DATE_TYPE IN NVARCHAR2
    );
  PROCEDURE increase(
    I_DATE_TYPE IN NVARCHAR2
    );
  PROCEDURE disable(
    I_DATE_TYPE IN NVARCHAR2
    );
  PROCEDURE enable(
    I_DATE_TYPE IN NVARCHAR2
    );
END ABFAPI_DATE;
/
