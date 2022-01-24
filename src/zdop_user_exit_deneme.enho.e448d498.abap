"Name: \PR:SAPMV45A\FO:USEREXIT_SAVE_DOCUMENT_PREPARE\SE:END\EI
ENHANCEMENT 0 ZDOP_USER_EXIT_DENEME.
*
  data: lv_exit type c LENGTH 1,
        ls_xvbap like LINE OF xvbap.

  "kaydetme işleminde değilse subrutinden çık.

  IF sy-ucomm ne 'SICH'.
    LEAVE TO SCREEN sy-dynnr.
  ENDIF.

  clear lv_exit.
  LOOP AT xvbap INTO ls_xvbap WHERE updkz ne 'D'.
    "satış miktarı değeri 10 dan büyükse mesaj göster.
    IF xvbap-kbmeng gt 10.
      MESSAGE 'MİKTAR 10 DAN KÜÇÜK OLMALIDIR.' TYPE 'I'.
      LV_EXIT = 'X'.
    ENDIF.
  ENDLOOP.

  IF LV_EXIT = 'X'.
    LEAVE TO SCREEN SY-DYNNR.
  ENDIF.
ENDENHANCEMENT.
