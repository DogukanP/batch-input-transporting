class ZCL_IM_DOP_SATIS_IMP definition
  public
  final
  create public .

public section.

  interfaces ZIF_EX_DOP_SATIS_BADI .
protected section.
private section.
ENDCLASS.



CLASS ZCL_IM_DOP_SATIS_IMP IMPLEMENTATION.


  method ZIF_EX_DOP_SATIS_BADI~SATIS_DOKUMANI_FILTRELE.
    data ls_vbap type vbap.
    LOOP AT ct_vbap into ls_vbap.
      IF ls_vbap-matnr = 'M-02'.
        delete ct_vbap.
      ENDIF.
    ENDLOOP.
  endmethod.
ENDCLASS.
