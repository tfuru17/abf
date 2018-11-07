CREATE OR REPLACE PACKAGE ABF_SAMPLE_PKG IS
/****************************************************************************＊
-- Package Name : ABF_SAMPLE_PKG
-- Meaning : 指定したdeptのデータをemp表から取得し、CSVファイルに
--           出力するサンプルプログラム
-- Creation Date : 2016-05-03
-- Created by TFURUKAW
***************************************************************************＊*/
--
  /****************************************************************************＊
  -- Procedure Name : main
  -- Meaning :
  -- Creation Date : 2016-05-03
  -- Created by TFURUKAW
  ***************************************************************************＊*/
  PROCEDURE main(
    iv_job_name IN all_scheduler_job_log.job_name%TYPE
    ,iv_item_mapping_mst IN abf_item_mapping_mst.mst_type%TYPE
    ,iv_prm1 IN VARCHAR2 DEFAULT NULL
    ,iv_prm2 IN VARCHAR2 DEFAULT NULL
    ,iv_prm3 IN VARCHAR2 DEFAULT NULL
    ,iv_prm4 IN VARCHAR2 DEFAULT NULL
    ,iv_prm5 IN VARCHAR2 DEFAULT NULL
    ,iv_prm6 IN VARCHAR2 DEFAULT NULL
    ,iv_prm7 IN VARCHAR2 DEFAULT NULL
    ,iv_prm8 IN VARCHAR2 DEFAULT NULL
    );
--
END ABF_SAMPLE_PKG;
/
