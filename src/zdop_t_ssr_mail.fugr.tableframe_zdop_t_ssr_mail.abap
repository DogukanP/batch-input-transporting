*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_ZDOP_T_SSR_MAIL
*   generation date: 08.11.2021 at 13:14:28
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_ZDOP_T_SSR_MAIL    .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.
