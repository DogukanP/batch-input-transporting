*&---------------------------------------------------------------------*
*& Report ZDOP_KLASIK_BADI_ORNEK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDOP_KLASIK_BADI_ORNEK.

DATA:gs_vbak       TYPE vbak,
     gs_vbap       TYPE vbap,
     gt_vbap       TYPE vbap_t,
     go_satis_badi TYPE REF TO zif_ex_dop_satis_badi.

PARAMETERS pa_vbeln TYPE vbeln_va.

START-OF-SELECTION.

*Satis dokumanı başlık bilgilerini veritabanından oku

  SELECT SINGLE * FROM vbak
    INTO gs_vbak
    WHERE vbeln = pa_vbeln.


  IF sy-subrc IS NOT INITIAL.
    MESSAGE 'Kayit bulunamadi' TYPE 'I'.
    RETURN.
  ELSE.
*Satış dokumanı kalem bilgilerini veritabanından oku
    SELECT * FROM vbap
      INTO TABLE gt_vbap
      WHERE vbeln = pa_vbeln.
  ENDIF.

*Business-Add in nesnesinin oluşturulması

  CALL METHOD cl_exithandler=>get_instance
    EXPORTING
      exit_name                     = 'ZDOP_SATIS_BADI'
    CHANGING
      instance                      = go_satis_badi
    EXCEPTIONS
      no_reference                  = 1
      no_interface_reference        = 2
      no_exit_interface             = 3
      class_not_implement_interface = 4
      single_exit_multiply_active   = 5
      cast_error                    = 6
      exit_not_existing             = 7
      data_incons_in_exit_managem   = 8
      OTHERS                        = 9.

  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

*Business Add-ln metodunun çağrılarak kayıtların filtrelenmesi

  CALL METHOD go_satis_badi->satis_dokumani_filtrele
    CHANGING
      cs_vbak = gs_vbak
      ct_vbap = gt_vbap.

*Satıs dokumanı başlık bilgilerinin yazdırılması

  WRITE :/ gs_vbak-vbeln, gs_vbak-audat, gs_vbak-vbtyp, gs_vbak-auart.

  SKIP 2.

*Satıs dokumanı kalem bilgilerinin yazdırılması

  LOOP AT gt_vbap INTO gs_vbap.
    WRITE:/ gs_vbap-posnr, gs_vbap-matnr, gs_vbap-matwa, gs_vbap-matkl, gs_vbap-pstyv.
  ENDLOOP.
