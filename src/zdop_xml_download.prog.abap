*&---------------------------------------------------------------------*
*& Report ZDOP_XML_DOWNLOAD
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdop_xml_download.

DATA : gs_mara           TYPE mara,
       go_xml_factory    TYPE REF TO if_ixml,
       go_document       TYPE REF TO if_ixml_document,
       go_element        TYPE REF TO if_ixml_element,
       go_parent_element TYPE REF TO if_ixml_element,
       go_descr_element  TYPE REF TO if_ixml_element,
       gv_value          TYPE string,
       gv_xstring        TYPE xstring,
       gv_string         TYPE string,
       gt_makt           TYPE TABLE OF makt,
       gs_makt           TYPE makt,
       gv_date           TYPE c LENGTH 10,
       gv_filename       TYPE string,
       gv_path           TYPE string,
       gv_fullpath       TYPE string,
       gv_user_action    TYPE i,
       gt_file_data      TYPE TABLE OF char100.


PARAMETERS : pa_matnr TYPE matnr OBLIGATORY,
             pa_disp RADIOBUTTON GROUP gr1 DEFAULT 'X',
             pa_file RADIOBUTTON GROUP gr1.


START-OF-SELECTION.

SELECT * FROM makt INTO TABLE  gt_makt WHERE matnr = pa_matnr AND spras = 'TR'.

go_xml_factory = cl_ixml=>create( ).
go_document = go_xml_factory->create_document( ).
go_element = go_document->create_element( name = 'MATERIAL' ).
go_document->append_child( go_element ).
go_parent_element = go_element.
go_element = go_document->create_element( name = 'MATERIAL_NO' ).
gv_value = gs_mara-matnr.
go_element->set_value( value = gv_value ).
go_parent_element->append_child( go_element ).
go_element = go_document->create_element( name = 'CREATER' ).
gv_value = gs_mara-ernam.
go_element->set_value( value = gv_value ).
go_parent_element->append_child( go_element ).
go_element = go_document->create_element( name = 'CREATION_DATE' ).
WRITE gs_mara-ersda TO gv_date DD/MM/YYYY.
MOVE gv_date TO  gv_value.
go_element->set_value( value = gv_value ).
go_parent_element->append_child( go_element ).
go_element = go_document->create_element( name = 'DESCRIPTIONS' ).
go_descr_element = go_element.

READ TABLE gt_makt INTO gs_makt WITH KEY spras = 'TR' .
IF sy-subrc IS INITIAL.
  go_element = go_document->create_element( name = 'DESCR_TR' ).
  gv_value = gs_makt-maktx.
  go_element->set_value( value = gv_value ).
  go_descr_element->append_child( new_child = go_element ).
ENDIF.

go_parent_element->append_child( go_descr_element ).

IF pa_file EQ 'X'.
  CALL FUNCTION 'SDIXML_DOM_TO_XML'
    EXPORTING
      document    = go_document
    IMPORTING
      xml_as_string = gv_xstring.


  CALL FUNCTION 'ECATT_CONV_XSTRING_TO_STRING'
    EXPORTING
      im_xstring = gv_xstring
      im_encoding = 'UTF-8'
    IMPORTING
      ex_string = gv_string.


  CALL FUNCTION 'CONVERT_STRING_TO_TABLE'
    EXPORTING
      i_string = gv_string
      i_tabline_length = 100
    TABLES
      et_table = gt_file_data.

  CALL METHOD cl_gui_frontend_services=>file_save_dialog
    EXPORTING
      window_title   = 'XML DOSYASINI KAYDET'
      default_extension = 'XML'
      default_file_name = 'denemexml'
      initial_directory = 'C:\TEMP'
      prompt_on_overwrite = 'X'
    CHANGING
      filename = gv_filename
      path = gv_path
      fullpath = gv_fullpath
      user_action = gv_user_action.

  IF gv_user_action = cl_gui_frontend_services=>action_ok.
    CALL METHOD cl_gui_frontend_services=>gui_download
      EXPORTING
        filename = gv_filename
        filetype = 'ASC'
      CHANGING
        data_tab = gt_file_data.
  ELSE.
    MESSAGE 'DOSYA KAYDEDİLMEYECEK' TYPE 'I'.
    RETURN.
  ENDIF.
ELSEIF pa_disp = 'X'.
  CALL FUNCTION 'SDIXML_DOM_TO_SCREEN'
    EXPORTING
      document = go_document.
ENDIF.
