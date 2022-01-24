*&---------------------------------------------------------------------*
*& Report ZDOP_BAPI_USER_GET_DATAIL
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDOP_BAPI_USER_GET_DATAIL.

DATA : LV_USERNAME TYPE BAPIBNAME-BAPIBNAME,
       LS_LOGON    TYPE BAPILOGOND,
       LS_ADDRESS  TYPE BAPIADDR3,
       LS_COMPANY  TYPE BAPIUSCOMP,
       LT_RETURN   TYPE BAPIRET2 OCCURS 0 WITH HEADER LINE.

LV_USERNAME = 'XDOGUKANP'.
*LS_LOGON
*LS_ADDRESS
*LS_COMPANY

CALL FUNCTION 'BAPI_USER_GET_DETAIL'
  EXPORTING
    username             = LV_USERNAME
*   CACHE_RESULTS        = 'X'
 IMPORTING
   LOGONDATA            = LS_LOGON
*   DEFAULTS             =
   ADDRESS              = LS_ADDRESS
   COMPANY              = LS_COMPANY
*   SNC                  =
*   REF_USER             =
*   ALIAS                =
*   UCLASS               =
*   LASTMODIFIED         =
*   ISLOCKED             =
*   IDENTITY             =
*   ADMINDATA            =
*   DESCRIPTION          =
*   TECH_USER            =
  tables
*   PARAMETER            =
*   PROFILES             =
*   ACTIVITYGROUPS       =
    return               = LT_RETURN
*   ADDTEL               =
*   ADDFAX               =
*   ADDTTX               =
*   ADDTLX               =
*   ADDSMTP              =
*   ADDRML               =
*   ADDX400              =
*   ADDRFC               =
*   ADDPRT               =
*   ADDSSF               =
*   ADDURI               =
*   ADDPAG               =
*   ADDCOMREM            =
*   PARAMETER1           =
*   GROUPS               =
*   UCLASSSYS            =
*   EXTIDHEAD            =
*   EXTIDPART            =
*   SYSTEMS              =
          .
BREAK-POINT.
