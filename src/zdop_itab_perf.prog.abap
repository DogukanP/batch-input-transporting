REPORT ZDOP_ITAB_PERF.

DATA : BEGIN OF gs_out ,
         vbeln LIKE vbak-vbeln,
         erdat LIKE vbak-erdat,
         erzet LIKE vbak-erzet,
         ernam LIKE vbak-ernam,
         angdt LIKE vbak-angdt,
         vkorg LIKE vbak-vkorg,
         spart LIKE vbak-spart,
         vkbur LIKE vbak-vkbur,
         vbkla LIKE vbak-vbkla,
         vbklt LIKE vbak-vbklt,
       END OF gs_out.

DATA : gt_standard LIKE TABLE OF gs_out.
DATA : gt_hashed   LIKE HASHED TABLE OF gs_out WITH UNIQUE KEY vbeln .
DATA : gt_sorted   LIKE SORTED TABLE OF gs_out WITH UNIQUE KEY vbeln .
DATA: lv_sta_time TYPE timestampl,
      lv_end_time TYPE timestampl,
      lv_diff     TYPE p DECIMALS 5.

GET TIME STAMP FIELD lv_sta_time.

SELECT vbak~vbeln
       vbak~erdat
       vbak~erzet
       vbak~ernam
       vbak~angdt
       vbak~vkorg
       vbak~spart
       vbak~vkbur
       vbak~vbkla
       vbak~vbklt  FROM vbak INTO TABLE gt_standard .

Read table gt_standard transporting no fields with key
vbeln = gs_out-vbeln
erdat = gs_out-erdat
erzet = gs_out-erzet
ernam = gs_out-ernam
angdt = gs_out-angdt
vkorg = gs_out-vkorg
spart = gs_out-spart
vkbur = gs_out-vkbur
vbkla = gs_out-vbkla .

GET TIME STAMP FIELD lv_end_time.
lv_diff  = lv_end_time - lv_sta_time.
WRITE: /(30) 'Standard Table', lv_diff.


*********************************


GET TIME STAMP FIELD lv_sta_time.

SELECT vbak~vbeln
       vbak~erdat
       vbak~erzet
       vbak~ernam
       vbak~angdt
       vbak~vkorg
       vbak~spart
       vbak~vkbur
       vbak~vbkla
       vbak~vbklt  FROM vbak INTO TABLE gt_hashed .

Read table gt_hashed transporting no fields with key
vbeln = gs_out-vbeln
erdat = gs_out-erdat
erzet = gs_out-erzet
ernam = gs_out-ernam
angdt = gs_out-angdt
vkorg = gs_out-vkorg
spart = gs_out-spart
vkbur = gs_out-vkbur
vbkla = gs_out-vbkla .

GET TIME STAMP FIELD lv_end_time.
lv_diff  = lv_end_time - lv_sta_time.
WRITE: /(30) 'Hashed Table', lv_diff.


**********************************

GET TIME STAMP FIELD lv_sta_time .

SELECT vbak~vbeln
       vbak~erdat
       vbak~erzet
       vbak~ernam
       vbak~angdt
       vbak~vkorg
       vbak~spart
       vbak~vkbur
       vbak~vbkla
       vbak~vbklt FROM vbak INTO TABLE gt_sorted .

Read table gt_sorted transporting no fields with key
vbeln = gs_out-vbeln
erdat = gs_out-erdat
erzet = gs_out-erzet
ernam = gs_out-ernam
angdt = gs_out-angdt
vkorg = gs_out-vkorg
spart = gs_out-spart
vkbur = gs_out-vkbur
vbkla = gs_out-vbkla .

GET TIME STAMP FIELD lv_end_time.
lv_diff  = lv_end_time - lv_sta_time.
WRITE: /(30) 'Sorted Table', lv_diff.
