*&---------------------------------------------------------------------*
*& Include          ZDOP_SCREEN_TOP
*&---------------------------------------------------------------------*
DATA : gv_firstsal   TYPE p LENGTH 5 DECIMALS 2,
       gv_age        TYPE i,
       gv_get        TYPE c,
       gv_update     TYPE c,
       gp_screennum  TYPE i.

DATA : BEGIN OF gs_input,
         sirket_kodu   TYPE zdop_t_logkullan-sirket_kodu,
         kullanici_id  TYPE zdop_t_logkullan-kullanici_id,
         adi           TYPE zdop_t_logkullan-adi,
         soyadi        TYPE zdop_t_logkullan-soyadi,
         dogum_tarihi  TYPE zdop_t_logkullan-dogum_tarihi,
         maas          TYPE zdop_t_logkullan-maas,
       END OF gs_input.

DATA : gs_logkullanici   LIKE zdop_t_logkullan,
       gt_logkullanici   LIKE TABLE OF zdop_t_logkullan,
       gs_logsirket      LIKE zdop_t_logsirket,
       gt_logsirket      LIKE TABLE OF zdop_t_logsirket,
       gs_kullanicibakim LIKE zdop_t_kullanicb,
       gt_kullanicibakim LIKE TABLE OF zdop_t_kullanicb,
       gs_sirketbakim    LIKE zdop_t_sirketkb,
       gt_sirketbakim    LIKE TABLE OF zdop_t_sirketkb.

DATA : ok_code100 TYPE sy-ucomm,
       ok_code200 TYPE sy-ucomm,
       ok_code300 TYPE sy-ucomm,
       ok_code400 TYPE sy-ucomm,
       ok_code500 TYPE sy-ucomm.
