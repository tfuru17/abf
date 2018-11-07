CREATE OR REPLACE PACKAGE BODY ABFAPI_GEN_MST_DTL IS
/****************************************************************************＊
-- Package Name : ABF_GEN_MST_DTL
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
    ,I_KEY1 IN NVARCHAR2
    ,I_KEY2 IN NVARCHAR2
    ,I_KEY3 IN NVARCHAR2
    ,I_KEY4 IN NVARCHAR2
    ,I_KEY5 IN NVARCHAR2
    ,I_VAL1 IN NVARCHAR2
    ,I_VAL2 IN NVARCHAR2
    ,I_VAL3 IN NVARCHAR2
    ,I_VAL4 IN NVARCHAR2
    ,I_VAL5 IN NVARCHAR2
    ,I_VAL6 IN NVARCHAR2
    ,I_VAL7 IN NVARCHAR2
    ,I_VAL8 IN NVARCHAR2
    ,I_VAL9 IN NVARCHAR2
    ,I_VAL10 IN NVARCHAR2
    ,I_ENABLE_FLG IN NVARCHAR2
    ) IS
    BEGIN
      INSERT INTO ABF_GEN_MST_DTL(
        MST_TYPE
        ,KEY1
        ,KEY2
        ,KEY3
        ,KEY4
        ,KEY5
        ,VAL1
        ,VAL2
        ,VAL3
        ,VAL4
        ,VAL5
        ,VAL6
        ,VAL7
        ,VAL8
        ,VAL9
        ,VAL10
        ,ENABLE_FLG
        ,CREATION_DATE
        ,CREATE_USER
        ,UPDATE_DATE
        ,UPDATE_USER
      ) VALUES (
        I_MST_TYPE
        ,I_KEY1
        ,I_KEY2
        ,I_KEY3
        ,I_KEY4
        ,I_KEY5
        ,I_VAL1
        ,I_VAL2
        ,I_VAL3
        ,I_VAL4
        ,I_VAL5
        ,I_VAL6
        ,I_VAL7
        ,I_VAL8
        ,I_VAL9
        ,I_VAL10
        ,I_ENABLE_FLG
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
    ,I_KEY1 IN NVARCHAR2
    ,I_KEY2 IN NVARCHAR2
    ,I_KEY3 IN NVARCHAR2
    ,I_KEY4 IN NVARCHAR2
    ,I_KEY5 IN NVARCHAR2
    ,I_VAL1 IN NVARCHAR2
    ,I_VAL2 IN NVARCHAR2
    ,I_VAL3 IN NVARCHAR2
    ,I_VAL4 IN NVARCHAR2
    ,I_VAL5 IN NVARCHAR2
    ,I_VAL6 IN NVARCHAR2
    ,I_VAL7 IN NVARCHAR2
    ,I_VAL8 IN NVARCHAR2
    ,I_VAL9 IN NVARCHAR2
    ,I_VAL10 IN NVARCHAR2
    ,I_ENABLE_FLG IN NVARCHAR2
    ) IS
    BEGIN
      UPDATE ABF_GEN_MST_DTL
      SET VAL1 = NVL(I_VAL1, VAL1)
         ,VAL2 = NVL(I_VAL2, VAL2)
         ,VAL3 = NVL(I_VAL3, VAL3)
         ,VAL4 = NVL(I_VAL4, VAL4)
         ,VAL5 = NVL(I_VAL5, VAL5)
         ,VAL6 = NVL(I_VAL6, VAL6)
         ,VAL7 = NVL(I_VAL7, VAL7)
         ,VAL8 = NVL(I_VAL8, VAL8)
         ,VAL9 = NVL(I_VAL9, VAL9)
         ,VAL10 = NVL(I_VAL10, VAL10)
         ,ENABLE_FLG = I_ENABLE_FLG
         ,UPDATE_DATE = SYSDATE
         ,UPDATE_USER = abf_c.cv_app_user
      WHERE MST_TYPE = I_MST_TYPE
      AND   KEY1 = NVL(I_KEY1, KEY1)
      AND   KEY2 = NVL(I_KEY2, KEY2)
      AND   KEY3 = NVL(I_KEY3, KEY3)
      AND   KEY4 = NVL(I_KEY4, KEY4)
      AND   KEY5 = NVL(I_KEY5, KEY5)
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
    ,I_KEY1 IN NVARCHAR2
    ,I_KEY2 IN NVARCHAR2
    ,I_KEY3 IN NVARCHAR2
    ,I_KEY4 IN NVARCHAR2
    ,I_KEY5 IN NVARCHAR2
    ) IS
    BEGIN
      DELETE ABF_GEN_MST_DTL
      WHERE MST_TYPE = I_MST_TYPE
      AND   KEY1 = NVL(I_KEY1, KEY1)
      AND   KEY2 = NVL(I_KEY2, KEY2)
      AND   KEY3 = NVL(I_KEY3, KEY3)
      AND   KEY4 = NVL(I_KEY4, KEY4)
      AND   KEY5 = NVL(I_KEY5, KEY5)
    ;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END del;
--
/****************************************************************************＊
-- Function Name : get_rec
-- Meaning : 汎用マスタからのレコード単位データ取得
-- Creation Date : 2018-07-17
-- Created by tfurukaw
-- Update Date :
-- Updated by
***************************************************************************＊*/
  FUNCTION get_rec(
    I_MST_TYPE IN NVARCHAR2
    ,I_KEY1 IN NVARCHAR2
    ,I_KEY2 IN NVARCHAR2 DEFAULT NULL
    ,I_KEY3 IN NVARCHAR2 DEFAULT NULL
    ,I_KEY4 IN NVARCHAR2 DEFAULT NULL
    ,I_KEY5 IN NVARCHAR2 DEFAULT NULL
    ) RETURN cur_gen_mst%ROWTYPE
    IS
      rec_gen_mst cur_gen_mst%ROWTYPE;
    BEGIN
      OPEN cur_gen_mst(i_mst_type, i_key1, i_key2, i_key3, i_key4, i_key5);
      FETCH cur_gen_mst INTO rec_gen_mst;
      IF cur_gen_mst%NOTFOUND THEN
        RETURN NULL;
      END IF;
      CLOSE cur_gen_mst;
      RETURN rec_gen_mst;
--
  EXCEPTION
    WHEN OTHERS THEN
      CLOSE cur_gen_mst;
      RAISE;
  END get_rec;
--
/****************************************************************************＊
-- Function Name : get_val
-- Meaning : 汎用マスタから項目単位での値取得
-- Creation Date : 2018-07-17
-- Created by tfurukaw
-- Update Date :
-- Updated by
***************************************************************************＊*/
  FUNCTION get_val(
    I_MST_TYPE IN NVARCHAR2
    ,I_KEY1 IN NVARCHAR2
    ,I_KEY2 IN NVARCHAR2 DEFAULT NULL
    ,I_KEY3 IN NVARCHAR2 DEFAULT NULL
    ,I_KEY4 IN NVARCHAR2 DEFAULT NULL
    ,I_KEY5 IN NVARCHAR2 DEFAULT NULL
    ,I_RETURN_VAL_NUM IN NUMBER DEFAULT 1
    ) RETURN VARCHAR2
    IS
      rec_gen_mst cur_gen_mst%ROWTYPE;
    BEGIN
      rec_gen_mst := get_rec(
        i_mst_type
        ,i_key1
        ,i_key2
        ,i_key3
        ,i_key4
        ,i_key5);
--
      CASE i_return_val_num
        WHEN 1 THEN RETURN rec_gen_mst.val1;
        WHEN 2 THEN RETURN rec_gen_mst.val2;
        WHEN 3 THEN RETURN rec_gen_mst.val3;
        WHEN 4 THEN RETURN rec_gen_mst.val4;
        WHEN 5 THEN RETURN rec_gen_mst.val5;
        WHEN 6 THEN RETURN rec_gen_mst.val6;
        WHEN 7 THEN RETURN rec_gen_mst.val7;
        WHEN 8 THEN RETURN rec_gen_mst.val8;
        WHEN 9 THEN RETURN rec_gen_mst.val9;
        WHEN 10 THEN RETURN rec_gen_mst.val10;
        ELSE NULL;
      END CASE;
      RETURN NULL;
--
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END get_val;
--
END ABFAPI_GEN_MST_DTL;
/
