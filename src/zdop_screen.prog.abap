*&---------------------------------------------------------------------*
*& Report ZDOP_SCREEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdop_screen.

INCLUDE ZDOP_SCREEN_TOP.
INCLUDE ZDOP_SCREEN_F01.
INCLUDE ZDOP_SCREEN_I01.
INCLUDE ZDOP_SCREEN_O01.

INITIALIZATION.

START-OF-SELECTION.
  CALL SCREEN 100.
END-OF-SELECTION.
