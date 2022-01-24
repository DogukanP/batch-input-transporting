class ZCL_IM_DOP_FILTER_DE definition
  public
  final
  create public .

public section.

  interfaces ZIF_EX_DOP_FILTER_BADI .
protected section.
private section.
ENDCLASS.



CLASS ZCL_IM_DOP_FILTER_DE IMPLEMENTATION.


  method ZIF_EX_DOP_FILTER_BADI~KDV_HESAPLA.
    DATA : LS_VBAP TYPE VBAP,
           LV_TOPLAM TYPE P.

    CHECK FLT_VAL = 'DE'.

    LOOP AT IT_VBAP INTO LS_VBAP.
      ADD LS_VBAP-NETWR TO LV_TOPLAM.
    ENDLOOP.

    EV_KDV = LV_TOPLAM * '0.15'.
  endmethod.
ENDCLASS.
