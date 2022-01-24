class ZDOP_CL_ME2N_CIKTI definition
  public
  final
  create public .

*"* public components of class ZDOP_CL_ME2N_CIKTI
*"* do not include other source files here!!!
public section.

  interfaces IF_BADI_INTERFACE .
  interfaces IF_EX_ME_CHANGE_OUTTAB_CUS .
protected section.
*"* protected components of class ZDOP_CL_ME2N_CIKTI
*"* do not include other source files here!!!
private section.
*"* private components of class ZDOP_CL_ME2N_CIKTI
*"* do not include other source files here!!!
ENDCLASS.



CLASS ZDOP_CL_ME2N_CIKTI IMPLEMENTATION.


METHOD IF_EX_ME_CHANGE_OUTTAB_CUS~FILL_OUTTAB.

* When processing this source code, you activate the following functionality:
* The reporting transactions for purchasing documents provide three main views
* for display: basic list, delivery schedule, and account assignment. All
* three views contain a column "Material". If the material of a purchasing
* document item is a manufacturer part number (MPN) then this MPN is shown
* as "Material". The internal inventory managed material is not visible.
* The following source code replaces the MPN by the inventory managed material.

  DATA: ls_ekpo TYPE ekpo.

  FIELD-SYMBOLS: <fs_outtab>   TYPE ANY,
                 <fs_ebeln>    TYPE ebeln,
                 <fs_ebelp>    TYPE ebelp,
                 <fs_material> TYPE matnr,
                 <fs_baslik> TYPE zdop_baslik.

* check that a purchasing document view is displayed
  CHECK im_struct_name EQ 'MEREP_OUTTAB_PURCHDOC'   OR    "view: basic list
        im_struct_name EQ 'MEREP_OUTTAB_SCHEDLINES' OR    "view: delivery schedule
        im_struct_name EQ 'MEREP_OUTTAB_ACCOUNTING'.      "view: account assignment

* loop at the output table and assign a field symbol
  LOOP AT ch_outtab ASSIGNING <fs_outtab>.

    ASSIGN COMPONENT 'ZDOP_BASLIK' OF STRUCTURE <fs_outtab> TO <fs_baslik>.
     IF sy-subrc EQ 0.
       <fs_baslik> = 'DOĞUKAN PADEL'.
     ENDIF.

*-- assign the purchasing document number to a field symbol
    ASSIGN COMPONENT 'EBELN' OF STRUCTURE <fs_outtab> TO <fs_ebeln>.
    CHECK sy-subrc = 0.
*-- assign the purchasing document item number to a field symbol
    ASSIGN COMPONENT 'EBELP' OF STRUCTURE <fs_outtab> TO <fs_ebelp>.
    CHECK sy-subrc = 0.
*-- assign the manufacturer part number to a field symbol
    ASSIGN COMPONENT 'EMATN' OF STRUCTURE <fs_outtab> TO <fs_material>.
    CHECK sy-subrc = 0.

*-- read the corresponding purchasing document item
    CALL FUNCTION 'ME_EKPO_SINGLE_READ'
      EXPORTING
        pi_ebeln         = <fs_ebeln>
        pi_ebelp         = <fs_ebelp>
      IMPORTING
        po_ekpo          = ls_ekpo
      EXCEPTIONS
        no_records_found = 1
        OTHERS           = 2.
    CHECK sy-subrc = 0.

*-- assign the inventory managed material to the field "Material" in the output table
    <fs_material> = ls_ekpo-matnr.

  ENDLOOP.

ENDMETHOD.
ENDCLASS.
