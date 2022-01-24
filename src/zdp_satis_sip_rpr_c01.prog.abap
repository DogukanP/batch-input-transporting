*&---------------------------------------------------------------------*
*&  Include           ZDP_SATIS_SIP_RPR_C01
*&---------------------------------------------------------------------*
*CLASS lcl_event_receiver DEFINITION DEFERRED.
*----------------------------------------------------------------------*
CLASS lcl_event_receiver DEFINITION DEFERRED.
*----------------------------------------------------------------------*
*       CLASS lcl_event_receiver DEFINITION
*----------------------------------------------------------------------*
CLASS lcl_event_receiver DEFINITION.
  PUBLIC SECTION.
    METHODS:
      handle_toolbar FOR EVENT toolbar OF cl_gui_alv_grid
        IMPORTING e_object e_interactive,
      handle_user_command FOR EVENT user_command OF cl_gui_alv_grid
        IMPORTING e_ucomm.
ENDCLASS.
*----------------------------------------------------------------------*
*       CLASS lcl_event_receiver IMPLEMENTATION
*----------------------------------------------------------------------*
CLASS lcl_event_receiver IMPLEMENTATION.
  METHOD handle_toolbar.

    DATA: ls_toolbar TYPE stb_button.

    CLEAR ls_toolbar.
    ls_toolbar-butn_type = 3.
    APPEND ls_toolbar TO e_object->mt_toolbar.

    CLEAR ls_toolbar.
    ls_toolbar-function  = 'YAZDIR'.
    ls_toolbar-butn_type = 0.
    ls_toolbar-text      = 'YAZDIR'.
    ls_toolbar-quickinfo = 'YAZDIR'.
    APPEND ls_toolbar TO e_object->mt_toolbar.

    CLEAR ls_toolbar.
    ls_toolbar-function  = 'PDF_INDIR'.
    ls_toolbar-butn_type = 0.
    ls_toolbar-text      = 'PDF_İNDİR'.
    ls_toolbar-quickinfo = 'PDF_İNDİR'.
    APPEND ls_toolbar TO e_object->mt_toolbar.

    CLEAR ls_toolbar.
    ls_toolbar-function  = 'PDF_MAIL'.
    ls_toolbar-butn_type = 0.
    ls_toolbar-text      = 'PDF_MAİL'.
    ls_toolbar-quickinfo = 'PDF_MAIL'.
    APPEND ls_toolbar TO e_object->mt_toolbar.

    CLEAR ls_toolbar.
    ls_toolbar-function  = 'EXCEL_MAIL'.
    ls_toolbar-butn_type = 0.
    ls_toolbar-text      = 'EXCEL_MAIL'.
    ls_toolbar-quickinfo = 'EXCEL_MAIL'.
    APPEND ls_toolbar TO e_object->mt_toolbar.

    CLEAR ls_toolbar.
    ls_toolbar-function  = 'ADOBE_FORM'.
    ls_toolbar-butn_type = 0.
    ls_toolbar-text      = 'ADOBE_FORM'.
    ls_toolbar-quickinfo = 'ADOBE_FORM'.
    APPEND ls_toolbar TO e_object->mt_toolbar.


  ENDMETHOD.
  METHOD handle_user_command.
    CASE e_ucomm.
      WHEN 'YAZDIR'.
        PERFORM yazdir.
      WHEN 'PDF_INDIR'.
        PERFORM pdf_indir.
      WHEN 'PDF_MAIL'.
        PERFORM pdf_mail.
      WHEN 'EXCEL_MAIL'.
        PERFORM excel_mail.
      WHEN 'ADOBE_FORM'.
        PERFORM adobe_form.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.
