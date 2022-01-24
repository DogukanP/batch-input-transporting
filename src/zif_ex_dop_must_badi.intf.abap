interface ZIF_EX_DOP_MUST_BADI
  public .


  methods KDV_HESAPLA default ignore
    importing
      !IS_VBAK type VBAK
      !IT_VBAP type VBAP_T
      !FLT_VAL type LAND1
    exporting
      !EV_KDV type P .
endinterface.
