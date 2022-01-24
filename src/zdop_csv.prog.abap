*&---------------------------------------------------------------------*
*& Report ZDOP_CSV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdop_csv.

TYPE-POOLS truxs.

DATA : BEGIN OF gs_kna1,
        kunnr TYPE kna1-kunnr,
        land1 TYPE kna1-land1,
        name1 TYPE kna1-name1,
        name2 TYPE kna1-name2,
       END OF gs_kna1.
DATA : gt_kna1 LIKE  TABLE OF gs_kna1.

"kayıtları csv formatında tutacak tablo.

DATA : gt_csv TYPE truxs_t_text_data.

"csv de alanları birbirinden ayıran pr. tanımı
PARAMETERS pa_ayrac TYPE c LENGTH 1 DEFAULT ';' .

START-OF-SELECTION.

SELECT kunnr land1 name1 name2 FROM kna1 INTO TABLE gt_kna1 UP TO 100 ROWS.

CHECK sy-subrc IS INITIAL.

"internal tablonun csv convert işlemi
CALL FUNCTION 'SAP_CONVERT_TO_CSV_FORMAT'
 EXPORTING
   i_field_seperator          = pa_ayrac
*   I_LINE_HEADER              =
*   I_FILENAME                 =
*   I_APPL_KEEP                = ' '
  TABLES
    i_tab_sap_data             = gt_kna1
 CHANGING
   i_tab_converted_data       = gt_csv
* EXCEPTIONS
*   CONVERSION_FAILED          = 1
*   OTHERS                     = 2
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.

"desktop download

CALL FUNCTION 'GUI_DOWNLOAD'
  EXPORTING
*   BIN_FILESIZE                    =
    filename                        = 'C:\Users\Doğukan PADEL\Desktop\müsteri.csv'

  tables
    data_tab                        = gt_csv

          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.
