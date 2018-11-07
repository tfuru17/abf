CREATE OR REPLACE PACKAGE BODY ABFAPI_DATE IS
/****************************************************************************＊
-- Package Name : ABF_DATE
-- Meaning :
-- Creation Date : 2016-04-19
-- Created by API AUTO CREATOR
***************************************************************************＊*/
/****************************************************************************＊
-- Procedure Name : ins
-- Meaning :
-- Creation Date : 2016-04-19
-- Created by API AUTO CREATOR
***************************************************************************＊*/
  PROCEDURE ins(
    I_DATE_TYPE IN NVARCHAR2
    ,I_DATE_VALUE IN DATE
    ,I_ENABLE_FLG IN NVARCHAR2
    ) IS
    BEGIN
      INSERT INTO ABF_DATE(
        DATE_TYPE
        ,DATE_VALUE
        ,ENABLE_FLG
        ,CREATION_DATE
        ,CREATE_USER
        ,UPDATE_DATE
        ,UPDATE_USER
      ) VALUES (
        I_DATE_TYPE
        ,I_DATE_VALUE
        ,I_ENABLE_FLG
        ,SYSDATE
        ,'ABF_USER'
        ,SYSDATE
        ,'ABF_USER'
      );
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END ins;
--
/****************************************************************************＊
-- Procedure Name : upd
-- Meaning :
-- Creation Date : 2016-04-19
-- Created by API AUTO CREATOR
***************************************************************************＊*/
  PROCEDURE upd(
    I_DATE_TYPE IN NVARCHAR2
    ,I_DATE_VALUE IN DATE
    ,I_ENABLE_FLG IN NVARCHAR2
    ) IS
    BEGIN
      UPDATE ABF_DATE
      SET    DATE_VALUE = NVL(I_DATE_VALUE, DATE_VALUE)
            ,ENABLE_FLG = NVL(I_ENABLE_FLG, ENABLE_FLG)
            ,UPDATE_DATE = SYSDATE
            ,UPDATE_USER = 'ABF_USER'
      WHERE  DATE_TYPE = I_DATE_TYPE
    ;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END upd;
--
/****************************************************************************＊
-- Procedure Name : del
-- Meaning :
-- Creation Date : 2016-04-19
-- Created by API AUTO CREATOR
***************************************************************************＊*/
  PROCEDURE del(
    I_DATE_TYPE IN NVARCHAR2
    ) IS
    BEGIN
      DELETE ABF_DATE
      WHERE  DATE_TYPE = I_DATE_TYPE
    ;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END del;
--
/****************************************************************************＊
-- Function Name : get
-- Meaning :
-- Creation Date : 2016-04-22
-- Created by API AUTO CREATOR
-- Update Date : 2018-04-30
-- Updated by tfurukaw
-- ※ enable_flg = 'N'の場合はNULLを戻す
***************************************************************************＊*/
  FUNCTION get(
    i_date_type IN NVARCHAR2
    ) RETURN DATE
  IS
    ld_date DATE;
  BEGIN
    -- GET date_value
    BEGIN
      SELECT date_value
      INTO   ld_date
      FROM   abf_date
      WHERE  date_type = i_date_type
      AND    enable_flg = abf_c.cv_yes;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RETURN NULL;
    END;
    -- RETURN
    RETURN ld_date;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END get;
--
/****************************************************************************＊
-- Procedure Name : set_now
-- Meaning :
-- Creation Date : 2016-04-22
-- Created by API AUTO CREATOR
***************************************************************************＊*/
  PROCEDURE set_now(
    i_date_type IN NVARCHAR2
    ) IS
    ld_date DATE;
  BEGIN
    upd(i_date_type, SYSDATE, abf_c.cv_yes);
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END set_now;
--
/****************************************************************************＊
-- Procedure Name : increase
-- Meaning : Set to one day later.
-- Creation Date : 2016-04-22
-- Created by API AUTO CREATOR
***************************************************************************＊*/
  PROCEDURE increase(
    i_date_type IN NVARCHAR2
    ) IS
    ld_date DATE;
  BEGIN
    upd(i_date_type, get(i_date_type) + 1, abf_c.cv_yes);
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END increase;
--
/****************************************************************************＊
-- Procedure Name : disable
-- Meaning :
-- Creation Date : 2016-04-22
-- Created by API AUTO CREATOR
***************************************************************************＊*/
  PROCEDURE disable(
    i_date_type IN NVARCHAR2
    ) IS
    ld_date DATE;
  BEGIN
    upd(i_date_type, NULL, abf_c.cv_no);
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END disable;
--
/****************************************************************************＊
-- Procedure Name : enable
-- Meaning :
-- Creation Date : 2016-04-22
-- Created by API AUTO CREATOR
***************************************************************************＊*/
  PROCEDURE enable(
    i_date_type IN NVARCHAR2
    ) IS
    ld_date DATE;
  BEGIN
    upd(i_date_type, NULL, abf_c.cv_yes);
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END enable;
--
END ABFAPI_DATE;
/
