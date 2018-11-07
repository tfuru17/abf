CREATE OR REPLACE PACKAGE ABF_C IS
/****************************************************************************＊
-- Package Name : ABF_C
-- Meaning :
-- Creation Date : 2016-04-23
-- Created by TFURUKAW
***************************************************************************＊*/
--
  -- General Constant Value Define.
  cv_yes        CONSTANT NVARCHAR2(1) := 'Y';
  cv_no         CONSTANT NVARCHAR2(1) := 'N';
  cv_dummy_user CONSTANT NVARCHAR2(1) := '0';
  cv_cm         CONSTANT NVARCHAR2(1) := ',';
  cv_spc        CONSTANT NVARCHAR2(1) := ' ';
  cv_pd         CONSTANT NVARCHAR2(1) := '.';
  cv_cln        CONSTANT NVARCHAR2(1) := ':';
  cv_eql        CONSTANT NVARCHAR2(1) := '=';
  cv_qt         CONSTANT NVARCHAR2(1) := '''';
  cv_wqt        CONSTANT NVARCHAR2(1) := '"';
  cv_op         CONSTANT NVARCHAR2(1) := '(';
  cv_cl         CONSTANT NVARCHAR2(1) := ')';
  cv_ins        CONSTANT NVARCHAR2(1) := 'I';
  cv_upd        CONSTANT NVARCHAR2(1) := 'U';
  cv_del        CONSTANT NVARCHAR2(1) := 'D';
  cv_sel        CONSTANT NVARCHAR2(1) := 'S';
  cv_lf         CONSTANT NVARCHAR2(1) := CHR(10);
--
  -- abf_logs.status
  cv_log_exec   CONSTANT NVARCHAR2(8) := 'EXEC';
  cv_log_fin    CONSTANT NVARCHAR2(8) := 'FIN';
  cv_log_normal CONSTANT abf_logs.result%TYPE := 'NORMAL';
  cv_log_warn   CONSTANT abf_logs.result%TYPE := 'WARNING';
  cv_log_error  CONSTANT abf_logs.result%TYPE := 'ERROR';
--
  -- APEX General value
  cv_app_user   CONSTANT NVARCHAR2(30) := 'APP_USER';
--
  -- Global Table/Record Value Define.
--
  -- EXCEPTION Define.
--
END ABF_C;
/
