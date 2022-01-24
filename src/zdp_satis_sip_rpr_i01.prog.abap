*&---------------------------------------------------------------------*
*&  Include           ZDP_SATIS_SIP_RPR_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CLEAR ok_code.
  ok_code = sy-ucomm.
  CASE ok_code.
    WHEN 'BACK' OR 'CANCEL'.
      CALL FUNCTION 'POPUP_TO_CONFIRM'
        EXPORTING
          titlebar       = 'ONAY'
          text_question  = 'ÇIKMAK İSTEDİĞİNE EMİN MİSİN ?'
          text_button_1  = 'EVET'
          text_button_2  = 'HAYIR'
          default_button = '2'
          display_cancel_button = ' '
        IMPORTING
          answer         = gv_popup_return
        EXCEPTIONS
          text_not_found = 1
          OTHERS         = 2.

    CASE gv_popup_return.
      WHEN '1'.
        LEAVE TO SCREEN 0.
      WHEN '2'.
      WHEN OTHERS.
        LEAVE TO SCREEN 0.
    ENDCASE.



    WHEN 'EXIT' .
      CALL FUNCTION 'POPUP_TO_CONFIRM'
        EXPORTING
          titlebar       = 'ONAY'
          text_question  = 'ÇIKMAK İSTEDİĞİNE EMİN MİSİN ?'
          text_button_1  = 'EVET'
          text_button_2  = 'HAYIR'
          default_button = '2'
          display_cancel_button = ' '
        IMPORTING
          answer         = gv_popup_return
        EXCEPTIONS
          text_not_found = 1
          OTHERS         = 2.

    CASE gv_popup_return.
      WHEN '1'.
        LEAVE TO SCREEN 0.
      WHEN '2'.
      WHEN OTHERS.
        LEAVE TO SCREEN 0.
    ENDCASE.
  ENDCASE.
ENDMODULE.
