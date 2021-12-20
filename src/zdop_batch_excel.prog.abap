*&---------------------------------------------------------------------*
*& Report ZDOP_BATCH_EXCEL
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdop_batch_excel.

INCLUDE zdop_batch_excel_top.
INCLUDE zdop_batch_excel_c01.
INCLUDE zdop_batxh_excel_f01.
INCLUDE zdop_batxh_excel_i01.
INCLUDE zdop_batxh_excel_o01.


AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.
  PERFORM open_file.
  PERFORM get_data.
START-OF-SELECTION.
  PERFORM show_data.
