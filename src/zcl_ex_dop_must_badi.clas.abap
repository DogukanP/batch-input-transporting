class ZCL_EX_DOP_MUST_BADI definition
  public
  final
  create public .

public section.

  interfaces ZIF_EX_DOP_MUST_BADI .

  constants VERSION type VERSION value 000001 ##NO_TEXT.
protected section.
private section.

  constants FLT_PATTERN type FILTNAME value '' ##NO_TEXT.
  data INSTANCE_BADI_TABLE type SXRT_EXIT_TAB .
  data INSTANCE_FLT_CACHE type SXRT_FLT_CACHE_TAB .
ENDCLASS.



CLASS ZCL_EX_DOP_MUST_BADI IMPLEMENTATION.


  method ZIF_EX_DOP_MUST_BADI~KDV_HESAPLA.
  CLASS CL_EXIT_MASTER DEFINITION LOAD.
  DATA: EXIT_OBJ_TAB TYPE SXRT_EXIT_TAB.

  DATA: exitintf TYPE REF TO ZIF_EX_DOP_MUST_BADI,
        wa_flt_cache_line TYPE REF TO sxrt_flt_cache_struct,
        flt_name TYPE FILTNAME.

  DATA: flt_val_db TYPE LAND1,
        desc_type(1) TYPE c, comp_num TYPE i.
  DESCRIBE FIELD flt_val_db TYPE desc_type COMPONENTS comp_num.

  FIELD-SYMBOLS:
    <flt_co1>        TYPE ANY,
    <flt_co2>        TYPE ANY.
  flt_name = flt_val.
  FIELD-SYMBOLS:
    <exit_obj>       TYPE SXRT_EXIT_TAB_STRUCT,
    <flt_cache_line> TYPE sxrt_flt_cache_struct.

  READ TABLE INSTANCE_FLT_CACHE ASSIGNING <flt_cache_line>
         WITH KEY flt_name    = flt_name
                  method_name = 'KDV_HESAPLA'
         .
  IF sy-subrc NE 0.

    CREATE DATA wa_flt_cache_line TYPE sxrt_flt_cache_struct.
    ASSIGN wa_flt_cache_line->* TO <flt_cache_line>.
    <flt_cache_line>-flt_name    = flt_name.
    <flt_cache_line>-method_name = 'KDV_HESAPLA'.

    READ TABLE INSTANCE_BADI_TABLE ASSIGNING <exit_obj>
           WITH KEY flt_val     = flt_name
                    method_name = 'KDV_HESAPLA'.
    If sy-subrc = 0.
      <flt_cache_line>-valid = <exit_obj>-active.
      IF <flt_cache_line>-valid = sxrt_true.
        <flt_cache_line>-obj =
             CL_EXIT_MASTER=>instantiate_imp_class(
                      CALLER       = me
                      imp_name  = <exit_obj>-imp_name
                      imp_class = <exit_obj>-imp_class ).
        MOVE <exit_obj>-imp_class to <flt_cache_line>-imp_class.
        MOVE <exit_obj>-imp_switch to <flt_cache_line>-imp_switch.
        MOVE <exit_obj>-order_num to <flt_cache_line>-order_num.
      ENDIF.
    ELSE.
      LOOP AT INSTANCE_BADI_TABLE ASSIGNING <exit_obj>
           WHERE METHOD_NAME  = 'KDV_HESAPLA'.
        APPEND <exit_obj> TO EXIT_OBJ_TAB.
      ENDLOOP.
      IF sy-subrc ne 0.
        CALL METHOD CL_EXIT_MASTER=>CREATE_OBJ_BY_INTERFACE_FILTER
           EXPORTING
              CALLER       = me
              INTER_NAME   = 'ZIF_EX_DOP_MUST_BADI'
              METHOD_NAME  = 'KDV_HESAPLA'

              delayed_instance_creation    = sxrt_true
           IMPORTING
               exit_obj_tab = exit_obj_tab.

        APPEND LINES OF exit_obj_tab TO INSTANCE_BADI_TABLE.
      ENDIF.

      <flt_cache_line>-valid = sxrt_false.

      LOOP at exit_obj_tab ASSIGNING <exit_obj>
          WHERE ACTIVE   = SXRT_TRUE.

        <flt_cache_line>-valid = sxrt_true.
        flt_val_db = <exit_obj>-flt_val.
        IF comp_num = 0.
          IF flt_val NP flt_val_db.
            <flt_cache_line>-valid = sxrt_false.
          ENDIF.
        ELSE.
          DO comp_num TIMES.
            ASSIGN COMPONENT sy-index OF STRUCTURE flt_val
              TO <flt_co1>.
            ASSIGN COMPONENT sy-index OF STRUCTURE flt_val_db
              TO <flt_co2>.
            IF <flt_co1> NP <flt_co2>.
              <flt_cache_line>-valid = sxrt_false.
              EXIT.
            ENDIF.
          ENDDO.
        ENDIF.
        IF <flt_cache_line>-valid = sxrt_true.
          <flt_cache_line>-obj =
               CL_EXIT_MASTER=>instantiate_imp_class(
                        CALLER       = me
                        imp_name  = <exit_obj>-imp_name
                        imp_class = <exit_obj>-imp_class ).
          MOVE <exit_obj>-imp_class to <flt_cache_line>-imp_class.
          MOVE <exit_obj>-imp_switch to <flt_cache_line>-imp_switch.
          MOVE <exit_obj>-order_num to <flt_cache_line>-order_num.
          EXIT.
        ENDIF.
      ENDLOOP.
    ENDIF.


    INSERT <flt_cache_line> INTO TABLE INSTANCE_FLT_CACHE.


  ENDIF.


  IF <flt_cache_line>-valid = sxrt_true.


    CALL FUNCTION 'PF_ASTAT_OPEN'
       EXPORTING
           OPENKEY = '00mfGAQx7joUXsUEXdRtf0'
           TYP     = 'UE'.

    CASE <flt_cache_line>-imp_switch.
      WHEN 'VSR'.
        DATA: exc        TYPE sfbm_xcptn,                  "#EC NEEDED
              data_ref   TYPE REF TO DATA.

        IF <flt_cache_line>-eo_object is initial.
          CALL METHOD ('CL_FOBU_METHOD_EVALUATION')=>load
               EXPORTING
                  im_class_name     = <flt_cache_line>-imp_class
                  im_interface_name = 'ZIF_EX_DOP_MUST_BADI'
                  im_method_name    = 'KDV_HESAPLA'
               RECEIVING
                  re_fobu_method    = <flt_cache_line>-eo_object
               EXCEPTIONS
                  not_found         = 1
                  OTHERS            = 2.
          IF sy-subrc = 2.
            MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                       WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
          ENDIF.
          CHECK sy-subrc = 0.
        ENDIF.


        CLEAR data_ref.
        GET REFERENCE OF IS_VBAK INTO data_ref.
        CALL METHOD <flt_cache_line>-eo_object->set_parameter(
            im_parmname = 'IS_VBAK'
            im_value    = data_ref ).

        CLEAR data_ref.
        GET REFERENCE OF IT_VBAP INTO data_ref.
        CALL METHOD <flt_cache_line>-eo_object->set_parameter(
            im_parmname = 'IT_VBAP'
            im_value    = data_ref ).

        CLEAR data_ref.
        GET REFERENCE OF FLT_VAL INTO data_ref.
        CALL METHOD <flt_cache_line>-eo_object->set_parameter(
            im_parmname = 'FLT_VAL'
            im_value    = data_ref ).

        CLEAR data_ref.
        GET REFERENCE OF EV_KDV INTO data_ref.
        CALL METHOD <flt_cache_line>-eo_object->set_parameter(
            im_parmname = 'EV_KDV'
            im_value    = data_ref ).

        CALL METHOD <flt_cache_line>-eo_object->evaluate
             IMPORTING
                ex_exception    = exc
             EXCEPTIONS
                raise_exception = 1
                OTHERS          = 2.
        IF sy-subrc = 2.
          MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                     WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.

        ENDIF.
      WHEN OTHERS.
        EXITINTF ?= <flt_cache_line>-OBJ.
        CALL METHOD EXITINTF->KDV_HESAPLA
           EXPORTING
             IS_VBAK = IS_VBAK
             IT_VBAP = IT_VBAP
             FLT_VAL = FLT_VAL
           IMPORTING
             EV_KDV = EV_KDV.


    ENDCASE.

    CALL FUNCTION 'PF_ASTAT_CLOSE'
       EXPORTING
           OPENKEY = '00mfGAQx7joUXsUEXdRtf0'
           TYP     = 'UE'.
  ENDIF.


  endmethod.
ENDCLASS.
