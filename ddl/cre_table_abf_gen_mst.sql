--==========================================================
-- Table Name : ABF_GEN_MST
-- Meaning : ABF汎用マスタ
--==========================================================
-- CREATE TABLE
CREATE TABLE abf_gen_mst (
mst_type NVARCHAR2(30) NOT NULL
,description NVARCHAR2(240) 
,enable_flg NVARCHAR2(1) NOT NULL
,key1_meaning NVARCHAR2(120) 
,key2_meaning NVARCHAR2(120) 
,key3_meaning NVARCHAR2(120) 
,key4_meaning NVARCHAR2(120) 
,key5_meaning NVARCHAR2(120) 
,val1_meaning NVARCHAR2(120) 
,val2_meaning NVARCHAR2(120) 
,val3_meaning NVARCHAR2(120) 
,val4_meaning NVARCHAR2(120) 
,val5_meaning NVARCHAR2(120) 
,val6_meaning NVARCHAR2(120) 
,val7_meaning NVARCHAR2(120) 
,val8_meaning NVARCHAR2(120) 
,val9_meaning NVARCHAR2(120) 
,val10_meaning NVARCHAR2(120) 
,create_user NVARCHAR2(30) NOT NULL
,creation_date TIMESTAMP NOT NULL
,update_user NVARCHAR2(30) NOT NULL
,update_date TIMESTAMP NOT NULL);

-- DDL(ADD CONSTRAINT)
ALTER TABLE abf_gen_mst ADD CONSTRAINT abf_gen_mst_pk PRIMARY KEY(
mst_type
);

-- COMMENT
COMMENT ON TABLE abf_gen_mst IS '汎用マスタ定義';
COMMENT ON COLUMN abf_gen_mst.mst_type IS 'マスタタイプコード';
COMMENT ON COLUMN abf_gen_mst.description IS 'マスタタイプの内容を補足する文言';
COMMENT ON COLUMN abf_gen_mst.enable_flg IS '有効フラグ';
COMMENT ON COLUMN abf_gen_mst.key1_meaning IS 'キー項目１の意味';
COMMENT ON COLUMN abf_gen_mst.key2_meaning IS 'キー項目２の意味';
COMMENT ON COLUMN abf_gen_mst.key3_meaning IS 'キー項目３の意味';
COMMENT ON COLUMN abf_gen_mst.key4_meaning IS 'キー項目４の意味';
COMMENT ON COLUMN abf_gen_mst.key5_meaning IS 'キー項目５の意味';
COMMENT ON COLUMN abf_gen_mst.val1_meaning IS '値１の意味';
COMMENT ON COLUMN abf_gen_mst.val2_meaning IS '値２の意味';
COMMENT ON COLUMN abf_gen_mst.val3_meaning IS '値３の意味';
COMMENT ON COLUMN abf_gen_mst.val4_meaning IS '値４の意味';
COMMENT ON COLUMN abf_gen_mst.val5_meaning IS '値５の意味';
COMMENT ON COLUMN abf_gen_mst.val6_meaning IS '値６の意味';
COMMENT ON COLUMN abf_gen_mst.val7_meaning IS '値７の意味';
COMMENT ON COLUMN abf_gen_mst.val8_meaning IS '値８の意味';
COMMENT ON COLUMN abf_gen_mst.val9_meaning IS '値９の意味';
COMMENT ON COLUMN abf_gen_mst.val10_meaning IS '値１０の意味';
COMMENT ON COLUMN abf_gen_mst.create_user IS 'データレコード作成者のユーザーID';
COMMENT ON COLUMN abf_gen_mst.creation_date IS 'データレコード作成日時';
COMMENT ON COLUMN abf_gen_mst.update_user IS 'データレコード更新者のユーザーID';
COMMENT ON COLUMN abf_gen_mst.update_date IS 'データレコード更新日時';


CREATE OR REPLACE TRIGGER abf_gen_mst_trg
/******************************************************************/
-- 登録日(INSERT)または、最終更新日(UPDATE)をセットするトリガー
-- 新規作成時は登録日も設定。更新時は登録日、最終更新日を設定
/******************************************************************/
BEFORE INSERT OR UPDATE ON abf_gen_mst
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
