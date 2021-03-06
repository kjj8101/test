CREATE TABLE WMRPT_DATE_DIM (
  DATE_RID                          NUMBER(8)       NOT NULL,
  MIDNITE_EPOCH                     NUMBER(19)      ,
  DAY_ID                            NUMBER(6)       ,
  DAY_WEEK                          NUMBER(1)       ,
  DAY_MONTH                         NUMBER(2)       ,
  DAY_YEAR                          NUMBER(3)       ,
  DAY_NAME                          VARCHAR2(32)    ,
  DY                                VARCHAR2(16)    ,
  YYYY_MM_DD                        CHAR(10)        ,
  WEEK_ID                           NUMBER(4)       ,
  WEEK_YEAR                         NUMBER(2)       ,
  WW_YY                             CHAR(7)         ,
  MONTH_ID                          NUMBER(3)       ,
  MONTH_NAME                        VARCHAR2(32)    ,
  MON                               VARCHAR2(16)    ,
  MONTH_YEAR                        NUMBER(2)       ,
  MON_YY                            VARCHAR2(16)    ,
  MM_YY                             CHAR(5)         ,
  QTR_ID                            NUMBER(3)       ,
  QTR_YEAR                          NUMBER(1)       ,
  Q_YY                              CHAR(5)         ,
  YEAR_ID                           NUMBER(2)       ,
  YEAR_NUM                          NUMBER(4)       ,
  YR_NUM                            NUMBER(2)       ,
  YYYY                              CHAR(4)         ,
  HOLIDAY                           VARCHAR2(32)    ,
  WEEKDAY                           VARCHAR2(32)    ,
  FULL_DATE                         DATE            
);

ALTER TABLE WMRPT_DATE_DIM ADD (
  CONSTRAINT PKDATEDIM PRIMARY KEY (DATE_RID)
);

CREATE INDEX IDXDATEDIM_YEARID ON WMRPT_DATE_DIM (
  YEAR_ID
);

CREATE INDEX IDXDATEDIM_DAYID ON WMRPT_DATE_DIM (
  DAY_ID
);

CREATE INDEX IDXDATEDIM_QTRID ON WMRPT_DATE_DIM (
  QTR_ID
);

CREATE INDEX IDXDATEDIM_WEEKID ON WMRPT_DATE_DIM (
  WEEK_ID
);

CREATE TABLE WMRPT_TIME_DIM (
  TIME_RID                          NUMBER(4)       NOT NULL,
  HH24                              NUMBER(2)       ,
  MI                                NUMBER(2)       ,
  HH24MI                            CHAR(8)         ,
  HH12MI                            CHAR(8)         ,
  AM_PM                             CHAR(2)         
);

ALTER TABLE WMRPT_TIME_DIM ADD (
  CONSTRAINT PKTIMEDIM PRIMARY KEY (TIME_RID)
);

CREATE INDEX IDXTIMEDIM_HH ON WMRPT_TIME_DIM (
  HH24
);

CREATE TABLE WMRPT_USER_DIM (
  USER_RID                          NUMBER(6)       NOT NULL,
  USER_NAME                         VARCHAR2(128)   NOT NULL
);

ALTER TABLE WMRPT_USER_DIM ADD (
  CONSTRAINT PKUSERDIM PRIMARY KEY (USER_RID)
);

CREATE INDEX IDXUSERDIM_NAME ON WMRPT_USER_DIM (
  USER_NAME
);

CREATE TABLE WMRPT_ROLE_DIM (
  ROLE_RID                          NUMBER(4)       NOT NULL,
  ROLE_NAME                         VARCHAR2(128)   NOT NULL
);

ALTER TABLE WMRPT_ROLE_DIM ADD (
  CONSTRAINT PKROLEDIM PRIMARY KEY (ROLE_RID)
);

CREATE INDEX IDXROLEDIM_NAME ON WMRPT_ROLE_DIM (
  ROLE_NAME
);

CREATE TABLE WMRPT_FAIL_TYPE_DIM (
  FAIL_TYPE_RID                     NUMBER(2)       NOT NULL,
  FAIL_TYPE_STAT                    NUMBER(8)       NOT NULL,
  FAIL_TYPE_DESC                    VARCHAR2(64)    NOT NULL
);

ALTER TABLE WMRPT_FAIL_TYPE_DIM ADD (
  CONSTRAINT PKFAILTYPEDIM PRIMARY KEY (FAIL_TYPE_RID)
);

CREATE TABLE WMRPT_MODEL_DIM (
  MODEL_RID                         NUMBER(4)       NOT NULL,
  PROCESS_KEY                       VARCHAR2(64)    NOT NULL,
  MODEL_NAME                        VARCHAR2(1024)  NOT NULL,
  MODEL_DESC                        VARCHAR2(1024)  ,
  MODEL_TYPE                        NUMBER(2)       ,
  MODEL_TYPE_DESC                   VARCHAR2(64)    ,
  MODEL_USER_RID                    NUMBER(6)       DEFAULT  0 NOT NULL,
  DEPL_DATE_RID                     NUMBER(8)       DEFAULT -1 NOT NULL,
  DEPL_TIME_RID                     NUMBER(4)       DEFAULT -1 NOT NULL,
  DEPL_EPOCH                        NUMBER(19)      ,
  AUTO_STEP_QTY                     NUMBER(3)       ,
  WF_STEP_QTY                       NUMBER(3)       ,
  STEP_QTY                          NUMBER(4)       ,
  LOGC_SRVR_QTY                     NUMBER(3)       
);

ALTER TABLE WMRPT_MODEL_DIM ADD (
  CONSTRAINT PKMODELDIM PRIMARY KEY (MODEL_RID)
);

ALTER TABLE WMRPT_MODEL_DIM ADD (
  CONSTRAINT FKMODELDIM_USER FOREIGN KEY (MODEL_USER_RID)
  REFERENCES WMRPT_USER_DIM (USER_RID)
);

ALTER TABLE WMRPT_MODEL_DIM ADD (
  CONSTRAINT FKMODELDIM_DEPLDT FOREIGN KEY (DEPL_DATE_RID)
  REFERENCES WMRPT_DATE_DIM (DATE_RID)
);

ALTER TABLE WMRPT_MODEL_DIM ADD (
  CONSTRAINT FKMODELDIM_DEPLTM FOREIGN KEY (DEPL_TIME_RID)
  REFERENCES WMRPT_TIME_DIM (TIME_RID)
);

CREATE TABLE WMRPT_STEP_DIM (
  STEP_RID                          NUMBER(6)       NOT NULL,
  MODEL_RID                         NUMBER(4)       NOT NULL,
  PROCESS_KEY                       VARCHAR2(64)    ,
  MODEL_NAME                        VARCHAR2(1024)  ,
  STEP_ID                           VARCHAR2(128)   NOT NULL,
  STEP_NAME                         VARCHAR2(1024)  NOT NULL,
  STEP_DESC                         VARCHAR2(1024)  ,
  STEP_TYPE                         NUMBER(2)       ,
  STEP_TYPE_DESC                    VARCHAR2(64)    ,
  LOGC_SRVR                         VARCHAR2(128)   ,
  STEP_CMPN                         VARCHAR2(1024)  
);

ALTER TABLE WMRPT_STEP_DIM ADD (
  CONSTRAINT PKSTEPDIM PRIMARY KEY (STEP_RID)
);

CREATE INDEX IDXSTEPDIM_MDLRID ON WMRPT_STEP_DIM (
  MODEL_RID
);

ALTER TABLE WMRPT_STEP_DIM ADD (
  CONSTRAINT FKSTEPDIM_MODEL FOREIGN KEY (MODEL_RID)
  REFERENCES WMRPT_MODEL_DIM (MODEL_RID)
);

CREATE TABLE WMRPT_INST_ACCUM (
  INST_ID                           CHAR(32)        NOT NULL,
  INST_ITER                         NUMBER(3)       NOT NULL,
  MODEL_RID                         NUMBER(4)       NOT NULL,
  CUSTOM_ID                         VARCHAR2(512)   NOT NULL,
  PAR_INST_ID                       CHAR(32)        ,
  PAR_INST_ITER                     NUMBER(3)       ,
  INST_STEP_INST_QTY                NUMBER(3)       DEFAULT  0 NOT NULL,
  INST_STEP_ITER_QTY                NUMBER(6)       DEFAULT  0 NOT NULL,
  INST_AUTO_STEP_INST_QTY           NUMBER(3)       DEFAULT  0 NOT NULL,
  INST_AUTO_STEP_ITER_QTY           NUMBER(6)       DEFAULT  0 NOT NULL,
  INST_WF_STEP_INST_QTY             NUMBER(3)       DEFAULT  0 NOT NULL,
  INST_WF_STEP_ITER_QTY             NUMBER(6)       DEFAULT  0 NOT NULL,
  INST_STRT_TIME_RID                NUMBER(4)       DEFAULT -1 NOT NULL,
  INST_STRT_DATE_RID                NUMBER(8)       DEFAULT -1 NOT NULL,
  INST_STRT_EPOCH                   NUMBER(19)      ,
  INST_COMP_TIME_RID                NUMBER(4)       DEFAULT -1 NOT NULL,
  INST_COMP_DATE_RID                NUMBER(8)       DEFAULT -1 NOT NULL,
  INST_COMP_EPOCH                   NUMBER(19)      ,
  INST_COMP_DUR                     NUMBER(11,3)    ,
  INST_FAIL_TYPE_RID                NUMBER(2)       DEFAULT  0 NOT NULL,
  INST_FAIL_TIME_RID                NUMBER(4)       DEFAULT -1 NOT NULL,
  INST_FAIL_DATE_RID                NUMBER(8)       DEFAULT -1 NOT NULL,
  INST_FAIL_EPOCH                   NUMBER(19)      ,
  INST_FAIL_DUR                     NUMBER(11,3)    ,
  INST_END_TIME_RID                 NUMBER(4)       DEFAULT -1 NOT NULL,
  INST_END_DATE_RID                 NUMBER(8)       DEFAULT -1 NOT NULL,
  INST_CANC_QTY                     NUMBER(1)       DEFAULT  0 NOT NULL,
  INST_RSUB_QTY                     NUMBER(3)       DEFAULT  0 NOT NULL,
  INST_SUSP_QTY                     NUMBER(3)       DEFAULT  0 NOT NULL,
  INST_RESM_QTY                     NUMBER(3)       DEFAULT  0 NOT NULL
);

ALTER TABLE WMRPT_INST_ACCUM ADD (
  CONSTRAINT PKINST PRIMARY KEY (INST_ID, INST_ITER)
);

CREATE INDEX IDXINST_FAILTP ON WMRPT_INST_ACCUM (
  INST_FAIL_TYPE_RID
);

CREATE INDEX IDXINST_COMPDTTM ON WMRPT_INST_ACCUM (
  INST_COMP_DATE_RID, INST_COMP_TIME_RID
);

CREATE INDEX IDXINST_MDLRID ON WMRPT_INST_ACCUM (
  MODEL_RID
);

CREATE INDEX IDXINST_ENDDTTM ON WMRPT_INST_ACCUM (
  INST_END_DATE_RID, INST_END_TIME_RID
);

CREATE INDEX IDXINST_FAILDTTM ON WMRPT_INST_ACCUM (
  INST_FAIL_DATE_RID, INST_FAIL_TIME_RID
);

CREATE INDEX IDXINST_STRTDTTM ON WMRPT_INST_ACCUM (
  INST_STRT_DATE_RID, INST_STRT_TIME_RID
);

ALTER TABLE WMRPT_INST_ACCUM ADD (
  CONSTRAINT FKINST_MODEL FOREIGN KEY (MODEL_RID)
  REFERENCES WMRPT_MODEL_DIM (MODEL_RID)
);

ALTER TABLE WMRPT_INST_ACCUM ADD (
  CONSTRAINT FKINST_STRTTM FOREIGN KEY (INST_STRT_TIME_RID)
  REFERENCES WMRPT_TIME_DIM (TIME_RID)
);

ALTER TABLE WMRPT_INST_ACCUM ADD (
  CONSTRAINT FKINST_STRTDT FOREIGN KEY (INST_STRT_DATE_RID)
  REFERENCES WMRPT_DATE_DIM (DATE_RID)
);

ALTER TABLE WMRPT_INST_ACCUM ADD (
  CONSTRAINT FKINST_COMPTM FOREIGN KEY (INST_COMP_TIME_RID)
  REFERENCES WMRPT_TIME_DIM (TIME_RID)
);

ALTER TABLE WMRPT_INST_ACCUM ADD (
  CONSTRAINT FKINST_COMPDT FOREIGN KEY (INST_COMP_DATE_RID)
  REFERENCES WMRPT_DATE_DIM (DATE_RID)
);

ALTER TABLE WMRPT_INST_ACCUM ADD (
  CONSTRAINT FKINST_FAILTYPE FOREIGN KEY (INST_FAIL_TYPE_RID)
  REFERENCES WMRPT_FAIL_TYPE_DIM (FAIL_TYPE_RID)
);

ALTER TABLE WMRPT_INST_ACCUM ADD (
  CONSTRAINT FKINST_FAILTM FOREIGN KEY (INST_FAIL_TIME_RID)
  REFERENCES WMRPT_TIME_DIM (TIME_RID)
);

ALTER TABLE WMRPT_INST_ACCUM ADD (
  CONSTRAINT FKINST_FAILDT FOREIGN KEY (INST_FAIL_DATE_RID)
  REFERENCES WMRPT_DATE_DIM (DATE_RID)
);

ALTER TABLE WMRPT_INST_ACCUM ADD (
  CONSTRAINT FKINST_ENDTM FOREIGN KEY (INST_END_TIME_RID)
  REFERENCES WMRPT_TIME_DIM (TIME_RID)
);

ALTER TABLE WMRPT_INST_ACCUM ADD (
  CONSTRAINT FKINST_ENDDT FOREIGN KEY (INST_END_DATE_RID)
  REFERENCES WMRPT_DATE_DIM (DATE_RID)
);

CREATE TABLE WMRPT_STEP_ACCUM (
  STEP_INST_ID                      CHAR(43)        NOT NULL,
  STEP_ITER                         NUMBER(3)       NOT NULL,
  CUSTOM_ID                         VARCHAR2(512)   NOT NULL,
  INST_ID                           CHAR(32)        NOT NULL,
  INST_ITER                         NUMBER(3)       NOT NULL,
  MODEL_RID                         NUMBER(4)       NOT NULL,
  STEP_RID                          NUMBER(6)       NOT NULL,
  STEP_PHYS_SRVR                    VARCHAR2(1040)  ,
  STEP_USER_RID                     NUMBER(6)       DEFAULT  0 NOT NULL,
  STEP_ROLE_RID                     NUMBER(4)       DEFAULT  0 NOT NULL,
  STEP_WAIT_TIME_RID                NUMBER(4)       DEFAULT -1 NOT NULL,
  STEP_WAIT_DATE_RID                NUMBER(8)       DEFAULT -1 NOT NULL,
  STEP_WAIT_EPOCH                   NUMBER(19)      ,
  STEP_WAIT_DUR                     NUMBER(11,3)    ,
  STEP_STRT_TIME_RID                NUMBER(4)       DEFAULT -1 NOT NULL,
  STEP_STRT_DATE_RID                NUMBER(8)       DEFAULT -1 NOT NULL,
  STEP_STRT_EPOCH                   NUMBER(19)      ,
  STEP_COMP_TIME_RID                NUMBER(4)       DEFAULT -1 NOT NULL,
  STEP_COMP_DATE_RID                NUMBER(8)       DEFAULT -1 NOT NULL,
  STEP_COMP_EPOCH                   NUMBER(19)      ,
  STEP_COMP_DUR                     NUMBER(11,3)    ,
  STEP_FAIL_TYPE_RID                NUMBER(2)       DEFAULT  0 NOT NULL,
  STEP_FAIL_TIME_RID                NUMBER(4)       DEFAULT -1 NOT NULL,
  STEP_FAIL_DATE_RID                NUMBER(8)       DEFAULT -1 NOT NULL,
  STEP_FAIL_EPOCH                   NUMBER(19)      ,
  STEP_FAIL_DUR                     NUMBER(11,3)    ,
  STEP_END_TIME_RID                 NUMBER(4)       DEFAULT -1 NOT NULL,
  STEP_END_DATE_RID                 NUMBER(8)       DEFAULT -1 NOT NULL,
  STEP_RSUB_QTY                     NUMBER(3)       DEFAULT  0 NOT NULL
);

ALTER TABLE WMRPT_STEP_ACCUM ADD (
  CONSTRAINT PKSTEP PRIMARY KEY (STEP_INST_ID, STEP_ITER)
);

CREATE INDEX IDXSTEP_USERRID ON WMRPT_STEP_ACCUM (
  STEP_USER_RID
);

CREATE INDEX IDXSTEP_ROLERID ON WMRPT_STEP_ACCUM (
  STEP_ROLE_RID
);

CREATE INDEX IDXSTEP_STPRID ON WMRPT_STEP_ACCUM (
  STEP_RID
);

CREATE INDEX IDXSTEP_STRTDTTM ON WMRPT_STEP_ACCUM (
  STEP_STRT_DATE_RID, STEP_STRT_TIME_RID
);

CREATE INDEX IDXSTEP_COMPDTTM ON WMRPT_STEP_ACCUM (
  STEP_COMP_DATE_RID, STEP_COMP_TIME_RID
);

CREATE INDEX IDXSTEP_FAILDTTM ON WMRPT_STEP_ACCUM (
  STEP_FAIL_DATE_RID, STEP_FAIL_TIME_RID
);

CREATE INDEX IDXSTEP_WAITDTTM ON WMRPT_STEP_ACCUM (
  STEP_WAIT_DATE_RID, STEP_WAIT_TIME_RID
);

CREATE INDEX IDXSTEP_IID ON WMRPT_STEP_ACCUM (
  INST_ID, INST_ITER
);

CREATE INDEX IDXSTEP_ENDDTTM ON WMRPT_STEP_ACCUM (
  STEP_END_DATE_RID, STEP_END_TIME_RID
);

CREATE INDEX IDXSTEP_MDLRID ON WMRPT_STEP_ACCUM (
  MODEL_RID
);

CREATE INDEX IDXSTEP_FAILTP ON WMRPT_STEP_ACCUM (
  STEP_FAIL_TYPE_RID
);

ALTER TABLE WMRPT_STEP_ACCUM ADD (
  CONSTRAINT FKSTEP_MODEL FOREIGN KEY (MODEL_RID)
  REFERENCES WMRPT_MODEL_DIM (MODEL_RID)
);

ALTER TABLE WMRPT_STEP_ACCUM ADD (
  CONSTRAINT FKSTEP_STEP FOREIGN KEY (STEP_RID)
  REFERENCES WMRPT_STEP_DIM (STEP_RID)
);

ALTER TABLE WMRPT_STEP_ACCUM ADD (
  CONSTRAINT FKSTEP_USER FOREIGN KEY (STEP_USER_RID)
  REFERENCES WMRPT_USER_DIM (USER_RID)
);

ALTER TABLE WMRPT_STEP_ACCUM ADD (
  CONSTRAINT FKSTEP_ROLE FOREIGN KEY (STEP_ROLE_RID)
  REFERENCES WMRPT_ROLE_DIM (ROLE_RID)
);

ALTER TABLE WMRPT_STEP_ACCUM ADD (
  CONSTRAINT FKSTEP_WAITTM FOREIGN KEY (STEP_WAIT_TIME_RID)
  REFERENCES WMRPT_TIME_DIM (TIME_RID)
);

ALTER TABLE WMRPT_STEP_ACCUM ADD (
  CONSTRAINT FKSTEP_WAITDT FOREIGN KEY (STEP_WAIT_DATE_RID)
  REFERENCES WMRPT_DATE_DIM (DATE_RID)
);

ALTER TABLE WMRPT_STEP_ACCUM ADD (
  CONSTRAINT FKSTEP_STRTTM FOREIGN KEY (STEP_STRT_TIME_RID)
  REFERENCES WMRPT_TIME_DIM (TIME_RID)
);

ALTER TABLE WMRPT_STEP_ACCUM ADD (
  CONSTRAINT FKSTEP_STRTDT FOREIGN KEY (STEP_STRT_DATE_RID)
  REFERENCES WMRPT_DATE_DIM (DATE_RID)
);

ALTER TABLE WMRPT_STEP_ACCUM ADD (
  CONSTRAINT FKSTEP_COMPTM FOREIGN KEY (STEP_COMP_TIME_RID)
  REFERENCES WMRPT_TIME_DIM (TIME_RID)
);

ALTER TABLE WMRPT_STEP_ACCUM ADD (
  CONSTRAINT FKSTEP_COMPDT FOREIGN KEY (STEP_COMP_DATE_RID)
  REFERENCES WMRPT_DATE_DIM (DATE_RID)
);

ALTER TABLE WMRPT_STEP_ACCUM ADD (
  CONSTRAINT FKSTEP_FAILTYPE FOREIGN KEY (STEP_FAIL_TYPE_RID)
  REFERENCES WMRPT_FAIL_TYPE_DIM (FAIL_TYPE_RID)
);

ALTER TABLE WMRPT_STEP_ACCUM ADD (
  CONSTRAINT FKSTEP_FAILTM FOREIGN KEY (STEP_FAIL_TIME_RID)
  REFERENCES WMRPT_TIME_DIM (TIME_RID)
);

ALTER TABLE WMRPT_STEP_ACCUM ADD (
  CONSTRAINT FKSTEP_FAILDT FOREIGN KEY (STEP_FAIL_DATE_RID)
  REFERENCES WMRPT_DATE_DIM (DATE_RID)
);

ALTER TABLE WMRPT_STEP_ACCUM ADD (
  CONSTRAINT FKSTEP_ENDTM FOREIGN KEY (STEP_END_TIME_RID)
  REFERENCES WMRPT_TIME_DIM (TIME_RID)
);

ALTER TABLE WMRPT_STEP_ACCUM ADD (
  CONSTRAINT FKSTEP_ENDDT FOREIGN KEY (STEP_END_DATE_RID)
  REFERENCES WMRPT_DATE_DIM (DATE_RID)
);

CREATE TABLE WMRPT_MODEL_HOUR (
  DATE_RID                          NUMBER(8)       NOT NULL,
  TIME_RID                          NUMBER(4)       NOT NULL,
  MODEL_RID                         NUMBER(4)       NOT NULL,
  MODEL_STRT_INST_QTY               NUMBER(6)       DEFAULT  0 NOT NULL,
  MODEL_COMP_INST_QTY               NUMBER(6)       DEFAULT  0 NOT NULL,
  MODEL_FAIL_INST_QTY               NUMBER(6)       DEFAULT  0 NOT NULL,
  MODEL_CANC_QTY                    NUMBER(6)       DEFAULT  0 NOT NULL,
  MODEL_SUSP_QTY                    NUMBER(6)       DEFAULT  0 NOT NULL,
  MODEL_RESM_QTY                    NUMBER(6)       DEFAULT  0 NOT NULL,
  MODEL_RSUB_QTY                    NUMBER(6)       DEFAULT  0 NOT NULL,
  MODEL_COMP_INST_MIN_DUR           NUMBER(11,3)    ,
  MODEL_COMP_INST_MAX_DUR           NUMBER(11,3)    ,
  MODEL_COMP_INST_SUM_DUR           NUMBER(11,3)    ,
  MODEL_FAIL_INST_MIN_DUR           NUMBER(11,3)    ,
  MODEL_FAIL_INST_MAX_DUR           NUMBER(11,3)    ,
  MODEL_FAIL_INST_SUM_DUR           NUMBER(11,3)    ,
  MODEL_STRT_ITER_QTY               NUMBER(6)       DEFAULT  0 NOT NULL,
  MODEL_COMP_ITER_QTY               NUMBER(6)       DEFAULT  0 NOT NULL,
  MODEL_FAIL_ITER_QTY               NUMBER(6)       DEFAULT  0 NOT NULL,
  MODEL_COMP_ITER_MIN_DUR           NUMBER(11,3)    ,
  MODEL_COMP_ITER_MAX_DUR           NUMBER(11,3)    ,
  MODEL_COMP_ITER_SUM_DUR           NUMBER(11,3)    ,
  MODEL_FAIL_ITER_MIN_DUR           NUMBER(11,3)    ,
  MODEL_FAIL_ITER_MAX_DUR           NUMBER(11,3)    ,
  MODEL_FAIL_ITER_SUM_DUR           NUMBER(11,3)    
);

ALTER TABLE WMRPT_MODEL_HOUR ADD (
  CONSTRAINT PKMODELHOUR PRIMARY KEY (DATE_RID, TIME_RID, MODEL_RID)
);

ALTER TABLE WMRPT_MODEL_HOUR ADD (
  CONSTRAINT FKMODELHOUR_DT FOREIGN KEY (DATE_RID)
  REFERENCES WMRPT_DATE_DIM (DATE_RID)
);

ALTER TABLE WMRPT_MODEL_HOUR ADD (
  CONSTRAINT FKMODELHOUR_TM FOREIGN KEY (TIME_RID)
  REFERENCES WMRPT_TIME_DIM (TIME_RID)
);

ALTER TABLE WMRPT_MODEL_HOUR ADD (
  CONSTRAINT FKMODELHOUR_MODEL FOREIGN KEY (MODEL_RID)
  REFERENCES WMRPT_MODEL_DIM (MODEL_RID)
);

CREATE TABLE WMRPT_MODEL_DAY (
  DATE_RID                          NUMBER(8)       NOT NULL,
  MODEL_RID                         NUMBER(4)       NOT NULL,
  MODEL_STRT_INST_QTY               NUMBER(6)       DEFAULT  0 NOT NULL,
  MODEL_COMP_INST_QTY               NUMBER(6)       DEFAULT  0 NOT NULL,
  MODEL_FAIL_INST_QTY               NUMBER(6)       DEFAULT  0 NOT NULL,
  MODEL_CANC_QTY                    NUMBER(6)       DEFAULT  0 NOT NULL,
  MODEL_SUSP_QTY                    NUMBER(6)       DEFAULT  0 NOT NULL,
  MODEL_RESM_QTY                    NUMBER(6)       DEFAULT  0 NOT NULL,
  MODEL_RSUB_QTY                    NUMBER(6)       DEFAULT  0 NOT NULL,
  MODEL_COMP_INST_MIN_DUR           NUMBER(11,3)    ,
  MODEL_COMP_INST_MAX_DUR           NUMBER(11,3)    ,
  MODEL_COMP_INST_SUM_DUR           NUMBER(11,3)    ,
  MODEL_FAIL_INST_MIN_DUR           NUMBER(11,3)    ,
  MODEL_FAIL_INST_MAX_DUR           NUMBER(11,3)    ,
  MODEL_FAIL_INST_SUM_DUR           NUMBER(11,3)    ,
  MODEL_STRT_ITER_QTY               NUMBER(6)       DEFAULT  0 NOT NULL,
  MODEL_COMP_ITER_QTY               NUMBER(6)       DEFAULT  0 NOT NULL,
  MODEL_FAIL_ITER_QTY               NUMBER(6)       DEFAULT  0 NOT NULL,
  MODEL_COMP_ITER_MIN_DUR           NUMBER(11,3)    ,
  MODEL_COMP_ITER_MAX_DUR           NUMBER(11,3)    ,
  MODEL_COMP_ITER_SUM_DUR           NUMBER(11,3)    ,
  MODEL_FAIL_ITER_MIN_DUR           NUMBER(11,3)    ,
  MODEL_FAIL_ITER_MAX_DUR           NUMBER(11,3)    ,
  MODEL_FAIL_ITER_SUM_DUR           NUMBER(11,3)    
);

ALTER TABLE WMRPT_MODEL_DAY ADD (
  CONSTRAINT PKMODELDAY PRIMARY KEY (DATE_RID, MODEL_RID)
);

ALTER TABLE WMRPT_MODEL_DAY ADD (
  CONSTRAINT FKMODELDAY_DT FOREIGN KEY (DATE_RID)
  REFERENCES WMRPT_DATE_DIM (DATE_RID)
);

ALTER TABLE WMRPT_MODEL_DAY ADD (
  CONSTRAINT FKMODELDAY_MODEL FOREIGN KEY (MODEL_RID)
  REFERENCES WMRPT_MODEL_DIM (MODEL_RID)
);

CREATE TABLE WMRPT_STEP_HOUR (
  DATE_RID                          NUMBER(8)       NOT NULL,
  TIME_RID                          NUMBER(4)       NOT NULL,
  MODEL_RID                         NUMBER(4)       NOT NULL,
  STEP_RID                          NUMBER(6)       NOT NULL,
  ROLE_RID                          NUMBER(4)       DEFAULT  0 NOT NULL,
  USER_RID                          NUMBER(6)       DEFAULT  0 NOT NULL,
  STEP_STRT_QTY                     NUMBER(8)       DEFAULT  0 NOT NULL,
  STEP_COMP_QTY                     NUMBER(8)       DEFAULT  0 NOT NULL,
  STEP_FAIL_QTY                     NUMBER(8)       DEFAULT  0 NOT NULL,
  STEP_EXCP_QTY                     NUMBER(8)       DEFAULT  0 NOT NULL,
  STEP_RTRY_QTY                     NUMBER(8)       DEFAULT  0 NOT NULL,
  STEP_EXPR_QTY                     NUMBER(8)       DEFAULT  0 NOT NULL,
  STEP_COMP_MIN_DUR                 NUMBER(11,3)    ,
  STEP_COMP_MAX_DUR                 NUMBER(11,3)    ,
  STEP_COMP_SUM_DUR                 NUMBER(11,3)    ,
  STEP_FAIL_MIN_DUR                 NUMBER(11,3)    ,
  STEP_FAIL_MAX_DUR                 NUMBER(11,3)    ,
  STEP_FAIL_SUM_DUR                 NUMBER(11,3)    ,
  STEP_EXCP_MIN_DUR                 NUMBER(11,3)    ,
  STEP_EXCP_MAX_DUR                 NUMBER(11,3)    ,
  STEP_EXCP_SUM_DUR                 NUMBER(11,3)    ,
  STEP_RTRY_MIN_DUR                 NUMBER(11,3)    ,
  STEP_RTRY_MAX_DUR                 NUMBER(11,3)    ,
  STEP_RTRY_SUM_DUR                 NUMBER(11,3)    ,
  STEP_EXPR_MIN_DUR                 NUMBER(11,3)    ,
  STEP_EXPR_MAX_DUR                 NUMBER(11,3)    ,
  STEP_EXPR_SUM_DUR                 NUMBER(11,3)    
);

ALTER TABLE WMRPT_STEP_HOUR ADD (
  CONSTRAINT PKSTEPHOUR PRIMARY KEY (DATE_RID, TIME_RID, STEP_RID, ROLE_RID, USER_RID)
);

CREATE INDEX IDXSTEPHR_MDLRID ON WMRPT_STEP_HOUR (
  MODEL_RID
);

ALTER TABLE WMRPT_STEP_HOUR ADD (
  CONSTRAINT FKSTEPHOUR_DT FOREIGN KEY (DATE_RID)
  REFERENCES WMRPT_DATE_DIM (DATE_RID)
);

ALTER TABLE WMRPT_STEP_HOUR ADD (
  CONSTRAINT FKSTEPHOUR_TM FOREIGN KEY (TIME_RID)
  REFERENCES WMRPT_TIME_DIM (TIME_RID)
);

ALTER TABLE WMRPT_STEP_HOUR ADD (
  CONSTRAINT FKSTEPHOUR_MODEL FOREIGN KEY (MODEL_RID)
  REFERENCES WMRPT_MODEL_DIM (MODEL_RID)
);

ALTER TABLE WMRPT_STEP_HOUR ADD (
  CONSTRAINT FKSTEPHOUR_STEP FOREIGN KEY (STEP_RID)
  REFERENCES WMRPT_STEP_DIM (STEP_RID)
);

ALTER TABLE WMRPT_STEP_HOUR ADD (
  CONSTRAINT FKSTEPHOUR_ROLE FOREIGN KEY (ROLE_RID)
  REFERENCES WMRPT_ROLE_DIM (ROLE_RID)
);

ALTER TABLE WMRPT_STEP_HOUR ADD (
  CONSTRAINT FKSTEPHOUR_USER FOREIGN KEY (USER_RID)
  REFERENCES WMRPT_USER_DIM (USER_RID)
);

CREATE TABLE WMRPT_STEP_DAY (
  DATE_RID                          NUMBER(8)       NOT NULL,
  MODEL_RID                         NUMBER(4)       NOT NULL,
  STEP_RID                          NUMBER(6)       NOT NULL,
  ROLE_RID                          NUMBER(4)       DEFAULT  0 NOT NULL,
  USER_RID                          NUMBER(6)       DEFAULT  0 NOT NULL,
  STEP_STRT_QTY                     NUMBER(8)       DEFAULT  0 NOT NULL,
  STEP_COMP_QTY                     NUMBER(8)       DEFAULT  0 NOT NULL,
  STEP_FAIL_QTY                     NUMBER(8)       DEFAULT  0 NOT NULL,
  STEP_EXCP_QTY                     NUMBER(8)       DEFAULT  0 NOT NULL,
  STEP_RTRY_QTY                     NUMBER(8)       DEFAULT  0 NOT NULL,
  STEP_EXPR_QTY                     NUMBER(8)       DEFAULT  0 NOT NULL,
  STEP_COMP_MIN_DUR                 NUMBER(11,3)    ,
  STEP_COMP_MAX_DUR                 NUMBER(11,3)    ,
  STEP_COMP_SUM_DUR                 NUMBER(11,3)    ,
  STEP_FAIL_MIN_DUR                 NUMBER(11,3)    ,
  STEP_FAIL_MAX_DUR                 NUMBER(11,3)    ,
  STEP_FAIL_SUM_DUR                 NUMBER(11,3)    ,
  STEP_EXCP_MIN_DUR                 NUMBER(11,3)    ,
  STEP_EXCP_MAX_DUR                 NUMBER(11,3)    ,
  STEP_EXCP_SUM_DUR                 NUMBER(11,3)    ,
  STEP_RTRY_MIN_DUR                 NUMBER(11,3)    ,
  STEP_RTRY_MAX_DUR                 NUMBER(11,3)    ,
  STEP_RTRY_SUM_DUR                 NUMBER(11,3)    ,
  STEP_EXPR_MIN_DUR                 NUMBER(11,3)    ,
  STEP_EXPR_MAX_DUR                 NUMBER(11,3)    ,
  STEP_EXPR_SUM_DUR                 NUMBER(11,3)    
);

ALTER TABLE WMRPT_STEP_DAY ADD (
  CONSTRAINT PKSTEPDAY PRIMARY KEY (DATE_RID, STEP_RID, ROLE_RID, USER_RID)
);

CREATE INDEX IDXSTEPDAY_MDLRID ON WMRPT_STEP_DAY (
  MODEL_RID
);

ALTER TABLE WMRPT_STEP_DAY ADD (
  CONSTRAINT FKSTEPDAY_DT FOREIGN KEY (DATE_RID)
  REFERENCES WMRPT_DATE_DIM (DATE_RID)
);

ALTER TABLE WMRPT_STEP_DAY ADD (
  CONSTRAINT FKSTEPDAY_MODEL FOREIGN KEY (MODEL_RID)
  REFERENCES WMRPT_MODEL_DIM (MODEL_RID)
);

ALTER TABLE WMRPT_STEP_DAY ADD (
  CONSTRAINT FKSTEPDAY_STEP FOREIGN KEY (STEP_RID)
  REFERENCES WMRPT_STEP_DIM (STEP_RID)
);

ALTER TABLE WMRPT_STEP_DAY ADD (
  CONSTRAINT FKSTEPDAY_ROLE FOREIGN KEY (ROLE_RID)
  REFERENCES WMRPT_ROLE_DIM (ROLE_RID)
);

ALTER TABLE WMRPT_STEP_DAY ADD (
  CONSTRAINT FKSTEPDAY_USER FOREIGN KEY (USER_RID)
  REFERENCES WMRPT_USER_DIM (USER_RID)
);

COMMIT;
