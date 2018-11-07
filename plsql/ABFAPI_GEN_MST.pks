CREATE OR REPLACE PACKAGE ABFAPI_GEN_MST IS
/****************************************************************************＊
-- Package Name : ABF_GEN_MST
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
    );
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
    );
  PROCEDURE del(
    I_MST_TYPE IN NVARCHAR2
    );
  PROCEDURE disable(
    I_MST_TYPE IN NVARCHAR2
    );
  PROCEDURE enable(
    I_MST_TYPE IN NVARCHAR2
    );
END ABFAPI_GEN_MST;
/
