*&---------------------------------------------------------------------*
*& Report ZDOP_XML
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDOP_XML.

PERFORM STRUCTURE_CONVERT_XML.
PERFORM ITAB_CONVERT_XML.

*&---------------------------------------------------------------------*
*& Form STRUCTURE_CONVERT_XML
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM structure_convert_xml .
    DATA : BEGIN OF GS_CALISAN,
              YAS      TYPE I,
              ISIM     TYPE C LENGTH 20,
              SOYISIM  TYPE C LENGTH 20,
              POZISYON TYPE C LENGTH 40,
              TEL      TYPE N LENGTH 11,
           END OF GS_CALISAN.

    DATA : GV_XML TYPE XSTRING.

*    START-OF-SELECTION.

    GS_CALISAN-YAS      = 22.
    GS_CALISAN-ISIM     = 'DOGUKAN'.
    GS_CALISAN-SOYISIM  = 'PADEL'.
    GS_CALISAN-POZISYON = 'JR. ABAP CONSULTANT' .
    GS_CALISAN-TEL      = '05369635737'.

    "STANDART ID TRANSFORMASYONUNUN ÇAĞRILARAK DEĞİŞKENLERİN XML BINARY STRİNG DEĞİŞKENİNE EKLENMESİ

    CALL TRANSFORMATION ID SOURCE CALISAN_BILGILERI = GS_CALISAN
    RESULT XML GV_XML.

    CL_ABAP_BROWSER=>SHOW_XML( XML_XSTRING = GV_XML ).
ENDFORM.
*&---------------------------------------------------------------------*
*& Form ITAB_CONVERT_XML
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM itab_convert_xml .
   DATA : BEGIN OF GS_KURS,
            KURS_ADI    TYPE C LENGTH 40,
            KURS_SURESI TYPE C LENGTH 20,
            KURUM       TYPE C LENGTH 20,
            TELEFON     TYPE N LENGTH 11,
           END OF GS_KURS.

    DATA : GT_KURS LIKE TABLE OF GS_KURS,
           GV_XML  TYPE STRING.

    DEFINE KURS_EKLE.
      CLEAR GS_KURS.
      GS_KURS-KURS_ADI    = &1 .
      GS_KURS-KURS_SURESI = &2 .
      GS_KURS-KURUM       = &3 .
      GS_KURS-TELEFON     = &4 .
      APPEND GS_KURS TO GT_KURS.
    END-OF-DEFINITION.


    KURS_EKLE 'SAP-ABAP PROGRAMLAMA' '12 HAFTA' 'PRODEA' '12345678912'.
    KURS_EKLE 'WEB PROGRAMLAMA' '5 HAFTA' 'DENEME' '12345678912'.
    KURS_EKLE 'PYTHON PROGRAMLAMA' '8 HAFTA' 'KODLAMA.IO' '12345678912'.


    CALL TRANSFORMATION ID SOURCE KURSLAR = GT_KURS
                           RESULT XML GV_XML.

    CALL METHOD CL_ABAP_BROWSER=>SHOW_XML
      EXPORTING
        XML_STRING = GV_XML
        SIZE       = CL_ABAP_BROWSER=>XLARGE
        TITLE      = 'KURSLAR'
        .
ENDFORM.
