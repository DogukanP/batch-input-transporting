*&---------------------------------------------------------------------*
*& Report ZDOP_XML_READ
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdop_xml_read.

PARAMETERS : pa_dosya TYPE c LENGTH 128 LOWER CASE OBLIGATORY.

DATA : BEGIN OF gs_kitap,
        yazar    TYPE c LENGTH 40,
        baslik   TYPE c LENGTH 40,
        fiyat    TYPE c LENGTH 40,
        yayinevi TYPE c LENGTH 40,
       END OF gs_kitap.

DATA : gt_kitap LIKE TABLE OF gs_kitap.

DATA : gv_xml TYPE xstring.
DATA : go_alv TYPE REF TO cl_salv_table.


AT SELECTION-SCREEN ON VALUE-REQUEST FOR pa_dosya.
  PERFORM dosya_adini_al CHANGING pa_dosya.

START-OF-SELECTION.
  PERFORM xml_dosyasini_yukle CHANGING gv_xml.

  PERFORM xml_convert_itab USING gv_xml CHANGING gt_kitap.

  CALL METHOD cl_salv_table=>factory
    IMPORTING
      r_salv_table  = go_alv
    CHANGING
      t_table       = gt_kitap.

  go_alv->display( ).
*&---------------------------------------------------------------------*
*& Form DOSYA_ADINI_AL
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      <-- PA_DOSYA
*&---------------------------------------------------------------------*
FORM dosya_adini_al  CHANGING cv_dosya_adi TYPE char128.
  DATA : lv_dizin TYPE string,
         lt_dosyalar TYPE filetable,
         ls_dosya LIKE LINE OF lt_dosyalar,
         lv_dosya_sayisi TYPE i.

  CALL METHOD cl_gui_frontend_services=>get_desktop_directory
    CHANGING
      desktop_directory = lv_dizin.


  CALL METHOD cl_gui_frontend_services=>file_open_dialog
    EXPORTING
      window_title      = 'KİTAPLAR'
      initial_directory = lv_dizin
      file_filter       = '*.XML'
      multiselection    = ' '
    CHANGING
      file_table        = lt_dosyalar
      rc                = lv_dosya_sayisi.

  IF lv_dosya_sayisi = 1.
    READ TABLE lt_dosyalar INTO ls_dosya INDEX 1.
    IF sy-subrc IS INITIAL.
      cv_dosya_adi = ls_dosya-filename.
    ENDIF.
  ELSE.
    MESSAGE 'HATA' TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form XML_DOSYASINI_YUKLE
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      <-- GV_XML
*&---------------------------------------------------------------------*
FORM xml_dosyasini_yukle  CHANGING cv_xml_icerik TYPE xstring.
  DATA : lv_dosya_adi  TYPE string.
  DATA : lt_dosya_icerik TYPE TABLE OF x255.
  DATA : lv_dosya_uzunlugu TYPE i.

  lv_dosya_adi = pa_dosya.

  CALL METHOD cl_gui_frontend_services=>gui_upload
    EXPORTING
      filename                       = lv_dosya_adi
      filetype                       = 'BIN'
    IMPORTING
      filelength                     = lv_dosya_uzunlugu
    CHANGING
      data_tab                       = lt_dosya_icerik.

  CALL FUNCTION 'SCMS_BINARY_TO_XSTRING'
    EXPORTING
      input_length = lv_dosya_uzunlugu
    IMPORTING
      buffer       = cv_xml_icerik
    TABLES
      binary_tab   = lt_dosya_icerik.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form XML_CONVERT_ITAB
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GV_XML
*&      <-- GT_KITAP
*&---------------------------------------------------------------------*
FORM xml_convert_itab  USING    iv_xml_icerik TYPE xstring
                       CHANGING ct_kitap LIKE gt_kitap.

  DATA : lo_ixml    TYPE REF TO if_ixml,
         lo_streamfactory TYPE REF TO if_ixml_stream_factory,
         lo_parser TYPE REF TO if_ixml_parser,
         lo_istream TYPE REF TO if_ixml_istream,
         lo_xml_doc TYPE REF TO if_ixml_document,
         lo_xml_node TYPE REF TO if_ixml_node,
         lv_sonuc TYPE i.

  lo_ixml = cl_ixml=>create( ).
  lo_streamfactory = lo_ixml->create_stream_factory( ).
  lo_istream = lo_streamfactory->create_istream_xstring( string = iv_xml_icerik ).
  lo_xml_doc = lo_ixml->create_document( ).
  lo_parser = lo_ixml->create_parser(
    document = lo_xml_doc
    stream_factory = lo_streamfactory
    istream = lo_istream ).

  lv_sonuc = lo_parser->parse( ).

  IF lv_sonuc <> 0.
    MESSAGE 'HATA' TYPE 'S' DISPLAY LIKE 'E'.
  ELSE.
    PERFORM xml_doc_convert_itab USING lo_xml_doc CHANGING ct_kitap.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form XML_DOC_CONVERT_ITAB
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> LO_CML_DOC
*&      <-- CT_KITAP
*&---------------------------------------------------------------------*
FORM xml_doc_convert_itab  USING    io_xml_doc TYPE REF TO if_ixml_document
                           CHANGING ct_kitap LIKE gt_kitap.
  DATA : lo_xml_node TYPE REF TO if_ixml_node,
         lo_iterator TYPE REF TO if_ixml_node_iterator,
         lv_node_ismi TYPE string,
         ls_kitap LIKE LINE OF gt_kitap,
         lv_deger TYPE string.

  lo_xml_node ?= io_xml_doc.

  IF lo_xml_node IS INITIAL.
    RETURN.
  ELSE.
    lo_iterator = lo_xml_node->create_iterator( ).
    lo_xml_node = lo_iterator->get_next( ).
    WHILE lo_xml_node IS NOT INITIAL.
      lv_node_ismi = lo_xml_node->get_name( ).
      lv_deger     = lo_xml_node->get_value( ).
      CASE lv_node_ismi.
        WHEN 'yazar'.
          ls_kitap-yazar = lv_deger.
        WHEN 'baslik'.
          ls_kitap-baslik = lv_deger.
        WHEN 'fiyat'.
          ls_kitap-fiyat = lv_deger.
        WHEN 'yayinevi'.
          ls_kitap-yayinevi = lv_deger.
          APPEND ls_kitap TO ct_kitap.
          CLEAR ls_kitap.
      ENDCASE.
      lo_xml_node = lo_iterator->get_next( ).
    ENDWHILE.
  ENDIF.
ENDFORM.
