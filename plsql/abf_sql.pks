CREATE OR REPLACE PACKAGE abf_sql IS
/****************************************************************************＊
-- Package Name : abf_sql
-- Meaning : 項目定義マスタの設定内容からSQL文字列を生成する
-- Creation Date : 2018-08-12
-- Created by TFURUKAW
***************************************************************************＊*/
--
  -- SQL精製時に使用する文字列
  cv_ins CONSTANT VARCHAR2(16) := 'INSERT INTO ';
  cv_upd CONSTANT VARCHAR2(8) := 'UPDATE ';
  cv_del CONSTANT VARCHAR2(8) := 'DELETE ';
  cv_sel CONSTANT VARCHAR2(8) := 'SELECT ';
  cv_from CONSTANT VARCHAR2(8) := 'FROM ';
  cv_where CONSTANT VARCHAR2(8) := 'WHERE ';
  cv_and CONSTANT VARCHAR2(8) := ' AND ';
  cv_or CONSTANT VARCHAR2(8) := ' OR ';
  cv_null CONSTANT VARCHAR2(8) := ' NULL ';
--
  -- カラムリスト保持用配列
  TYPE rtype_col_list IS TABLE OF VARCHAR2(30) INDEX BY BINARY_INTEGER;
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
    ) RETURN rtype_col_list;
--
  /****************************************************************************＊
  -- Function Name : select_clause
  -- Meaning :
  -- Creation Date : 2018-08-12
  -- Created by TFURUKAW
  ***************************************************************************＊*/
  FUNCTION select_clause(
    iv_mst_type IN abf_item_mapping_mst.mst_type%TYPE
    ) RETURN VARCHAR2;
--
  /****************************************************************************＊
  -- Function Name : insert_clause
  -- Meaning :
  -- Creation Date : 2018-08-12
  -- Created by TFURUKAW
  ***************************************************************************＊*/
  FUNCTION insert_clause(
    iv_mst_type IN abf_item_mapping_mst.mst_type%TYPE
    ) RETURN VARCHAR2;
--
  /****************************************************************************＊
  -- Function Name : from_clause
  -- Meaning :
  -- Creation Date : 2018-08-12
  -- Created by TFURUKAW
  ***************************************************************************＊*/
  FUNCTION from_clause(
    iv_mst_type IN abf_item_mapping_mst.mst_type%TYPE
    ) RETURN VARCHAR2;
--
  /****************************************************************************＊
  -- Function Name : where_clause
  -- Meaning :
  -- Creation Date : 2018-08-12
  -- Created by TFURUKAW
  ***************************************************************************＊*/
  FUNCTION where_clause(
    iv_mst_type IN abf_item_mapping_mst.mst_type%TYPE
    ) RETURN VARCHAR2;
--
  /****************************************************************************＊
  -- Function Name : ins_sel_sql
  -- Meaning :
  -- Creation Date : 2018-09-01
  -- Created by TFURUKAW
  ***************************************************************************＊*/
  FUNCTION ins_sel_sql(
    iv_mst_type IN abf_item_mapping_mst.mst_type%TYPE
    ) RETURN NCLOB;
--
END abf_sql;
/
