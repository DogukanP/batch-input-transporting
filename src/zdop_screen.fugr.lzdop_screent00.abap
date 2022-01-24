*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZDOP_T_KULLANICB................................*
DATA:  BEGIN OF STATUS_ZDOP_T_KULLANICB              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZDOP_T_KULLANICB              .
CONTROLS: TCTRL_ZDOP_T_KULLANICB
            TYPE TABLEVIEW USING SCREEN '0001'.
*...processing: ZDOP_T_SIRKETKB.................................*
DATA:  BEGIN OF STATUS_ZDOP_T_SIRKETKB               .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZDOP_T_SIRKETKB               .
CONTROLS: TCTRL_ZDOP_T_SIRKETKB
            TYPE TABLEVIEW USING SCREEN '0002'.
*.........table declarations:.................................*
TABLES: *ZDOP_T_KULLANICB              .
TABLES: *ZDOP_T_SIRKETKB               .
TABLES: ZDOP_T_KULLANICB               .
TABLES: ZDOP_T_SIRKETKB                .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
