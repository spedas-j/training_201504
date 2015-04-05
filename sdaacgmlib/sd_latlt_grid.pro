;+
; PROCEDURE/FUNCTION sd_latlt_grid
;
; :DESCRIPTION:
;		Draw the latitude-longitude mesh with given intervals in Lat and LT. 
;
;	:KEYWORDS:
;    dlat:  interval in Latitude [deg]. If not set, 10 deg is used as default. 
;    dlt:   interval in local time [hr]. If not set, 1 hour is used as default. 
;    twohourmltgrid: equivalent to setting dlt=2 
;    color: number of color table to be used for drawing lat-LT mesh
;    
; :EXAMPLES:
;    sd_map_set, /nogrid         ;sd_map_set automatically calls sd_latlt_grid unless nogrid keyword is set. 
;    sd_latlt_grid, dlat=10., dlt=2. 
;
; :AUTHOR:
; 	Tomo Hori (E-mail: horit@stelab.nagoya-u.ac.jp)
;
; :HISTORY:
; 	2011/01/11: Created
;
; $LastChangedBy: $
; $LastChangedDate: $
; $LastChangedRevision: $
; $URL: $
;-
PRO sd_latlt_grid, dlat=dlat, dlt=dlt, color=color, linethick=linethick, $
  twohourmltgrid=twohourmltgrid 
    
  ;Initialize the SD plot environment
  sd_init
  
  if ~keyword_set(dlat) then dlat = 10. 
  if ~keyword_set(dlt) then dlt = 1. 
  if keyword_set(twohourmltgrid) then dlt = 2. 
  
  map_grid, latdel=dlat, londel=15.*dlt, color=color, glinethick=linethick  
  
  
  
  RETURN
END
