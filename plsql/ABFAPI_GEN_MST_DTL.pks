CREATE OR REPLACE PACKAGE ABFAPI_GEN_MST_DTL IS
/****************************************************************************＊
-- Package Name : ABF_GEN_MST_DTL
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
    );
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
    );
  PROCEDURE del(
    I_MST_TYPE IN NVARCHAR2
    ,I_KEY1 IN NVARCHAR2
    ,I_KEY2 IN NVARCHAR2
    ,I_KEY3 IN NVARCHAR2
    ,I_KEY4 IN NVARCHAR2
    ,I_KEY5 IN NVARCHAR2
    );
--
    CURSOR cur_gen_mst(
      I_MST_TYPE IN NVARCHAR2
      ,I_KEY1 IN NVARCHAR2
      ,I_KEY2 IN NVARCHAR2
      ,I_KEY3 IN NVARCHAR2
      ,I_KEY4 IN NVARCHAR2
      ,I_KEY5 IN NVARCHAR2)
    IS
    SELECT VAL1
          ,VAL2
          ,VAL3
          ,VAL4
          ,VAL5
          ,VAL6
          ,VAL7
          ,VAL8
          ,VAL9
          ,VAL10
    FROM   ABF_GEN_MST_DTL
    WHERE  MST_TYPE = I_MST_TYPE
    AND    (KEY1 = I_KEY1 OR (KEY1 IS NULL AND I_KEY1 IS NULL))
    AND    (KEY2 = I_KEY2 OR (KEY2 IS NULL AND I_KEY2 IS NULL))
    AND    (KEY3 = I_KEY3 OR (KEY3 IS NULL AND I_KEY3 IS NULL))
    AND    (KEY4 = I_KEY4 OR (KEY4 IS NULL AND I_KEY4 IS NULL))
    AND    (KEY5 = I_KEY5 OR (KEY5 IS NULL AND I_KEY5 IS NULL))
    AND    ENABLE_FLG = 'Y'
    ;
--
  FUNCTION get_rec(
    I_MST_TYPE IN NVARCHAR2
    ,I_KEY1 IN NVARCHAR2
    ,I_KEY2 IN NVARCHAR2 DEFAULT NULL
    ,I_KEY3 IN NVARCHAR2 DEFAULT NULL
    ,I_KEY4 IN NVARCHAR2 DEFAULT NULL
    ,I_KEY5 IN NVARCHAR2 DEFAULT NULL
    ) RETURN cur_gen_mst%ROWTYPE;
  FUNCTION get_val(
    I_MST_TYPE IN NVARCHAR2
    ,I_KEY1 IN NVARCHAR2
    ,I_KEY2 IN NVARCHAR2 DEFAULT NULL
    ,I_KEY3 IN NVARCHAR2 DEFAULT NULL
    ,I_KEY4 IN NVARCHAR2 DEFAULT NULL
    ,I_KEY5 IN NVARCHAR2 DEFAULT NULL
    ,I_RETURN_VAL_NUM IN NUMBER DEFAULT 1
    ) RETURN VARCHAR2;
--
END ABFAPI_GEN_MST_DTL;
/
