--==========================================================
-- Table Name : ABF_LOGS
-- Meaning : ABFログテーブル
--==========================================================
-- CREATE TABLE
CREATE TABLE abf_logs (
abf_log_id NUMBER NOT NULL
,proc_id NUMBER NOT NULL
,ora_log_id NUMBER 
,func_name NVARCHAR2(128) 
,start_dt DATE NOT NULL
,end_dt DATE
,status NVARCHAR2(10) NOT NULL
,result NVARCHAR2(10)
,description NVARCHAR2(120)
,create_user NVARCHAR2(30) NOT NULL
,creation_date TIMESTAMP NOT NULL
,update_user NVARCHAR2(30) NOT NULL
,update_date TIMESTAMP NOT NULL);

-- DDL(ADD CONSTRAINT)
ALTER TABLE abf_logs ADD CONSTRAINT abf_logs_pk PRIMARY KEY(
abf_log_id
);

-- COMMENT
COMMENT ON TABLE abf_logs IS '処理結果ログ';
COMMENT ON COLUMN abf_logs.abf_log_id IS 'ログが書き込まれる度に採番されるID(処理に限定されない)';
COMMENT ON COLUMN abf_logs.proc_id IS '実行された処理を表すID';
COMMENT ON COLUMN abf_logs.ora_log_id IS '実行されたジョブ(DBMS_SCHEDULE)を表すID';
COMMENT ON COLUMN abf_logs.func_name IS '機能を特定する文字列。パッケージ/プロシージャ名等';
COMMENT ON COLUMN abf_logs.start_dt IS '処理が開始された日時';
COMMENT ON COLUMN abf_logs.end_dt IS '処理が終了した日時';
COMMENT ON COLUMN abf_logs.status IS '処理の実行状態（実行中(E)、終了(F)、等）';
COMMENT ON COLUMN abf_logs.result IS '処理結果（正常、警告、異常等）';
COMMENT ON COLUMN abf_logs.description IS '処理状態の詳細';
COMMENT ON COLUMN abf_logs.create_user IS 'データレコード作成者のユーザーID';
COMMENT ON COLUMN abf_logs.creation_date IS 'データレコード作成日時';
COMMENT ON COLUMN abf_logs.update_user IS 'データレコード更新者のユーザーID';
COMMENT ON COLUMN abf_logs.update_date IS 'データレコード更新日時';

CREATE OR REPLACE TRIGGER abf_logs_trg
/******************************************************************/
-- 登録日(INSERT)または、最終更新日(UPDATE)をセットするトリガー
-- 新規作成時は登録日も設定。更新時は登録日、最終更新日を設定
/******************************************************************/
BEFORE  INSERT OR UPDATE ON abf_logs
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
