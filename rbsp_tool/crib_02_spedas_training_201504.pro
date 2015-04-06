;pro crib_02_spedas_training_201504
  
  ;Check if the necessary libraries have been installed properly.
  libs, 'overlay_map_sc_ifoot'  ;Does the full path of overlay_map_sc_ifoot.pro show up?
  geopack_help   ;Does the list of IDL_GEOPACK routiens show up?
  
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  ORBITAL PLOT FOR THEMIS and VAN ALLEN PROBES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;Load the orbit data for THEMIS-E and VAP-A for Jul. 25, 2013 
  timespan, '2013-07-25' 
  thm_load_state, probe='e', coord='sm', suffix='_sm'
  rbsp_load_emfisis, probe='a', cadence='4sec', coord='sm'
  ;Convert the unit from km to Re 
  tkm2re, 'the_state_pos_sm', /replace
  tkm2re, 'rbspa_emfisis_l3_4sec_sm_coordinates', /replace
  
  ;Plot each orbit projected on the X-Y plane. 
  window, 0, xsize=800, ysize=640 & erase
  tplotxy, 'the_state_pos_sm'
  tplotxy, 'rbspa_emfisis_l3_4sec_sm_coordinates'
  
  ;Plot both orbits with different colors on the X-Y plane of -12 Re < X,Y < 12 Re. 
  tplotxy, ['the_state_pos_sm','rbspa_emfisis_l3_4sec_sm_coordinates'], $
    xrange=[-12,12],yrange=[-12,12], colors=['b', 'r']
   ;The same but on the X-Z plane.
  tplotxy, ['the_state_pos_sm','rbspa_emfisis_l3_4sec_sm_coordinates'], $
    versus='xz', xrange=[-12,12],yrange=[-12,12], colors=['b', 'r']
  
  ;Plot orbits for the specific time range which is set by timespan command 
  timespan, ['2013-07-25/15:00','2013-07-25/23:00']
  tplotxy, ['the_state_pos_sm','rbspa_emfisis_l3_4sec_sm_coordinates'], $
    xrange=[-12,12],yrange=[-12,12], colors=['b', 'r']
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  IONOSPHERIC FOOTPRINT FOR THEMIS and VAN ALLEN PROBES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
  
  ;Obtain the footprint positions for VAP-A. 
  ;rbsp_ifoot command field-line-traces from the VAP-A positions to their ionospheric 
  ;footprints with IGRF and Tsyganenko 1996 magnetic field (T96) model by default. 
  ;Without "parmod" array given, the nominal solar wind and geomagnetic condition 
  ;(Pdyn = 1.0 nPa, Dst = 0 nT, IMF-By = 0 nT, and IMF-Bz = 0 nT) is applied for the field-line tracing. 
  timespan, '2013-07-25'
  rbsp_ifoot, probe='a' 
  
  ;Preparation for the 2-D plot on the world map 
  map2d_init    ;Initialize the map2d environment 
  map2d_coord, 'geo'   ;Set the coordinate system to geographical coordinates 
  window, 0, xsize=800, ysize=640 & erase     ;Generate an empty window 
  map2d_set   ;Draw the latitude-longitude grid (every 10 deg in lat and 15 deg in lon) on the window. 
  
  ;Draw the trace of ionospheric footprint for VAP-A, superposed by the world map.  
  overlay_map_sc_ifoot, 'rbspa_ifoot_geo_lat', 'rbspa_ifoot_geo_lon' 
  overlay_map_coast 
  
  ;Draw again, but for a specific time range this time. 
  map2d_set, /erase     ;Set "erase" keyword to clear the window and redraw the lat-lon grid 
  overlay_map_sc_ifoot, 'rbspa_ifoot_geo_lat', 'rbspa_ifoot_geo_lon', $
    ['2013-07-25/15:00','2013-07-25/23:00'] 
  overlay_map_coast
  
  ;Obtain the VAP-B footprints and superpose it on the VAP-A plot. 
  rbsp_ifoot, probe='b'
  overlay_map_sc_ifoot, 'rbspb_ifoot_geo_lat', 'rbspb_ifoot_geo_lon', $
    ['2013-07-25/15:00','2013-07-25/23:00']
  
  ;Calculate VAP-A footprints with the specific solar wind, geomagnetic condition. 
  ;Here an array given to keyword "parmod" means Pdyn = 5.0 nPa, Dst = 5.0 nT, IMF-By = 7.0 nT, 
  ;and IMF-Bz = -10.0 nT. These parameters are used for the field-line tracing with the T96 model. 
  rbsp_ifoot, probe='a', parmod=[ 5.0, 5.0, 7.0, -10.0 ] 
  overlay_map_sc_ifoot, 'rbspa_ifoot_geo_lat', 'rbspa_ifoot_geo_lon', $
    ['2013-07-25/15:00','2013-07-25/23:00'], trace_color=220 
    
  ;Add the footprints of THEMIS-E probe to the plot. 
  themis_ifoot, probe='e', parmod=[ 5.0, 5.0, 7.0, -10.0 ] 
  overlay_map_sc_ifoot, 'the_state_pos_ifoot_geo_lat', 'the_state_pos_ifoot_geo_lon', $
    ['2013-07-25/18:00','2013-07-25/23:00'], trace_color=50

  
  
end

