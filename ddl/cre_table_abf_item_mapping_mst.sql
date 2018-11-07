--==========================================================
-- Table Name : ABF_ITEM_MAPPING_MST
-- Meaning : ABF項目マッピング定義マスタ
--==========================================================
-- CREATE TABLE
CREATE TABLE abf_item_mapping_mst (
mst_type NVARCHAR2(30) NOT NULL
,description NVARCHAR2(240) 
,enable_flg NVARCHAR2(1) NOT NULL
,transfer_type NVARCHAR2(10) NOT NULL
,source_data NVARCHAR2(240) NOT NULL
,target_data NVARCHAR2(240) NOT NULL
,transfer_option NVARCHAR2(30) 
,optimizer_hint NVARCHAR2(240) 
,diff_import NVARCHAR2(30) 
,create_user NVARCHAR2(30) NOT NULL
,creation_date TIMESTAMP NOT NULL
,update_user NVARCHAR2(30) NOT NULL
,update_date TIMESTAMP NOT NULL);

-- DDL(ADD CONSTRAINT)
ALTER TABLE abf_item_mapping_mst ADD CONSTRAINT abf_item_mapping_mst_pk PRIMARY KEY(
mst_type
);

-- COMMENT
COMMENT ON TABLE abf_item_mapping_mst IS '項目マッピング定義マスタ';
COMMENT ON COLUMN abf_item_mapping_mst.mst_type IS '連携するデータ種類毎に定義';
COMMENT ON COLUMN abf_item_mapping_mst.description IS 'データ連携の内容を説明';
COMMENT ON COLUMN abf_item_mapping_mst.enable_flg IS '有効フラグ';
COMMENT ON COLUMN abf_item_mapping_mst.transfer_type IS 'データ連携の種類。DB→DB、DB→FILE等';
COMMENT ON COLUMN abf_item_mapping_mst.source_data IS 'データ取得元。Table名';
COMMENT ON COLUMN abf_item_mapping_mst.target_data IS 'データ連携先。Table名、Fileパス等';
COMMENT ON COLUMN abf_item_mapping_mst.transfer_option IS '連携方法。INSERTINTO,CORSORLOOP等';
COMMENT ON COLUMN abf_item_mapping_mst.optimizer_hint IS 'SQLに追加指定するオプティマイザヒント';
COMMENT ON COLUMN abf_item_mapping_mst.diff_import IS '差分のみ取込か、初期化して全件再取込か';
COMMENT ON COLUMN abf_item_mapping_mst.create_user IS 'データレコード作成者のユーザーID';
COMMENT ON COLUMN abf_item_mapping_mst.creation_date IS 'データレコード作成日時';
COMMENT ON COLUMN abf_item_mapping_mst.update_user IS 'データレコード更新者のユーザーID';
COMMENT ON COLUMN abf_item_mapping_mst.update_date IS 'データレコード更新日時';


CREATE OR REPLACE TRIGGER abf_item_mapping_mst_trg
/******************************************************************/
-- 登録日(INSERT)または、最終更新日(UPDATE)をセットするトリガー
-- 新規作成時は登録日も設定。更新時は登録日、最終更新日を設定
/******************************************************************/
BEFORE INSERT OR UPDATE ON abf_item_mapping_mst
FOR EACH ROW    -- <------行トリガーの指定
BEGIN
    IF INSERTING THEN                  -- INSERTの時
        :NEW.update_date := SYSDATE;
        IF :NEW.creation_date IS NULL THEN
            :NEW.creation_date := SYSDATE;
        END IF;
    ELSE                               -- UPDATEの時
        :NEW.update_date := SYSDATE;
    END IF;
END;
/
