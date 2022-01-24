*&---------------------------------------------------------------------*
*& Report ZDOP_TREE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdop_tree.

TYPE-POOLS : icons, stree.

CONSTANTS : BEGIN OF gc_nodetype,
                root LIKE snode-type VALUE 'ROOT',
                mtart LIKE snode-type VALUE 'MTRT',
                mara LIKE  snode-type VALUE 'MARA',
            END OF gc_nodetype.


DATA : gt_mara TYPE TABLE OF mara,
       gt_mtart TYPE TABLE OF mtart.

DATA : gv_root_id TYPE snode-id.

START-OF-SELECTION.

SELECT DISTINCT mtart FROM mara INTO TABLE gt_mtart.

CHECK sy-subrc IS INITIAL.

SELECT * FROM mara INTO TABLE gt_mara.

CHECK sy-subrc IS INITIAL.

PERFORM create_tree CHANGING gv_root_id.

PERFORM load_tree USING gv_root_id.

PERFORM show_tree.
*&---------------------------------------------------------------------*
*& Form create_tree
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      <-- GV_ROOT_ID
*&---------------------------------------------------------------------*
FORM create_tree  CHANGING p_gv_root_id type snode-id.
  CALL FUNCTION 'RS_TREE_CREATE'
    EXPORTING
      root_name                = 'MALZEMELER'
     root_type                = gc_nodetype-root
*     DISPLAY_ATTRIBUTES       =
   IMPORTING
     root_id                  = p_gv_root_id
            .

ENDFORM.
*&---------------------------------------------------------------------*
*& Form load_tree
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GV_ROOT_ID
*&---------------------------------------------------------------------*
FORM load_tree  USING    p_gv_root_id.
  DATA : lv_mtart TYPE mtart,
         lv_node_id TYPE snode-id,
         ls_mara TYPE mara.

  SORT gt_mtart BY table_line ASCENDING.

  LOOP AT gt_mtart INTO lv_mtart.
    CLEAR lv_node_id.
    CALL FUNCTION 'RS_TREE_ADD_NODE'
      EXPORTING
        new_name                 = lv_mtart
        insert_id                = p_gv_root_id "lv_root_id
        relationship             = stree_reltype_child
*       LINK                     = ' '
       new_type                 = gc_nodetype-mtart
*       DISPLAY_ATTRIBUTES       = ' '
     IMPORTING
       new_id                   = lv_node_id
*       NODE_INFO                =
*     EXCEPTIONS
*       ID_NOT_FOUND             = 1
*       OTHERS                   = 2
              .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

    LOOP AT gt_mara INTO ls_mara WHERE mtart = lv_mtart.
      PERFORM add_node USING ls_mara lv_node_id.
    ENDLOOP.

  ENDLOOP.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form add_node
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> LS_MARA
*&      --> LV_NODE_ID
*&---------------------------------------------------------------------*
FORM add_node  USING    p_ls_mara type mara
                        p_lv_node_id type snode-id.
  DATA : ls_streeattr TYPE streeattr.

  ls_streeattr-text = p_ls_mara-matnr.
  ls_streeattr-tlength = 18.
  ls_streeattr-text1 = p_ls_mara-ersda.
  ls_streeattr-tlength1 = 8.
  ls_streeattr-text2 = p_ls_mara-mbrsh.
  ls_streeattr-tlength2 = 1.
  ls_streeattr-text3 = p_ls_mara-matkl.
  ls_streeattr-tlength3 = 9.
  ls_streeattr-text4 = p_ls_mara-meins.
  ls_streeattr-tlength4 = 3.
  ls_streeattr-text4 = p_ls_mara-bstme.
  ls_streeattr-tlength4 = 3.

  CALL FUNCTION 'RS_TREE_ADD_NODE'
    EXPORTING
      new_name                 = p_ls_mara-matnr
      insert_id                = p_lv_node_id
      relationship             = stree_reltype_child
*     LINK                     = ' '
     new_type                 = gc_nodetype-mara
     display_attributes       = ls_streeattr
*   IMPORTING
*     NEW_ID                   =
*     NODE_INFO                =
*   EXCEPTIONS
*     ID_NOT_FOUND             = 1
*     OTHERS                   = 2
            .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form show_tree
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM show_tree .
  CALL FUNCTION 'RS_TREE_LIST_DISPLAY'.

ENDFORM.
