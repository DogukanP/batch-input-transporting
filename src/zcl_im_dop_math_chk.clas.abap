class ZCL_IM_DOP_MATH_CHK definition
  public
  final
  create public .

public section.

  interfaces IF_EX_BADI_MATERIAL_CHECK .
protected section.
private section.
ENDCLASS.



CLASS ZCL_IM_DOP_MATH_CHK IMPLEMENTATION.


  method IF_EX_BADI_MATERIAL_CHECK~CHECK_CHANGE_MARA_MEINS.
  endmethod.


  method IF_EX_BADI_MATERIAL_CHECK~CHECK_CHANGE_PMATA.
  endmethod.


  method IF_EX_BADI_MATERIAL_CHECK~CHECK_DATA.
    IF wmara-meins = 'KG'.
      MESSAGE 'BİRİM OLARAK KG GİRMEYİNİZ' TYPE 'I'.
    ENDIF.
  endmethod.


  method IF_EX_BADI_MATERIAL_CHECK~CHECK_DATA_RETAIL.
  endmethod.


  method IF_EX_BADI_MATERIAL_CHECK~CHECK_MASS_MARC_DATA.
  endmethod.


  method IF_EX_BADI_MATERIAL_CHECK~FRE_SUPPRESS_MARC_CHECK.
  endmethod.
ENDCLASS.
