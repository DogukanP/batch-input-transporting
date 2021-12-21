report ZDOP_BATCH_INPUT_FB01
       no standard page heading line-size 255.

include bdcrecx1.

parameters: dataset(132) lower case.
***    DO NOT CHANGE - the generated data section - DO NOT CHANGE    ***
*
*   If it is nessesary to change the data section use the rules:
*   1.) Each definition of a field exists of two lines
*   2.) The first line shows exactly the comment
*       '* data element: ' followed with the data element
*       which describes the field.
*       If you don't have a data element use the
*       comment without a data element name
*   3.) The second line shows the fieldname of the
*       structure, the fieldname must consist of
*       a fieldname and optional the character '_' and
*       three numbers and the field length in brackets
*   4.) Each field must be type C.
*
*** Generated data section with specific formatting - DO NOT CHANGE  ***
data: begin of record,
* data element: BLDAT
        BLDAT_001(010),
* data element: BLART
        BLART_002(002),
* data element: BUKRS
        BUKRS_003(004),
* data element: BUDAT
        BUDAT_004(010),
* data element: MONAT
        MONAT_005(002),
* data element: WAERS
        WAERS_006(005),
* data element: SAEOBJART
        DOCID_007(010),
* data element: NEWBS
        NEWBS_008(002),
* data element: NEWKO
        NEWKO_009(017),
* data element: WRBTR
        WRBTR_010(016),
* data element: VALUT
        VALUT_011(010),
* data element: NEWBS
        NEWBS_012(002),
* data element: NEWKO
        NEWKO_013(017),
* data element: FMORE
        FMORE_014(001),
* data element: VALUT
        VALUT_015(010),
* data element: WRBTR
        WRBTR_016(016),
* data element: FMORE
        FMORE_017(001),
      end of record.

*** End generated data section ***

start-of-selection.

perform open_dataset using dataset.
perform open_group.

do.

read dataset dataset into record.
if sy-subrc <> 0. exit. endif.

perform bdc_dynpro      using 'SAPMF05A' '0100'.
perform bdc_field       using 'BDC_CURSOR'
                              'RF05A-NEWKO'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_field       using 'BKPF-BLDAT'
                              record-BLDAT_001.
perform bdc_field       using 'BKPF-BLART'
                              record-BLART_002.
perform bdc_field       using 'BKPF-BUKRS'
                              record-BUKRS_003.
perform bdc_field       using 'BKPF-BUDAT'
                              record-BUDAT_004.
perform bdc_field       using 'BKPF-MONAT'
                              record-MONAT_005.
perform bdc_field       using 'BKPF-WAERS'
                              record-WAERS_006.
perform bdc_field       using 'FS006-DOCID'
                              record-DOCID_007.
perform bdc_field       using 'RF05A-NEWBS'
                              record-NEWBS_008.
perform bdc_field       using 'RF05A-NEWKO'
                              record-NEWKO_009.
perform bdc_dynpro      using 'SAPMF05A' '0300'.
perform bdc_field       using 'BDC_CURSOR'
                              'RF05A-NEWKO'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_field       using 'BSEG-WRBTR'
                              record-WRBTR_010.
perform bdc_field       using 'BSEG-VALUT'
                              record-VALUT_011.
perform bdc_field       using 'RF05A-NEWBS'
                              record-NEWBS_012.
perform bdc_field       using 'RF05A-NEWKO'
                              record-NEWKO_013.
perform bdc_field       using 'DKACB-FMORE'
                              record-FMORE_014.
perform bdc_dynpro      using 'SAPLKACB' '0002'.
perform bdc_field       using 'BDC_CURSOR'
                              'COBL-GSBER'.
perform bdc_field       using 'BDC_OKCODE'
                              '=ENTE'.
perform bdc_dynpro      using 'SAPMF05A' '0300'.
perform bdc_field       using 'BDC_CURSOR'
                              'BSEG-WRBTR'.
perform bdc_field       using 'BDC_OKCODE'
                              'BU'.
perform bdc_field       using 'BSEG-VALUT'
                              record-VALUT_015.
perform bdc_field       using 'BSEG-WRBTR'
                              record-WRBTR_016.
perform bdc_field       using 'DKACB-FMORE'
                              record-FMORE_017.
perform bdc_dynpro      using 'SAPLKACB' '0002'.
perform bdc_field       using 'BDC_CURSOR'
                              'COBL-PS_PSP_PNR'.
perform bdc_field       using 'BDC_OKCODE'
                              '=ENTE'.
perform bdc_transaction using 'FB01'.

enddo.

perform close_group.
perform close_dataset using dataset.
