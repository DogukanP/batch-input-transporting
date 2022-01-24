*&---------------------------------------------------------------------*
*& Report ZDOP_CSV_READ
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdop_csv_read.

DATA : BEGIN OF gs_kna1,
        kunnr TYPE kna1-kunnr,
        land1 TYPE kna1-land1,
        name1 TYPE kna1-name1,
        name2 TYPE kna1-name2,
       END OF gs_kna1.
DATA : gt_kna1 LIKE  TABLE OF gs_kna1.
DATA : gv_satir type string,
       gt_satir type TABLE OF string,
       go_alv   type REF TO cl_salv_table.

PARAMETERS : pa_ayrac TYPE c LENGTH 1 DEFAULT ';'.

START-OF-SELECTION.

CALL FUNCTION 'GUI_UPLOAD'
  EXPORTING
    filename                      = 'C:\Users\Doğukan PADEL\Desktop\müsteri.csv'
*   FILETYPE                      = 'ASC'
*   HAS_FIELD_SEPARATOR           = ' '
*   HEADER_LENGTH                 = 0
*   READ_BY_LINE                  = 'X'
*   DAT_MODE                      = ' '
*   CODEPAGE                      = ' '
*   IGNORE_CERR                   = ABAP_TRUE
*   REPLACEMENT                   = '#'
*   CHECK_BOM                     = ' '
*   VIRUS_SCAN_PROFILE            =
*   NO_AUTH_CHECK                 = ' '
* IMPORTING
*   FILELENGTH                    =
*   HEADER                        =
  TABLES
    data_tab                      = gt_satir
* CHANGING
*   ISSCANPERFORMED               = ' '
* EXCEPTIONS
*   FILE_OPEN_ERROR               = 1
*   FILE_READ_ERROR               = 2
*   NO_BATCH                      = 3
*   GUI_REFUSE_FILETRANSFER       = 4
*   INVALID_TYPE                  = 5
*   NO_AUTHORITY                  = 6
*   UNKNOWN_ERROR                 = 7
*   BAD_DATA_FORMAT               = 8
*   HEADER_NOT_ALLOWED            = 9
*   SEPARATOR_NOT_ALLOWED         = 10
*   HEADER_TOO_LONG               = 11
*   UNKNOWN_DP_ERROR              = 12
*   ACCESS_DENIED                 = 13
*   DP_OUT_OF_MEMORY              = 14
*   DISK_FULL                     = 15
*   DP_TIMEOUT                    = 16
*   OTHERS                        = 17
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.

CHECK gt_satir IS NOT INITIAL.

LOOP AT gt_satir INTO gv_satir from 2.
  CLEAR gs_kna1.
  SPLIT gv_satir AT pa_ayrac INTO gs_kna1-kunnr
                                  gs_kna1-land1
                                  gs_kna1-name1
                                  gs_kna1-name2.
  IF gs_kna1 IS NOT INITIAL.
    APPEND gs_kna1 TO gt_kna1.
  ENDIF.
ENDLOOP.


CALL METHOD cl_salv_table=>factory
  IMPORTING
    r_salv_table = go_alv
  CHANGING
    t_table      = gt_kna1.

CALL METHOD go_alv->display.
