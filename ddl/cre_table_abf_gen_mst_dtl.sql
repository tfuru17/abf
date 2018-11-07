--==========================================================
-- Table Name : ABF_GEN_MST_DTL
-- Meaning : ABF汎用マスタ明細
--==========================================================
-- CREATE TABLE
CREATE TABLE abf_gen_mst_dtl (
mst_type NVARCHAR2(30) NOT NULL
,key1 NVARCHAR2(30) NOT NULL
,key2 NVARCHAR2(30) NULL
,key3 NVARCHAR2(30) NULL
,key4 NVARCHAR2(30) NULL
,key5 NVARCHAR2(30) NULL
,val1 NVARCHAR2(120) NOT NULL
,val2 NVARCHAR2(120) 
,val3 NVARCHAR2(120) 
,val4 NVARCHAR2(120) 
,val5 NVARCHAR2(120) 
,val6 NVARCHAR2(120) 
,val7 NVARCHAR2(120) 
,val8 NVARCHAR2(120) 
,val9 NVARCHAR2(120) 
,val10 NVARCHAR2(120) 
,enable_flg NVARCHAR2(120) 
,create_user NVARCHAR2(30) NOT NULL
,creation_date TIMESTAMP NOT NULL
,update_user NVARCHAR2(30) NOT NULL
,update_date TIMESTAMP NOT NULL);

-- DDL(ADD CONSTRAINT)
CREATE UNIQUE INDEX abf_gen_mst_dtl_UQ ON abf_gen_mst_dtl (
mst_type
,key1
,key2
,key3
,key4
,key5
);

-- COMMENT
COMMENT ON TABLE abf_gen_mst_dtl IS '汎用マスタ明細';
COMMENT ON COLUMN abf_gen_mst_dtl.mst_type IS 'マスタタイプコード';
COMMENT ON COLUMN abf_gen_mst_dtl.key1 IS 'キー項目１の値';
COMMENT ON COLUMN abf_gen_mst_dtl.key2 IS 'キー項目２の値';
COMMENT ON COLUMN abf_gen_mst_dtl.key3 IS 'キー項目３の値';
COMMENT ON COLUMN abf_gen_mst_dtl.key4 IS 'キー項目４の値';
COMMENT ON COLUMN abf_gen_mst_dtl.key5 IS 'キー項目５の値';
COMMENT ON COLUMN abf_gen_mst_dtl.val1 IS 'キー項目１～５に対応する値１';
COMMENT ON COLUMN abf_gen_mst_dtl.val2 IS 'キー項目１～５に対応する値２';
COMMENT ON COLUMN abf_gen_mst_dtl.val3 IS 'キー項目１～５に対応する値３';
COMMENT ON COLUMN abf_gen_mst_dtl.val4 IS 'キー項目１～５に対応する値４';
COMMENT ON COLUMN abf_gen_mst_dtl.val5 IS 'キー項目１～５に対応する値５';
COMMENT ON COLUMN abf_gen_mst_dtl.val6 IS 'キー項目１～５に対応する値６';
COMMENT ON COLUMN abf_gen_mst_dtl.val7 IS 'キー項目１～５に対応する値７';
COMMENT ON COLUMN abf_gen_mst_dtl.val8 IS 'キー項目１～５に対応する値８';
COMMENT ON COLUMN abf_gen_mst_dtl.val9 IS 'キー項目１～５に対応する値９';
COMMENT ON COLUMN abf_gen_mst_dtl.val10 IS 'キー項目１～５に対応する値１０';
COMMENT ON COLUMN abf_gen_mst_dtl.enable_flg IS '有効フラグ';
COMMENT ON COLUMN abf_gen_mst_dtl.create_user IS 'データレコード作成者のユーザーID';
COMMENT ON COLUMN abf_gen_mst_dtl.creation_date IS 'データレコード作成日時';
COMMENT ON COLUMN abf_gen_mst_dtl.update_user IS 'データレコード更新者のユーザーID';
COMMENT ON COLUMN abf_gen_mst_dtl.update_date IS 'データレコード更新日時';

CREATE OR REPLACE TRIGGER abf_gen_mst_dtl_trg
/******************************************************************/
-- 登録日(INSERT)または、最終更新日(UPDATE)をセットするトリガー
-- 新規作成時は登録日も設定。更新時は登録日、最終更新日を設定
/******************************************************************/
BEFORE  INSERT OR UPDATE ON abf_gen_mst_dtl
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
