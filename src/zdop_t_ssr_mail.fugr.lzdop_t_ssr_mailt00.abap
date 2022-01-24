*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZDOP_T_SSR_MAIL.................................*
DATA:  BEGIN OF STATUS_ZDOP_T_SSR_MAIL               .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZDOP_T_SSR_MAIL               .
CONTROLS: TCTRL_ZDOP_T_SSR_MAIL
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZDOP_T_SSR_MAIL               .
TABLES: ZDOP_T_SSR_MAIL                .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
