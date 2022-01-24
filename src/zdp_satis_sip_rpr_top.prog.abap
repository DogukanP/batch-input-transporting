*&---------------------------------------------------------------------*
*&  Include           ZDP_SATIS_SIP_RPR_TOP
*&---------------------------------------------------------------------*

TABLES : vbak,vbap,makt."adrp,usr21,mara .

TYPE-POOLS : slis,icon.

DATA : gt_outm TYPE TABLE OF zdop_s_ssr,
       gs_outm TYPE zdop_s_ssr .


DATA: ok_code  TYPE sy-ucomm.

DATA:
go_container        TYPE scrfname VALUE 'GO_CONTAINER',
go_grid             TYPE REF TO cl_gui_alv_grid,
go_custom_container TYPE REF TO cl_gui_custom_container,
gs_layout           TYPE lvc_s_layo ,
gt_fcat             TYPE lvc_t_fcat,
gs_fcat             TYPE lvc_s_fcat,
gt_exclude          TYPE ui_functions,
gs_exclude          TYPE ui_func,
gs_variant          TYPE disvariant.


DATA:gr_send_request TYPE REF TO cl_bcs,
     gr_sender_mail  TYPE REF TO cl_cam_address_bcs,
     gr_recipient    TYPE REF TO if_recipient_bcs,
     gr_document     TYPE REF TO cl_document_bcs,
     gv_sent_to_all  TYPE os_boolean.
DATA:gv_mail     TYPE adr6-smtp_addr.
DATA:gt_text  TYPE truxs_t_text_data.

DATA : gv_popup_return TYPE c,
       gv_text_que TYPE string.






SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001 .
SELECT-OPTIONS : so_blgno FOR vbak-vbeln,
                 so_yrtn  FOR vbak-ernam NO INTERVALS NO-EXTENSION,
                 so_mlzm  FOR vbap-matnr NO INTERVALS NO-EXTENSION.
SELECTION-SCREEN END OF  BLOCK b1 .
