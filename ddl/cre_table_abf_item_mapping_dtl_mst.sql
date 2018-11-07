--==========================================================
-- Table Name : ABF_ITEM_MAPPING_DTL_MST
-- Meaning : ABF項目マッピング明細マスタ
--==========================================================
-- CREATE TABLE
CREATE TABLE abf_item_mapping_dtl_mst (
mst_type NVARCHAR2(30) NOT NULL
,item_no NUMBER(3) NOT NULL
,source_item_name NVARCHAR2(30) 
,target_item_name NVARCHAR2(30) 
,filter_item NUMBER(2) 
,rerun_delete_item NUMBER(2) 
,sort_key_item NUMBER(2) 
,enable_flg NVARCHAR2(1) NOT NULL
,create_user NVARCHAR2(30) NOT NULL
,creation_date TIMESTAMP NOT NULL
,update_user NVARCHAR2(30) NOT NULL
,update_date TIMESTAMP NOT NULL);

-- DDL(ADD CONSTRAINT)
ALTER TABLE abf_item_mapping_dtl_mst ADD CONSTRAINT abf_item_mapping_dtl_mst_pk PRIMARY KEY(
mst_type
,item_no
);

-- COMMENT
COMMENT ON TABLE abf_item_mapping_dtl_mst IS '項目マッピング明細マスタ';
COMMENT ON COLUMN abf_item_mapping_dtl_mst.mst_type IS '連携するデータ種類毎に定義';
COMMENT ON COLUMN abf_item_mapping_dtl_mst.item_no IS '項目番号';
COMMENT ON COLUMN abf_item_mapping_dtl_mst.source_item_name IS '連携元項目名（物理名）';
COMMENT ON COLUMN abf_item_mapping_dtl_mst.target_item_name IS '連携先項目名（物理名）';
COMMENT ON COLUMN abf_item_mapping_dtl_mst.filter_item IS '抽出条件項目かどうか。引数番号と一致させる';
COMMENT ON COLUMN abf_item_mapping_dtl_mst.rerun_delete_item IS '再実行用の削除項目かどうか。引数番号と一致';
COMMENT ON COLUMN abf_item_mapping_dtl_mst.sort_key_item IS 'ファイル出力のみ。ソートキー。適用順を指定';
COMMENT ON COLUMN abf_item_mapping_dtl_mst.enable_flg IS '有効フラグ';
COMMENT ON COLUMN abf_item_mapping_dtl_mst.create_user IS 'データレコード作成者のユーザーID';
COMMENT ON COLUMN abf_item_mapping_dtl_mst.creation_date IS 'データレコード作成日時';
COMMENT ON COLUMN abf_item_mapping_dtl_mst.update_user IS 'データレコード更新者のユーザーID';
COMMENT ON COLUMN abf_item_mapping_dtl_mst.update_date IS 'データレコード更新日時';

CREATE OR REPLACE TRIGGER abf_item_mapping_dtl_mst_trg
/******************************************************************/
-- 登録日(INSERT)または、最終更新日(UPDATE)をセットするトリガー
-- 新規作成時は登録日も設定。更新時は登録日、最終更新日を設定
/******************************************************************/
BEFORE  INSERT OR UPDATE ON abf_item_mapping_dtl_mst
FOR EACH ROW    -- <------行トリガーの指定
BEGIN
    IF INSERTING THEN                  -- INSERTの時
        :NEW.update_date := SYSDATE;
        IF :NEW.creation_date IS NULL THEN      -- Add.20170320
            :NEW.creation_date := SYSDATE;
        END IF;
    ELSE                               -- UPDATEの時
        :NEW.update_date := SYSDATE;
    END IF;
END;
/
