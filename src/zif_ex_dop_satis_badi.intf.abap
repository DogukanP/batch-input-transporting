interface ZIF_EX_DOP_SATIS_BADI
  public .


  methods SATIS_DOKUMANI_FILTRELE default ignore
    changing
      !CS_VBAK type VBAK
      !CT_VBAP type VBAP_T .
endinterface.
