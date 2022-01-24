*&---------------------------------------------------------------------*
*& Report ZDOP_FILTER_BADI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDOP_FILTER_BADI.

DATA go_kdv_badi TYPE REF TO zif_ex_dop_filter_badi.
DATA gs_vbak TYPE vbak.

DATA gt_vbap TYPE vbap_t.
DATA gs_kna1 TYPE kna1.
DATA gv_kdv TYPE p.

PARAMETERS pa_vbeln TYPE vbeln_va.

START-OF-SELECTION.

  SELECT SINGLE * FROM vbak INTO gs_vbak WHERE vbeln = pa_vbeln.

  IF sy-subrc IS INITIAL.
    SELECT * FROM vbap INTO TABLE gt_vbap WHERE vbeln = pa_vbeln.
    SELECT SINGLE * FROM kna1 INTO gs_kna1 WHERE kunnr = gs_vbak-kunnr.
  ENDIF.

  CALL METHOD cl_exithandler=>get_instance
    EXPORTING
      exit_name = 'ZDOP_FILTER_BADI'
    CHANGING
      instance  = go_kdv_badi.

  CALL METHOD go_kdv_badi->kdv_hesapla
    EXPORTING
      is_vbak = gs_vbak
      it_vbap = gt_vbap
      flt_val = gs_kna1-land1
    IMPORTING
      ev_kdv  = gv_kdv.

  WRITE :/'KDV Miktari', gv_kdv.
