CREATE OR REPLACE PACKAGE BODY ABFAPI_GEN_MST IS
/****************************************************************************＊
-- Package Name : ABF_GEN_MST
-- Meaning :
-- Creation Date : 2016-04-24
-- Created by API AUTO CREATOR
-- Update Date : 2018-04-30
-- Updated by tfurukaw
***************************************************************************＊*/
/****************************************************************************＊
-- Procedure Name : ins
-- Meaning :
-- Creation Date : 2016-04-24
-- Created by API AUTO CREATOR
-- Update Date : 2018-04-30
-- Updated by tfurukaw
***************************************************************************＊*/
  PROCEDURE ins(
    I_MST_TYPE IN NVARCHAR2
    ,I_DESCRIPTION IN NVARCHAR2
    ,I_ENABLE_FLG IN NVARCHAR2
    ,I_KEY1_MEANING IN NVARCHAR2
    ,I_KEY2_MEANING IN NVARCHAR2 DEFAULT CHR(0)
    ,I_KEY3_MEANING IN NVARCHAR2 DEFAULT CHR(0)
    ,I_KEY4_MEANING IN NVARCHAR2 DEFAULT CHR(0)
    ,I_KEY5_MEANING IN NVARCHAR2 DEFAULT CHR(0)
    ,I_VAL1_MEANING IN NVARCHAR2 DEFAULT CHR(0)
    ,I_VAL2_MEANING IN NVARCHAR2 DEFAULT CHR(0)
    ,I_VAL3_MEANING IN NVARCHAR2 DEFAULT CHR(0)
    ,I_VAL4_MEANING IN NVARCHAR2 DEFAULT CHR(0)
    ,I_VAL5_MEANING IN NVARCHAR2 DEFAULT CHR(0)
    ,I_VAL6_MEANING IN NVARCHAR2 DEFAULT CHR(0)
    ,I_VAL7_MEANING IN NVARCHAR2 DEFAULT CHR(0)
    ,I_VAL8_MEANING IN NVARCHAR2 DEFAULT CHR(0)
    ,I_VAL9_MEANING IN NVARCHAR2 DEFAULT CHR(0)
    ,I_VAL10_MEANING IN NVARCHAR2 DEFAULT CHR(0)
    ) IS
    BEGIN
      INSERT INTO ABF_GEN_MST(
        MST_TYPE
        ,DESCRIPTION
        ,ENABLE_FLG
        ,KEY1_MEANING
        ,KEY2_MEANING
        ,KEY3_MEANING
        ,KEY4_MEANING
        ,KEY5_MEANING
        ,VAL1_MEANING
        ,VAL2_MEANING
        ,VAL3_MEANING
        ,VAL4_MEANING
        ,VAL5_MEANING
        ,VAL6_MEANING
        ,VAL7_MEANING
        ,VAL8_MEANING
        ,VAL9_MEANING
        ,VAL10_MEANING
        ,CREATION_DATE
        ,CREATE_USER
        ,UPDATE_DATE
        ,UPDATE_USER
      ) VALUES (
         I_MST_TYPE
        ,I_DESCRIPTION
        ,I_ENABLE_FLG
        ,DECODE(I_KEY1_MEANING, CHR(0), NULL, I_KEY1_MEANING)
        ,DECODE(I_KEY2_MEANING, CHR(0), NULL, I_KEY2_MEANING)
        ,DECODE(I_KEY3_MEANING, CHR(0), NULL, I_KEY3_MEANING)
        ,DECODE(I_KEY4_MEANING, CHR(0), NULL, I_KEY4_MEANING)
        ,DECODE(I_KEY5_MEANING, CHR(0), NULL, I_KEY5_MEANING)
        ,DECODE(I_VAL1_MEANING, CHR(0), NULL, I_VAL1_MEANING)
        ,DECODE(I_VAL2_MEANING, CHR(0), NULL, I_VAL2_MEANING)
        ,DECODE(I_VAL3_MEANING, CHR(0), NULL, I_VAL3_MEANING)
        ,DECODE(I_VAL4_MEANING, CHR(0), NULL, I_VAL4_MEANING)
        ,DECODE(I_VAL5_MEANING, CHR(0), NULL, I_VAL5_MEANING)
        ,DECODE(I_VAL6_MEANING, CHR(0), NULL, I_VAL6_MEANING)
        ,DECODE(I_VAL7_MEANING, CHR(0), NULL, I_VAL7_MEANING)
        ,DECODE(I_VAL8_MEANING, CHR(0), NULL, I_VAL8_MEANING)
        ,DECODE(I_VAL9_MEANING, CHR(0), NULL, I_VAL9_MEANING)
        ,DECODE(I_VAL10_MEANING, CHR(0), NULL, I_VAL10_MEANING)
        ,SYSDATE
        ,abf_c.cv_app_user
        ,SYSDATE
        ,abf_c.cv_app_user
    );
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END ins;
--
/****************************************************************************＊
-- Procedure Name : upd
-- Meaning :
-- Creation Date : 2016-04-24
-- Created by API AUTO CREATOR
-- Update Date : 2018-04-30
-- Updated by tfurukaw
***************************************************************************＊*/
  PROCEDURE upd(
     I_MST_TYPE IN NVARCHAR2
    ,I_DESCRIPTION IN NVARCHAR2 DEFAULT CHR(0)
    ,I_ENABLE_FLG IN NVARCHAR2  DEFAULT CHR(0)
    ,I_KEY1_MEANING IN NVARCHAR2 DEFAULT CHR(0)
    ,I_KEY2_MEANING IN NVARCHAR2 DEFAULT CHR(0)
    ,I_KEY3_MEANING IN NVARCHAR2 DEFAULT CHR(0)
    ,I_KEY4_MEANING IN NVARCHAR2 DEFAULT CHR(0)
    ,I_KEY5_MEANING IN NVARCHAR2 DEFAULT CHR(0)
    ,I_VAL1_MEANING IN NVARCHAR2 DEFAULT CHR(0)
    ,I_VAL2_MEANING IN NVARCHAR2 DEFAULT CHR(0)
    ,I_VAL3_MEANING IN NVARCHAR2 DEFAULT CHR(0)
    ,I_VAL4_MEANING IN NVARCHAR2 DEFAULT CHR(0)
    ,I_VAL5_MEANING IN NVARCHAR2 DEFAULT CHR(0)
    ,I_VAL6_MEANING IN NVARCHAR2 DEFAULT CHR(0)
    ,I_VAL7_MEANING IN NVARCHAR2 DEFAULT CHR(0)
    ,I_VAL8_MEANING IN NVARCHAR2 DEFAULT CHR(0)
    ,I_VAL9_MEANING IN NVARCHAR2 DEFAULT CHR(0)
    ,I_VAL10_MEANING IN NVARCHAR2 DEFAULT CHR(0)
    ) IS
    BEGIN
      UPDATE ABF_GEN_MST
      SET DESCRIPTION = DECODE(I_DESCRIPTION, CHR(0), DESCRIPTION, I_DESCRIPTION)
         ,ENABLE_FLG = DECODE(I_ENABLE_FLG, CHR(0), ENABLE_FLG, I_ENABLE_FLG)
         ,KEY1_MEANING = DECODE(I_KEY1_MEANING, CHR(0), KEY1_MEANING, I_KEY1_MEANING)
         ,KEY2_MEANING = DECODE(I_KEY2_MEANING, CHR(0), KEY2_MEANING, I_KEY2_MEANING)
         ,KEY3_MEANING = DECODE(I_KEY3_MEANING, CHR(0), KEY3_MEANING, I_KEY3_MEANING)
         ,KEY4_MEANING = DECODE(I_KEY4_MEANING, CHR(0), KEY4_MEANING, I_KEY4_MEANING)
         ,KEY5_MEANING = DECODE(I_KEY5_MEANING, CHR(0), KEY5_MEANING, I_KEY5_MEANING)
         ,VAL1_MEANING = DECODE(I_VAL1_MEANING, CHR(0), VAL1_MEANING, I_VAL1_MEANING)
         ,VAL2_MEANING = DECODE(I_VAL2_MEANING, CHR(0), VAL2_MEANING, I_VAL2_MEANING)
         ,VAL3_MEANING = DECODE(I_VAL3_MEANING, CHR(0), VAL3_MEANING, I_VAL3_MEANING)
         ,VAL4_MEANING = DECODE(I_VAL4_MEANING, CHR(0), VAL4_MEANING, I_VAL4_MEANING)
         ,VAL5_MEANING = DECODE(I_VAL5_MEANING, CHR(0), VAL5_MEANING, I_VAL5_MEANING)
         ,VAL6_MEANING = DECODE(I_VAL6_MEANING, CHR(0), VAL6_MEANING, I_VAL6_MEANING)
         ,VAL7_MEANING = DECODE(I_VAL7_MEANING, CHR(0), VAL7_MEANING, I_VAL7_MEANING)
         ,VAL8_MEANING = DECODE(I_VAL8_MEANING, CHR(0), VAL8_MEANING, I_VAL8_MEANING)
         ,VAL9_MEANING = DECODE(I_VAL9_MEANING, CHR(0), VAL9_MEANING, I_VAL9_MEANING)
         ,VAL10_MEANING = DECODE(I_VAL10_MEANING, CHR(0), VAL10_MEANING, I_VAL10_MEANING)
         ,UPDATE_DATE = SYSDATE
         ,UPDATE_USER = abf_c.cv_app_user
      WHERE MST_TYPE = I_MST_TYPE
    ;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END upd;
--
/****************************************************************************＊
-- Procedure Name : del
-- Meaning :
-- Creation Date : 2016-04-24
-- Created by API AUTO CREATOR
-- Update Date : 2018-04-30
-- Updated by tfurukaw
***************************************************************************＊*/
  PROCEDURE del(
    I_MST_TYPE IN NVARCHAR2
    ) IS
    BEGIN
      DELETE ABF_GEN_MST
      WHERE MST_TYPE = I_MST_TYPE
    ;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END del;
--
/****************************************************************************＊
-- Procedure Name : disable
-- Meaning :
-- Creation Date : 2018-05-01
-- Created by tfurukaw
***************************************************************************＊*/
  PROCEDURE disable(
    I_MST_TYPE IN NVARCHAR2
    ) IS
  BEGIN
    upd(I_MST_TYPE => I_MST_TYPE, I_ENABLE_FLG => abf_c.cv_no);
  END disable;
/****************************************************************************＊
-- Procedure Name : enable
-- Meaning :
-- Creation Date : 2018-05-01
-- Created by tfurukaw
***************************************************************************＊*/
  PROCEDURE enable(
    I_MST_TYPE IN NVARCHAR2
    ) IS
  BEGIN
    upd(I_MST_TYPE => I_MST_TYPE, I_ENABLE_FLG => abf_c.cv_yes);
  END enable;
END ABFAPI_GEN_MST;
/
