*****           Implementation of object type ZDOP_BAPI            *****
INCLUDE <OBJECT>.
BEGIN_DATA OBJECT. " Do not change.. DATA is generated
* only private members may be inserted into structure private
DATA:
" begin of private,
"   to declare private attributes remove comments and
"   insert private attributes here ...
" end of private,
      KEY LIKE SWOTOBJID-OBJKEY.
END_DATA OBJECT. " Do not change.. DATA is generated

BEGIN_METHOD ZDOPMATERIALDATA CHANGING CONTAINER.
DATA:
      MATERIAL LIKE ZDOP_BAPI_S_MATERIAL,
      MATERIALDETAIL LIKE ZDOP_BAPI_EXP_MATERIAL,
      RETURN LIKE BAPIRET2.
  SWC_GET_ELEMENT CONTAINER 'Material' MATERIAL.
  CALL FUNCTION 'ZDOP_BAPI_MATERIAL_DATA'
    EXPORTING
      MATERIAL = MATERIAL
    IMPORTING
      MATERIAL_DETAIL = MATERIALDETAIL
      RETURN = RETURN
    EXCEPTIONS
      OTHERS = 01.
  CASE SY-SUBRC.
    WHEN 0.            " OK
    WHEN OTHERS.       " to be implemented
  ENDCASE.
  SWC_SET_ELEMENT CONTAINER 'MaterialDetail' MATERIALDETAIL.
  SWC_SET_ELEMENT CONTAINER 'Return' RETURN.
END_METHOD.
