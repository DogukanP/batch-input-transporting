interface YIF_ZDOP_BAPI_MATERIAL_DATA
  public .


  types:
    MATNR type C length 000040 .
  types:
    MTART type C length 000004 .
  types:
    MEINS type C length 000003 .
  types:
    MATKL type C length 000009 .
  types:
    MBRSH type C length 000001 .
  types:
    begin of ZDOP_BAPI_EXP_MATERIAL,
      MATNR type MATNR,
      MTART type MTART,
      MEINS type MEINS,
      MATKL type MATKL,
      MBRSH type MBRSH,
    end of ZDOP_BAPI_EXP_MATERIAL .
  types:
    BAPI_MTYPE type C length 000001 .
  types:
    SYMSGID type C length 000020 .
  types:
    SYMSGNO type N length 000003 .
  types:
    BAPI_MSG type C length 000220 .
  types:
    BALOGNR type C length 000020 .
  types:
    BALMNR type N length 000006 .
  types:
    SYMSGV type C length 000050 .
  types:
    BAPI_PARAM type C length 000032 .
  types:
    BAPI_FLD type C length 000030 .
  types:
    BAPILOGSYS type C length 000010 .
  types:
    begin of BAPIRET2,
      TYPE type BAPI_MTYPE,
      ID type SYMSGID,
      NUMBER type SYMSGNO,
      MESSAGE type BAPI_MSG,
      LOG_NO type BALOGNR,
      LOG_MSG_NO type BALMNR,
      MESSAGE_V1 type SYMSGV,
      MESSAGE_V2 type SYMSGV,
      MESSAGE_V3 type SYMSGV,
      MESSAGE_V4 type SYMSGV,
      PARAMETER type BAPI_PARAM,
      ROW type INT4,
      FIELD type BAPI_FLD,
      SYSTEM type BAPILOGSYS,
    end of BAPIRET2 .
  types:
    begin of ZDOP_BAPI_S_MATERIAL,
      MATNR type MATNR,
    end of ZDOP_BAPI_S_MATERIAL .
endinterface.
