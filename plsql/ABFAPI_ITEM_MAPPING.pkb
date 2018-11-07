CREATE OR REPLACE PACKAGE BODY ABFAPI_ITEM_MAPPING IS
/****************************************************************************＊
-- Package Name : ABF_ITEM_MAPPING
-- Meaning : 項目マッピング定義用のAPIパッケージ
-- Creation Date : 2018-09-01
-- Created by tfurukaw
***************************************************************************＊*/
/****************************************************************************＊
-- Procedure Name : first_ins
-- Meaning :
-- Creation Date : 2018-09-01
-- Created by tfurukaw
***************************************************************************＊*/
  PROCEDURE first_ins(
    i_mst_type IN NVARCHAR2
    ,i_source_data IN NVARCHAR2
    )
  IS
    -- 項目マッピング情報のうちSQL生成に必要な情報のみ取得
    TYPE rec_tbl_define IS RECORD
    (
      table_name user_tab_columns.table_name%TYPE
      ,column_id user_tab_columns.column_id%TYPE
      ,column_name user_tab_columns.column_name%TYPE
      ,comments user_col_comments.comments%TYPE
    );
    TYPE ttype_tbl_define IS TABLE OF rec_tbl_define;
    tab_tbl_define ttype_tbl_define;
  BEGIN
    -- 事前に削除
    DELETE abf_item_mapping_dtl_mst
    WHERE mst_type = i_mst_type;
--
    -- バルクコレクトでテーブル定義(DDL)情報を取得
    SELECT utc.table_name
          ,utc.column_id
          ,utc.column_name
          ,utcc.comments
    BULK COLLECT INTO tab_tbl_define
    FROM   user_tab_columns utc
           INNER JOIN user_col_comments utcc
             ON (utc.table_name = utcc.table_name
             AND utc.column_name = utcc.column_name)
    WHERE  utc.table_name = i_source_data
    ORDER BY utc.column_id
    ;
--
    -- 全件一括でINSERT。NGなら全件ROLLBACK
    FORALL i IN 1..tab_tbl_define.COUNT
      INSERT INTO abf_item_mapping_dtl_mst
      (
        mst_type
        ,item_no
        ,source_item_name
        ,target_item_name
        ,filter_item
        ,rerun_delete_item
        ,sort_key_item
        ,enable_flg
        ,create_user
        ,creation_date
        ,update_user
        ,update_date
      )
      VALUES
      (
        i_mst_type
        ,tab_tbl_define(i).column_id
        ,NULL
        ,tab_tbl_define(i).column_name
        ,NULL
        ,NULL
        ,NULL
        ,abf_c.cv_yes
        ,abf_c.cv_app_user
        ,SYSDATE
        ,abf_c.cv_app_user
        ,SYSDATE
      );
--
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END first_ins;
--
/****************************************************************************＊
-- Procedure Name : ins
-- Meaning :
-- Creation Date : 2016-04-19
-- Created by API AUTO CREATOR
***************************************************************************＊*/
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
    ) IS
    BEGIN
      INSERT INTO abf_item_mapping_mst(
        mst_type
        ,description
        ,enable_flg
        ,transfer_type
        ,source_data
        ,target_data
        ,transfer_option
        ,optimizer_hint
        ,diff_import
        ,create_user
        ,creation_date
        ,update_user
        ,update_date
      ) VALUES (
        i_mst_type
        ,i_description
        ,i_enable_flg
        ,i_transfer_type
        ,i_source_data
        ,i_target_data
        ,i_transfer_option
        ,i_optimizer_hint
        ,i_diff_import
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
    i_mst_type IN NVARCHAR2
    ,i_description IN NVARCHAR2
    ,i_enable_flg IN NVARCHAR2
    ,i_transfer_type IN NVARCHAR2
    ,i_source_data IN NVARCHAR2
    ,i_target_data IN NVARCHAR2
    ,i_transfer_option IN NVARCHAR2
    ,i_optimizer_hint IN NVARCHAR2
    ,i_diff_import IN NVARCHAR2
    ) IS
    BEGIN
      UPDATE abf_item_mapping_mst
      SET    description = i_description
            ,enable_flg = i_enable_flg
            ,transfer_type = i_transfer_type
            ,source_data = i_source_data
            ,target_data = i_target_data
            ,transfer_option = i_transfer_option
            ,optimizer_hint = i_optimizer_hint
            ,diff_import = i_diff_import
            ,create_user = 'ABF_USER'
            ,creation_date = SYSDATE
            ,update_user = 'ABF_USER'
            ,update_date = SYSDATE
      WHERE  mst_type = i_mst_type
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
    i_mst_type IN NVARCHAR2
    ) IS
    BEGIN
      DELETE abf_item_mapping_mst
      WHERE  mst_type = i_mst_type;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END del;
--
/****************************************************************************＊
-- Function Name : get
-- Meaning :
-- Creation Date : 2018-09-02
-- Created by tfurukaw
***************************************************************************＊*/
  FUNCTION get(
    i_mst_type IN NVARCHAR2
    ,i_item_name IN NVARCHAR2
    ) RETURN NVARCHAR2
  IS
    CURSOR cur_item_mapping_mst
    IS
    SELECT mst_type
          ,description
          ,enable_flg
          ,transfer_type
          ,source_data
          ,target_data
          ,transfer_option
          ,optimizer_hint
          ,diff_import
    FROM   abf_item_mapping_mst
    WHERE  mst_type = i_mst_type;
    rec_item_mapping_mst cur_item_mapping_mst%ROWTYPE;
    lv_ret_val NVARCHAR2(4000);
  --
  BEGIN
    --
    OPEN cur_item_mapping_mst;
    FETCH cur_item_mapping_mst INTO rec_item_mapping_mst;
    CLOSE cur_item_mapping_mst;
--
    lv_ret_val :=
      CASE i_item_name
        WHEN 'mst_type' THEN rec_item_mapping_mst.mst_type
        WHEN 'description' THEN rec_item_mapping_mst.description
        WHEN 'enable_flg' THEN rec_item_mapping_mst.enable_flg
        WHEN 'transfer_type' THEN rec_item_mapping_mst.transfer_type
        WHEN 'source_data' THEN rec_item_mapping_mst.source_data
        WHEN 'target_data' THEN rec_item_mapping_mst.target_data
        WHEN 'transfer_option' THEN rec_item_mapping_mst.transfer_option
        WHEN 'optimizer_hint' THEN rec_item_mapping_mst.optimizer_hint
        WHEN 'diff_import' THEN rec_item_mapping_mst.diff_import
        ELSE NULL
      END;
    RETURN lv_ret_val;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END get;
--
END ABFAPI_ITEM_MAPPING;
/
