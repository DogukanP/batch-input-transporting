FUNCTION zdop_bapi_material_data.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(MATERIAL) TYPE  ZDOP_BAPI_S_MATERIAL
*"  EXPORTING
*"     VALUE(MATERIAL_DETAIL) TYPE  ZDOP_BAPI_EXP_MATERIAL
*"     VALUE(RETURN) TYPE  BAPIRET2
*"----------------------------------------------------------------------

  SELECT SINGLE matnr
                mtart
                meins
                matkl
                mbrsh
    FROM mara INTO material_detail
    WHERE matnr = material.


  IF SY-SUBRC NE 0 .
    RETURN-TYPE = 'E'.
    RETURN-MESSAGE = 'MALZEME BULUNAMADI'.
  ENDIF.




ENDFUNCTION.
