class ZCL_IM_DOP_LIKP_EKRAN definition
  public
  final
  create public .

public section.

  interfaces IF_EX_LE_SHP_TAB_CUST_HEAD .
protected section.
private section.
ENDCLASS.



CLASS ZCL_IM_DOP_LIKP_EKRAN IMPLEMENTATION.


  METHOD if_ex_le_shp_tab_cust_head~activate_tab_page.
    ef_caption     = 'xdogukanp'.
    ef_program     = 'ZDOP_LIFP_EHM'.
    ef_dynpro      = '0100'.
    cs_v50agl_cust = 'X'.
*    ef_position    = 2.
  ENDMETHOD.


  method IF_EX_LE_SHP_TAB_CUST_HEAD~PASS_FCODE_TO_SUBSCREEN.
  endmethod.


  method IF_EX_LE_SHP_TAB_CUST_HEAD~TRANSFER_DATA_FROM_SUBSCREEN.
  endmethod.


  method IF_EX_LE_SHP_TAB_CUST_HEAD~TRANSFER_DATA_TO_SUBSCREEN.
    CALL FUNCTION 'ZDOP_YENI_ALAN_DEGER_ATA'
      EXPORTING
        is_likp       = is_likp
              .

  endmethod.
ENDCLASS.
