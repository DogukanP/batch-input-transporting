REPORT zdp_satis_sip_rpr.

INCLUDE zdp_satis_sip_rpr_top.
INCLUDE zdp_satis_sip_rpr_c01.
INCLUDE zdp_satis_sip_rpr_f01.
INCLUDE zdp_satis_sip_rpr_i01.
INCLUDE zdp_satis_sip_rpr_o01.

START-OF-SELECTION.
  PERFORM get_data.

END-OF-SELECTION .
  PERFORM show_data .
