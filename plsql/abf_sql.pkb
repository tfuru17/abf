CREATE OR REPLACE PACKAGE BODY abf_sql IS
/****************************************************************************＊
-- Package Name : abf_sql
-- Meaning : 項目定義マスタの設定内容からSQL文字列を生成する
-- Creation Date : 2018-08-12
-- Created by TFURUKAW
***************************************************************************＊*/
--
  /****************************************************************************＊
  -- Function Name : columns_list
  -- Meaning :
  -- Creation Date : 2018-08-12
  -- Created by TFURUKAW
  ***************************************************************************＊*/
  FUNCTION columns_list(
    iv_mst_type IN abf_item_mapping_mst.mst_type%TYPE
    ,iv_col_type IN VARCHAR2
    ) RETURN rtype_col_list
  IS
    -- SQL文字列作成に必要な項目マッピング情報を取得
    CURSOR cur_columns
    IS
    SELECT item_no
          ,source_item_name
          ,target_item_name
    FROM   abf_item_mapping_dtl_mst
    WHERE  mst_type = iv_mst_type;
    rec_columns cur_columns%ROWTYPE;    -- レコード型定義
    tab_columns rtype_col_list;         -- テーブル変数定義
  BEGIN
    -- 全カラム情報抽出
    FOR rec_columns IN cur_columns
    LOOP
      -- モードがSELECTの場合
      IF iv_col_type = abf_c.cv_sel THEN
        -- データ抽出(SELECT)対象列の取得
        tab_columns(rec_columns.item_no) := rec_columns.source_item_name;
      -- モードがINSERTの場合
      ELSIF iv_col_type = abf_c.cv_ins THEN
        -- データ挿入(INSERT)対象列の取得
        tab_columns(rec_columns.item_no) := rec_columns.target_item_name;
      END IF;
    END LOOP;
    RETURN tab_columns;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END columns_list;
--
  /****************************************************************************＊
  -- Function Name : select_clause
  -- Meaning :
  -- Creation Date : 2018-08-12
  -- Created by TFURUKAW
  ***************************************************************************＊*/
  FUNCTION select_clause(
    iv_mst_type IN abf_item_mapping_mst.mst_type%TYPE
    ) RETURN VARCHAR2
  IS
    tab_columns rtype_col_list;
    lv_select_str VARCHAR2(32767);
    lv_source_col_name VARCHAR2(30);
  BEGIN
    -- SELECT対象列のリストを取得
    tab_columns := columns_list(iv_mst_type, abf_c.cv_sel);
    -- コレクションの最終引数までをループ(PRIORまたはNEXTでやれば効率的)
    FOR i IN 1..tab_columns.COUNT
    LOOP
      -- 配列変数は要素が無い時NO_DATA_FOUNDになるので、NULLをセットするためにブロック使用
      BEGIN
        lv_source_col_name := tab_columns(i);
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          lv_source_col_name := NULL;
      END;
--
      -- SELECT句の生成
      IF lv_source_col_name IS NULL THEN
        -- 取得元の列名設定がない場合はNULLを設定
        IF lv_select_str IS NULL THEN
          -- 最初に取得した値は列名のみ
          lv_select_str := abf_sql.cv_null;
        ELSE
          -- 2回目以降に取得した列名には「,」を付ける
          lv_select_str := lv_select_str || abf_c.cv_cm || abf_sql.cv_null;
        END IF;
      ELSE
        -- 取得元の列名設定があれば列名を設定
        IF lv_select_str IS NULL THEN
          lv_select_str := lv_source_col_name;
        ELSE
          lv_select_str := lv_select_str || abf_c.cv_cm || lv_source_col_name;
        END IF;
      END IF;
    END LOOP;
    RETURN lv_select_str;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END select_clause;
--
  /****************************************************************************＊
  -- Function Name : insert_clause
  -- Meaning :
  -- Creation Date : 2018-08-12
  -- Created by TFURUKAW
  ***************************************************************************＊*/
  FUNCTION insert_clause(
    iv_mst_type IN abf_item_mapping_mst.mst_type%TYPE
    ) RETURN VARCHAR2
  IS
    tab_columns rtype_col_list;
    lv_ins_str VARCHAR2(32767);
  BEGIN
    -- SELECT対象列のリストを取得
    tab_columns := columns_list(iv_mst_type, abf_c.cv_ins);
    -- コレクションの最終引数までをループ(PRIORまたはNEXTでやれば効率的)
    FOR i IN 1..tab_columns.COUNT
    LOOP
      IF tab_columns(i) IS NOT NULL THEN
        IF lv_ins_str IS NULL THEN
          -- 最初に取得した値は列名のみ
          lv_ins_str := tab_columns(i);
        ELSE
          -- 2回目以降に取得した列名には「,」を付ける
          lv_ins_str := lv_ins_str || abf_c.cv_cm || tab_columns(i);
        END IF;
      ELSE
        IF lv_ins_str IS NULL THEN
          -- 最初に取得した値は列名のみ
          lv_ins_str := abf_sql.cv_null;
        ELSE
          -- 2回目以降に取得した列名には「,」を付ける
          lv_ins_str := lv_ins_str || abf_c.cv_cm || abf_sql.cv_null;
        END IF;
      END IF;
    END LOOP;
    RETURN lv_ins_str;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END insert_clause;
--
  /****************************************************************************＊
  -- Function Name : from_clause
  -- Meaning :
  -- Creation Date : 2018-08-12
  -- Created by TFURUKAW
  ***************************************************************************＊*/
  FUNCTION from_clause(
    iv_mst_type IN abf_item_mapping_mst.mst_type%TYPE
    ) RETURN VARCHAR2
  IS
    CURSOR cur_from_table
    IS
    SELECT source_data
    FROM   abf_item_mapping_mst
    WHERE  mst_type = iv_mst_type
    ;
    lv_table_name VARCHAR(30);
  BEGIN
    -- 項目マッピング定義マスタから連携元データソースを取得
    OPEN cur_from_table;
    FETCH cur_from_table INTO lv_table_name;
    CLOSE cur_from_table;
    --
    RETURN lv_table_name;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END from_clause;
--
  /****************************************************************************＊
  -- Function Name : where_clause
  -- Meaning :
  -- Creation Date : 2018-08-12
  -- Created by TFURUKAW
  ***************************************************************************＊*/
  FUNCTION where_clause(
    iv_mst_type IN abf_item_mapping_mst.mst_type%TYPE
    ) RETURN VARCHAR2
  IS
    CURSOR cur_where_columns
    IS
    SELECT source_item_name
          ,filter_item
    FROM   abf_item_mapping_dtl_mst
    WHERE  mst_type = iv_mst_type
    AND    filter_item IS NOT NULL
    ORDER BY filter_item;
    rec_where_columns cur_where_columns%ROWTYPE;
    lv_where_clause VARCHAR2(32767);
    ln_param_counter NUMBER := 1;
  BEGIN
    FOR rec_where_columns IN cur_where_columns
    LOOP
      -- WHERE句文字列の生成
      IF lv_where_clause IS NULL THEN
        -- 最初は「column_name = :<バインド変数番号>」
        lv_where_clause := abf_sql.cv_where
                        || rec_where_columns.source_item_name || abf_c.cv_eql
                        || abf_c.cv_cln || TO_CHAR(ln_param_counter);
      ELSE -- 2つめからは追記。「AND column_name = :<バインド変数番号>」
        lv_where_clause := lv_where_clause || abf_sql.cv_and
                        || rec_where_columns.source_item_name || abf_c.cv_eql
                        || abf_c.cv_cln || TO_CHAR(ln_param_counter);
      END IF;
      -- バインド変数用の数値をカウントアップ
      ln_param_counter := ln_param_counter + 1;
    END LOOP;
    RETURN lv_where_clause;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END where_clause;
--
  /****************************************************************************＊
  -- Function Name : ins_sel_sql
  -- Meaning :
  -- Creation Date : 2018-09-01
  -- Created by TFURUKAW
  ***************************************************************************＊*/
  FUNCTION ins_sel_sql(
    iv_mst_type IN abf_item_mapping_mst.mst_type%TYPE
    ) RETURN NCLOB
  IS
    lc_sql_str NCLOB;
  BEGIN
    -- INSERT INTO句の作成
    lc_sql_str := abf_sql.cv_ins || TO_CLOB(abfapi_item_mapping.get(iv_mst_type, 'target_data')) || abf_c.cv_op
               || TO_CLOB(insert_clause(iv_mst_type)) || abf_c.cv_cl || abf_c.cv_spc;
    -- SELECT文字列の作成
    lc_sql_str := lc_sql_str || abf_sql.cv_sel || TO_CLOB(select_clause(iv_mst_type));
    -- FROM句の作成
    lc_sql_str := lc_sql_str || abf_c.cv_spc || abf_sql.cv_from || TO_CLOB(from_clause(iv_mst_type));
    -- WHERE句の作成
    lc_sql_str := lc_sql_str || abf_c.cv_spc || TO_CLOB(where_clause(iv_mst_type));
    -- 
    RETURN lc_sql_str;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END ins_sel_sql;
--
END abf_sql;
/
