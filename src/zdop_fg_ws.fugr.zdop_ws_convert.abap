FUNCTION zdop_ws_convert.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(I_MATNR) TYPE  MATNR
*"     VALUE(I_DATE) TYPE  DATUM
*"     VALUE(I_NUM1) TYPE  WRBTR
*"  EXPORTING
*"     VALUE(E_MALZEME) TYPE  MAKTX
*"     VALUE(E_MSG) TYPE  TEXT100
*"     VALUE(E_DATE) TYPE  TEXT100
*"     VALUE(E_NUM1) TYPE  TEXT100
*"----------------------------------------------------------------------
 CONSTANTS:
  lc_langu TYPE sylangu VALUE 'TR'.

  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_OUTPUT'
    EXPORTING
      input  = i_matnr
    IMPORTING
      output = i_matnr.

  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
    EXPORTING
      input  = i_matnr
    IMPORTING
      output = i_matnr.


  IF i_matnr IS NOT INITIAL.

    SELECT SINGLE maktx FROM makt
      INTO e_malzeme
      WHERE matnr EQ i_matnr
        AND spras EQ lc_langu.
    IF sy-subrc NE 0.
      e_msg = 'MALZEME ADI BULUNAMADI'.
    ENDIF.
  ENDIF.

  IF i_date IS NOT INITIAL.

    WRITE i_date TO e_date.

    CONCATENATE 'Girdiğiniz tarih : ' e_date
       INTO e_date.

  ENDIF.

  IF i_num1 IS NOT INITIAL.

    DATA:
    ls_spell TYPE spell.

    CALL FUNCTION 'SPELL_AMOUNT'
      EXPORTING
        amount    = i_num1
        currency  = 'TRY'
        language  = sy-langu
      IMPORTING
        in_words  = ls_spell
      EXCEPTIONS
        not_found = 1
        too_large = 2
        OTHERS    = 3.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

    CONCATENATE
    ls_spell-word 'TL'
    ls_spell-decword 'Kuruş'
    INTO e_num1 SEPARATED BY space.

  ENDIF.




ENDFUNCTION.
