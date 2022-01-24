*&---------------------------------------------------------------------*
*& Include          ZDOP_SCREEN_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form INPUT100
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM input100 . "main screen
  CLEAR ok_code100.
  ok_code100 = sy-ucomm.
  CLEAR sy-ucomm.

  CASE ok_code100.
    WHEN 'BACK' OR 'CANCEL'.
      LEAVE TO SCREEN 0.
    WHEN 'EXIT' .
      LEAVE PROGRAM .
    WHEN 'BUTTON1'. " add record screen
      CLEAR gs_input .
      PERFORM buton1.
    WHEN 'BUTTON2'. " delete record screen
      CLEAR gs_input .
      PERFORM buton2.
    WHEN 'BUTTON3'. " update record screen
      CLEAR gs_input .
      PERFORM buton3.
    WHEN 'BUTTON4' . " report screen
      CLEAR gs_input .
      PERFORM buton4.
  ENDCASE.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form BUTON1
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM buton1 .
 SELECT * FROM zdop_t_kullanicb INTO TABLE gt_kullanicibakim WHERE kullanici_id = sy-uname.
  IF sy-subrc = 0.
    SELECT * FROM zdop_t_sirketkb INTO TABLE gt_sirketbakim .
    IF sy-subrc = 0 .
      CALL SCREEN 200 .
    ELSE.
      MESSAGE 'ŞİRKET TABLOSU BOŞ' TYPE 'S' DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE 'KULLANICI, BAKIM TABLOSUNDA YOK' TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form BUTON2
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM buton2 .
 gp_screennum = 300.
 PERFORM userkontrol USING gp_screennum.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form BUTON3
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM buton3 .
 gp_screennum = 400.
 PERFORM userkontrol USING gp_screennum.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form BUTON4
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM buton4 .
 CALL SCREEN 500.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form userkontrol
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GV_SCREENNUM
*&---------------------------------------------------------------------*
FORM userkontrol  USING    gp_screennum.
  SELECT * FROM zdop_t_kullanicb INTO TABLE gt_kullanicibakim WHERE kullanici_ID = sy-uname AND aktiflik = 'X'.

  IF sy-subrc = 0.
    SELECT * FROM zdop_t_kullanicb INTO TABLE gt_kullanicibakim WHERE aktiflik = 'X'.
      IF sy-subrc <> 0.
        MESSAGE 'KULLANICI , AKTİF DEĞİL' TYPE 'S' DISPLAY LIKE 'E'.
      ELSE.
        CALL SCREEN gp_screennum.
      ENDIF.
  ELSE.
    MESSAGE 'KULLANICI, BAKIM TABLOSUNDA YOK VEYA PASİF' TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form INPUT200
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM input200 .
   CLEAR ok_code200.
   ok_code200 = sy-ucomm.
   CLEAR sy-ucomm.

   CASE ok_code200.
    WHEN 'BACK' OR 'CANCEL'.
      LEAVE TO SCREEN 0.
    WHEN 'EXIT' .
      LEAVE PROGRAM .
    WHEN 'BUTTON5' .
      PERFORM record_control.
   ENDCASE.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form INPUT300
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM input300 .
  CLEAR ok_code300.
   ok_code300 = sy-ucomm.
   CLEAR sy-ucomm.

   CASE ok_code300.
    WHEN 'BACK' OR 'CANCEL'.
      LEAVE TO SCREEN 0.
    WHEN 'EXIT' .
      LEAVE PROGRAM .
    WHEN 'BUTTON6' .
      CLEAR gs_input .
      MESSAGE 'YENİLENDİ' TYPE 'S' .
    WHEN 'BUTTON7' .

      IF gs_input-sirket_kodu  IS NOT INITIAL AND
         gs_input-kullanici_id IS NOT INITIAL AND
         gs_input-adi          IS NOT INITIAL .
        SELECT * FROM zdop_t_sirketkb INTO TABLE gt_sirketbakim WHERE sirket_kodu = gs_input-sirket_kodu.
          IF sy-subrc = 0.
            SELECT * FROM zdop_t_sirketkb INTO TABLE gt_sirketbakim WHERE sirket_kodu = gs_input-sirket_kodu AND aktiflik = 'X'.
              IF sy-subrc = 0.
                SELECT * FROM zdop_t_kullanicb INTO TABLE gt_kullanicibakim WHERE kullanici_id = gs_input-kullanici_id.
                  IF sy-subrc = 0.
                    SELECT * FROM zdop_t_kullanicb INTO TABLE gt_kullanicibakim WHERE kullanici_id = gs_input-kullanici_id AND aktiflik = 'X'.
                      IF sy-subrc = 0.
                        SELECT SINGLE * FROM  zdop_t_logkullan INTO gs_logkullanici
                        WHERE sirket_kodu  = gs_input-sirket_kodu
                          AND kullanici_id = gs_input-kullanici_id
                          AND adi          = gs_input-adi .
                         IF sy-subrc = 0 .
                           MOVE-CORRESPONDING gs_logkullanici TO gs_input .
                         ELSE .
                           MESSAGE 'KAYIT YOK' TYPE 'S' DISPLAY LIKE 'E' .
                         ENDIF .
                      ELSE.
                        MESSAGE 'KULLANICI AKTİF DEĞİL' TYPE 'S' DISPLAY LIKE 'E'.
                      ENDIF.
                  ELSE.
                    MESSAGE 'KULLANICI BAKIM TABLOSUNDA YOK' TYPE 'S' DISPLAY LIKE 'E'.
                  ENDIF.
              ELSE.
                MESSAGE 'ŞİRKET KODU AKTİF DEĞİL.' TYPE 'S' DISPLAY LIKE 'E'.
              ENDIF.
          ELSE.
            MESSAGE 'ŞİRKET KODU BAKIM TABLOSUNDA YOK.' TYPE 'S' DISPLAY LIKE 'E'.
          ENDIF.
      ELSE .
        MESSAGE 'TÜM ZORUNLU ALANLARI DOLDURUN' TYPE 'S' DISPLAY LIKE 'E' .
      ENDIF.

    WHEN 'BUTTON8' .
      IF gs_input-sirket_kodu  IS NOT INITIAL AND
         gs_input-kullanici_id IS NOT INITIAL AND
         gs_input-adi          IS NOT INITIAL .
        SELECT * FROM zdop_t_sirketkb INTO TABLE gt_sirketbakim WHERE sirket_kodu = gs_input-sirket_kodu.
          IF sy-subrc = 0.
            SELECT * FROM zdop_t_sirketkb INTO TABLE gt_sirketbakim WHERE sirket_kodu = gs_input-sirket_kodu AND aktiflik = 'X'.
              IF sy-subrc = 0.
                SELECT * FROM zdop_t_kullanicb INTO TABLE gt_kullanicibakim WHERE kullanici_id = gs_input-kullanici_id.
                  IF sy-subrc = 0.
                    SELECT * FROM zdop_t_kullanicb INTO TABLE gt_kullanicibakim WHERE kullanici_id = gs_input-kullanici_id AND aktiflik = 'X'.
                      IF sy-subrc = 0.
                         PERFORM delete_record.
                      ELSE.
                        MESSAGE 'KULLANICI AKTİF DEĞİL' TYPE 'S' DISPLAY LIKE 'E'.
                      ENDIF.
                  ELSE.
                    MESSAGE 'KULLANICI BAKIM TABLOSUNDA YOK' TYPE 'S' DISPLAY LIKE 'E'.
                  ENDIF.
              ELSE.
                MESSAGE 'ŞİRKET KODU AKTİF DEĞİL.' TYPE 'S' DISPLAY LIKE 'E'.
              ENDIF.
          ELSE.
            MESSAGE 'ŞİRKET KODU BAKIM TABLOSUNDA YOK.' TYPE 'S' DISPLAY LIKE 'E'.
          ENDIF.
      ELSE.
        MESSAGE 'TÜM ZORUNLU ALANLARI DOLDURUN' TYPE 'S' DISPLAY LIKE 'E'.
      ENDIF.
   ENDCASE.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form INPUT400
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM input400 .
  CLEAR ok_code400.
   ok_code400 = sy-ucomm.
   CLEAR sy-ucomm.

   CASE ok_code400.
    WHEN 'BACK' OR 'CANCEL'.
      LEAVE TO SCREEN 0.
    WHEN 'EXIT' .
      LEAVE PROGRAM .
    WHEN 'BUTTON9' .
      CLEAR gs_input .
      MESSAGE 'YENİLENDİ' TYPE 'S' .
    WHEN 'BUTTON10' .
      IF gs_input-sirket_kodu  IS NOT INITIAL AND
         gs_input-kullanici_id IS NOT INITIAL .
        SELECT * FROM zdop_t_sirketkb INTO TABLE gt_sirketbakim WHERE sirket_kodu = gs_input-sirket_kodu.
          IF sy-subrc = 0.
            SELECT * FROM zdop_t_sirketkb INTO TABLE gt_sirketbakim WHERE sirket_kodu = gs_input-sirket_kodu AND aktiflik = 'X'.
              IF sy-subrc = 0.
                SELECT * FROM zdop_t_kullanicb INTO TABLE gt_kullanicibakim WHERE kullanici_id = gs_input-kullanici_id.
                  IF sy-subrc = 0.
                    SELECT * FROM zdop_t_kullanicb INTO TABLE gt_kullanicibakim WHERE kullanici_id = gs_input-kullanici_id AND aktiflik = 'X'.
                      IF sy-subrc = 0.
                        SELECT SINGLE * FROM  zdop_t_logkullan INTO gs_logkullanici
                        WHERE sirket_kodu  = gs_input-sirket_kodu
                          AND kullanici_id = gs_input-kullanici_id.
                         IF sy-subrc = 0 .
                           MOVE-CORRESPONDING gs_logkullanici TO gs_input .
                         ELSE .
                           MESSAGE 'KAYIT YOK' TYPE 'S' DISPLAY LIKE 'E' .
                         ENDIF .
                      ELSE.
                        MESSAGE 'KULLANICI AKTİF DEĞİL' TYPE 'S' DISPLAY LIKE 'E'.
                      ENDIF.
                  ELSE.
                    MESSAGE 'KULLANICI BAKIM TABLOSUNDA YOK' TYPE 'S' DISPLAY LIKE 'E'.
                  ENDIF.
              ELSE.
                MESSAGE 'ŞİRKET KODU AKTİF DEĞİL.' TYPE 'S' DISPLAY LIKE 'E'.
              ENDIF.
          ELSE.
            MESSAGE 'ŞİRKET KODU BAKIM TABLOSUNDA YOK.' TYPE 'S' DISPLAY LIKE 'E'.
          ENDIF.
      ELSE .
        MESSAGE 'TÜM ZORUNLU ALANLARI DOLDURUN' TYPE 'S' DISPLAY LIKE 'E' .
      ENDIF.
    WHEN 'BUTTON11' .
      IF gs_logkullanici-sirket_kodu  IS NOT INITIAL AND
         gs_logkullanici-kullanici_id IS NOT INITIAL .

        IF gs_logkullanici-sirket_kodu  = gs_input-sirket_kodu AND
           gs_logkullanici-kullanici_id = gs_input-kullanici_id AND
           gs_logkullanici-adi          = gs_input-adi AND
           gs_logkullanici-soyadi       = gs_input-soyadi AND
           gs_logkullanici-dogum_tarihi = gs_input-dogum_tarihi AND
           gs_logkullanici-maas         = gs_input-maas .

          MESSAGE 'GÜNCELLEMEK İSTEDİĞİNİZ BİLGİYİ DEĞİŞTİRİN' TYPE 'S' DISPLAY LIKE 'E'  .
        ELSE.
          PERFORM update_record.
        ENDIF.
      ELSE.
        MESSAGE 'TÜM ZORUNLU ALANLARI GİRİNİZ' TYPE 'S' DISPLAY LIKE 'E'  .
      ENDIF.
    WHEN 'BUTTON12' .
      gs_input-maas = gs_input-maas + 50 .
      MESSAGE 'MAAŞ 50 TL ARTTIRILDI' TYPE 'S' .
    WHEN 'BUTTON13' .
      IF gs_input-maas =< 50 .
        MESSAGE 'MAAŞ 50 TL DEN AZ' TYPE 'S' .
      ELSE .
        gs_input-maas = gs_input-maas - 50 .
        MESSAGE 'MAAŞ 50 TL EKSİLTİLDİ' TYPE 'S' .
      ENDIF.
   ENDCASE.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form INPUT500
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM input500 .
  CLEAR ok_code500.
   ok_code500 = sy-ucomm.
   CLEAR sy-ucomm.

   CASE ok_code500.
    WHEN 'BACK' OR 'CANCEL'.
      LEAVE TO SCREEN 0.
    WHEN 'EXIT' .
      LEAVE PROGRAM .
    WHEN 'BUTTON14' .
      CLEAR gs_input .
      MESSAGE 'YENİLENDİ' TYPE 'S' .
    WHEN 'BUTTON15'.
      IF gs_input-sirket_kodu  IS NOT INITIAL .

        SELECT * FROM zdop_t_logkullan INTO TABLE gt_logkullanici
                 where sirket_kodu = gs_input-sirket_kodu .
        cl_demo_output=>display_data( gt_logkullanici ).
      ELSE .
        MESSAGE 'TÜM ZORUNLU ALANLARI DOLDURUN' TYPE 'W' .
      ENDIF.
   ENDCASE.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form record_control
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM record_control .
  IF gs_input-sirket_kodu  IS NOT INITIAL AND
     gs_input-kullanici_id IS NOT INITIAL AND
     gs_input-adi          IS NOT INITIAL AND
     gs_input-maas         IS NOT INITIAL.

    SELECT * FROM zdop_t_sirketkb INTO TABLE gt_sirketbakim WHERE sirket_kodu = gs_input-sirket_kodu.
    IF sy-subrc = 0.
      SELECT * FROM zdop_t_sirketkb INTO TABLE gt_sirketbakim WHERE sirket_kodu = gs_input-sirket_kodu AND aktiflik = 'X'.
      IF sy-subrc = 0.
        SELECT * FROM zdop_t_kullanicb INTO TABLE gt_kullanicibakim WHERE kullanici_id = gs_input-kullanici_id.
        IF sy-subrc = 0.
          PERFORM calculateAge USING gs_input-dogum_tarihi.
          IF gv_age > 18.
            IF  gs_input-maas > 0.
              SELECT * FROM zdop_t_logkullan INTO TABLE gt_logkullanici
                WHERE sirket_kodu  = gs_input-sirket_kodu  AND
                      kullanici_id = gs_input-kullanici_id AND
                      adi          = gs_input-adi          AND
                      soyadi       = gs_input-soyadi       AND
                      dogum_tarihi = gs_input-dogum_tarihi AND
                      maas         = gs_input-maas.
                IF sy-subrc <> 0.
                  sy-subrc = 0.
                  PERFORM add_record.
                ELSE.
                  MESSAGE 'KAYIT MEVCUT' TYPE 'S' DISPLAY LIKE 'E'.
                ENDIF.
            ELSE.
              MESSAGE 'MAAŞ POZİTİF BİR DEĞER ALMALIDIR.' TYPE 'S' DISPLAY LIKE 'E'.
            ENDIF.
          ELSE.
            MESSAGE 'KULLANICI 18 YAŞINDAN BÜYÜK OLMALIDIR.' TYPE 'S' DISPLAY LIKE 'E'.
          ENDIF.
        ELSE.
          MESSAGE 'KULLANICI BAKIM TABLOSUNDA YOK' TYPE 'S' DISPLAY LIKE 'E'.
        ENDIF.
      ELSE.
        MESSAGE 'ŞİRKET KODU AKTİF DEĞİL.' TYPE 'S' DISPLAY LIKE 'E'.
      ENDIF.
    ELSE.
      MESSAGE 'ŞİRKET KODU BAKIM TABLOSUNDA YOK.' TYPE 'S' DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE 'TÜM ZORUNLU ALANLARI GİRİNİZ' TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form calculateAge
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GS_INPUT_DOGUM_TARIHI
*&---------------------------------------------------------------------*
FORM calculateAge  USING    p_gs_input_dogum_tarihi.
  gv_age = sy-datum+0(4) - p_gs_input_dogum_tarihi+0(4).
*  gv_age = sy-datum - p_gs_input_dogum_tarihi.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form add_record
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM add_record .
  gs_logkullanici-sirket_kodu  = gs_input-sirket_kodu.
  gs_logkullanici-kullanici_id = gs_input-kullanici_id.
  gs_logkullanici-adi          = gs_input-adi.
  gs_logkullanici-soyadi       = gs_input-soyadi.
  gs_logkullanici-dogum_tarihi = gs_input-dogum_tarihi.
  gs_logkullanici-maas         = gs_input-maas.
  INSERT zdop_t_logkullan FROM gs_logkullanici.

  IF sy-subrc <> 0.
    CLEAR gs_input.
    MESSAGE 'KAYIT İŞLEMİ GERÇEKLEŞTİRİLEMEDİ' TYPE 'S' DISPLAY LIKE 'E'.
  ELSE.

    CLEAR gs_logsirket.
    SELECT SINGLE *
     FROM zdop_t_logsirket
      INTO gs_logsirket WHERE sirket_kodu = gs_input-sirket_kodu.

      gs_logsirket-sirket_kodu    = gs_input-sirket_kodu.
      gs_logsirket-calisan_sayi   = gs_logsirket-calisan_sayi + 1.
      gs_logsirket-maas_hacmi     = gs_logsirket-maas_hacmi + gs_input-maas.
      MODIFY zdop_t_logsirket FROM gs_logsirket.
      INSERT zdop_t_logkullan FROM gs_logkullanici.

      IF sy-subrc <> 0.
        MESSAGE 'KAYIT İŞLEMİ BAŞARISIZ' TYPE 'S' DISPLAY LIKE 'E'.
      ENDIF.

      MESSAGE 'KAYIT İŞLEMİ GERÇEKLEŞTİ' TYPE 'S'.
      CLEAR  gs_input.
      LEAVE TO SCREEN 0100.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form DELETE_RECORD
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM delete_record .
  gs_logkullanici-sirket_kodu  = gs_input-sirket_kodu.
  gs_logkullanici-kullanici_id = gs_input-kullanici_id.
  gs_logkullanici-adi          = gs_input-adi.
  gs_logkullanici-soyadi       = gs_input-soyadi.
  gs_logkullanici-dogum_tarihi = gs_input-dogum_tarihi.
  gs_logkullanici-maas         = gs_input-maas.
  DELETE zdop_t_logkullan FROM gs_logkullanici.
  IF sy-subrc = 0.
    CLEAR gs_logsirket.
    SELECT SINGLE *
     FROM zdop_t_logsirket
      INTO gs_logsirket WHERE sirket_kodu = gs_input-sirket_kodu.

      gs_logsirket-sirket_kodu    = gs_input-sirket_kodu.
      gs_logsirket-calisan_sayi   = gs_logsirket-calisan_sayi - 1.
      gs_logsirket-maas_hacmi     = gs_logsirket-maas_hacmi - gs_input-maas.
      MODIFY zdop_t_logsirket FROM gs_logsirket.
      MESSAGE 'KAYIT SİLİNDİ' TYPE 'S'.
      LEAVE TO SCREEN 0.
  ELSE.
    MESSAGE 'KAYIT SİLİNEMEDİ' TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form UPDATE_RECORD
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM update_record .

  SELECT SINGLE * FROM  zdop_t_logkullan INTO gs_logkullanici
  WHERE sirket_kodu  = gs_input-sirket_kodu
    AND kullanici_id = gs_input-kullanici_id.

  gv_firstsal = gs_logkullanici-maas.

  gs_logkullanici-sirket_kodu  = gs_input-sirket_kodu.
  gs_logkullanici-kullanici_id = gs_input-kullanici_id.
  gs_logkullanici-adi          = gs_input-adi.
  gs_logkullanici-soyadi       = gs_input-soyadi.
  gs_logkullanici-dogum_tarihi = gs_input-dogum_tarihi.
  gs_logkullanici-maas         = gs_input-maas.
  MODIFY zdop_t_logkullan FROM gs_logkullanici.

  IF sy-subrc = 0.
    CLEAR gs_input.
    IF gv_firstsal NE gs_input-maas.
      SELECT SINGLE * FROM zdop_t_logsirket
      INTO gs_logsirket WHERE sirket_kodu = gs_logkullanici-sirket_kodu.
      IF sy-subrc = 0.
        gs_logsirket-maas_hacmi = gs_logsirket-maas_hacmi - gv_firstsal + gs_logkullanici-maas.
        MODIFY zdop_t_logsirket FROM gs_logsirket.
        MESSAGE 'KAYIT GÜNCELLENDİ' TYPE 'S'.
        LEAVE TO SCREEN 0.
      ELSE.
        MESSAGE 'KAYIT GÜNCELLENEMEDİ' TYPE 'S' DISPLAY LIKE 'E'.
      ENDIF.
    ELSE.
      MESSAGE 'KAYIT GÜNCELLENEMEDİ' TYPE 'S' DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    MESSAGE 'KAYIT GÜNCELLENEMEDİ' TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.
ENDFORM.
