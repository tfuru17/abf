--==========================================================
-- Table Name : ABF_LOG_DTL
-- Meaning : ABFログ明細テーブル
--==========================================================
-- CREATE TABLE
CREATE TABLE abf_log_dtl (
log_dtl_id NUMBER NOT NULL
,abf_log_id NUMBER NOT NULL
,position NVARCHAR2(30) NOT NULL
,sub_proc NVARCHAR2(128) NOT NULL
,dtl_desc NVARCHAR2(2000) NOT NULL
,upd_dt DATE NOT NULL);

-- DDL(ADD CONSTRAINT)
ALTER TABLE abf_log_dtl ADD CONSTRAINT abf_log_dtl_pk PRIMARY KEY(
log_dtl_id
);

-- DDL(CREATE UNIQUE INDEX)
CREATE UNIQUE INDEX abf_log_dtl_UQ ON abf_log_dtl (
abf_log_id
,position
);

-- COMMENT
COMMENT ON TABLE abf_log_dtl IS '処理結果ログ明細';
COMMENT ON COLUMN abf_log_dtl.log_dtl_id IS 'ログの明細レコードが書き込まれる度に採番されるID';
COMMENT ON COLUMN abf_log_dtl.abf_log_id IS 'ログが書き込まれる度に採番されるID';
COMMENT ON COLUMN abf_log_dtl.position IS 'ログ書き込み処理の発生位置';
COMMENT ON COLUMN abf_log_dtl.sub_proc IS '処理名(プロシージャ・関数名等）';
COMMENT ON COLUMN abf_log_dtl.dtl_desc IS 'ログ明細ごとの処理詳細';
COMMENT ON COLUMN abf_log_dtl.upd_dt IS 'ログ明細毎の書き込み日時';

