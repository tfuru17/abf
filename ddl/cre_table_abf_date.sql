--==========================================================
-- Table Name : ABF_DATE
-- Meaning : ABF日付管理
--==========================================================
-- CREATE TABLE
CREATE TABLE abf_date (
date_type NVARCHAR2(30) NOT NULL
,date_value DATE NOT NULL
,enable_flg NVARCHAR2(1) NOT NULL
,create_user NVARCHAR2(30) NOT NULL
,creation_date TIMESTAMP NOT NULL
,update_user NVARCHAR2(30) NOT NULL
,update_date TIMESTAMP NOT NULL);

-- DDL(ADD CONSTRAINT)
ALTER TABLE abf_date ADD CONSTRAINT abf_date_pk PRIMARY KEY(
date_type
);

-- COMMENT
COMMENT ON TABLE abf_date IS '日付管理';
COMMENT ON COLUMN abf_date.date_type IS '管理する日付の種類';
COMMENT ON COLUMN abf_date.date_value IS '管理される日付の値';
COMMENT ON COLUMN abf_date.enable_flg IS '有効フラグ';
COMMENT ON COLUMN abf_date.create_user IS 'データレコード作成者のユーザーID';
COMMENT ON COLUMN abf_date.creation_date IS 'データレコード作成日時';
COMMENT ON COLUMN abf_date.update_user IS 'データレコード更新者のユーザーID';
COMMENT ON COLUMN abf_date.update_date IS 'データレコード更新日時';


CREATE OR REPLACE TRIGGER abf_date_trg
/******************************************************************/
-- 登録日(INSERT)または、最終更新日(UPDATE)をセットするトリガー
-- 新規作成時は登録日も設定。更新時は登録日、最終更新日を設定
/******************************************************************/
BEFORE INSERT OR UPDATE ON abf_date
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
