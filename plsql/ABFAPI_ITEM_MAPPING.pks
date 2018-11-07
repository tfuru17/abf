CREATE OR REPLACE PACKAGE ABFAPI_ITEM_MAPPING IS
/****************************************************************************＊
-- Package Name : ABF_ITEM_MAPPING
-- Meaning : 項目マッピング定義用のAPIパッケージ
-- Creation Date : 2018-09-01
-- Created by tfurukaw
***************************************************************************＊*/
  PROCEDURE first_ins(
    i_mst_type IN NVARCHAR2
    ,i_source_data IN NVARCHAR2
    );
  PROCEDURE ins(
    i_mst_type IN NVARCHAR2
    ,i_description IN NVARCHAR2
    ,i_enable_flg IN NVARCHAR2
    ,i_transfer_type IN NVARCHAR2
    ,i_source_data IN NVARCHAR2
    ,i_target_data IN NVARCHAR2
    ,i_transfer_option IN NVARCHAR2
    ,i_optimizer_hint IN NVARCHAR2
    ,i_diff_import IN NVARCHAR2
    );
  PROCEDURE upd(
    i_mst_type IN NVARCHAR2
    ,i_description IN NVARCHAR2
    ,i_enable_flg IN NVARCHAR2
    ,i_transfer_type IN NVARCHAR2
    ,i_source_data IN NVARCHAR2
    ,i_target_data IN NVARCHAR2
    ,i_transfer_option IN NVARCHAR2
    ,i_optimizer_hint IN NVARCHAR2
    ,i_diff_import IN NVARCHAR2
    );
  PROCEDURE del(
    i_mst_type IN NVARCHAR2
    );
  FUNCTION get(
    i_mst_type IN NVARCHAR2
    ,i_item_name IN NVARCHAR2
    ) RETURN NVARCHAR2;
END ABFAPI_ITEM_MAPPING;
/
