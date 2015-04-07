; Set time range 
thm_init 
timespan, '2013-07-25', 1, /day  

;goto, lab1

; Load solar wind OMNI, SYM-H, and AE index data 
omni_hro_load 
get_data, 1, dlim=dlim
help, dlim 
tplot, [15,22,18], title='OMNI data' 

; Load THEMIS E Spin-fit magnetic field data 
thm_load_fgm, probe='e', coord='gsm', datatype='fgs', level='l2'  
cotrans, 'the_fgs_gsm', 'the_fgs_sm', /GSM2SM 

; Load THEMIS E ESA data 
thm_load_esa, level='l2', probe='e'

; Load THEMIS E SST data 
thm_load_sst, probe='e', level='l2'

; PLOT downloaded THEMIS data 
tvar =['the_fgs_sm', $
      'the_psef_en_eflux', $
      'the_peer_en_eflux', $
      'the_psif_en_eflux', $
      'the_peir_en_eflux'] 
tplot, tvar, title = 'THEMIS data' 


; Load Van Allen Probes A EMFISIS magnetometer data 
rbsp_load_emfisis, probe='a', coord='sm', cadence='4sec' 

; Load Van Allen Probes B EMFISIS magnetometer data 
rbsp_load_emfisis, probe='b', coord='sm', cadence='4sec' 

; Change color and add labels 
options, 'rbsp?_emfisis_l3_4sec_sm_Mag' , 'colors', [2,4,6]
options, 'rbsp?_emfisis_l3_4sec_sm_Mag' , 'labels', ['Bx','By','Bz'] 

; Load Van Allen Probes A MAGEIS electron and proton data 
rbsp_load_ect_mageis, probes='a', level='l2'

; Load Van Allen Probes B MAGEIS electron and proton data 
rbsp_load_ect_mageis, probes='b', level='l2'

; PLOT downloaded Van Allen Probes data 
tvar = ['rbspa_emfisis_l3_4sec_sm_Mag', $
        'rbspa_ect_mageis_FESA', $
        'rbspb_emfisis_l3_4sec_sm_Mag', $
        'rbspb_ect_mageis_FESA'] 
tplot, tvar, title='Van Allen Probes data' 
tlimit, '2013-07-25/'+['20:30','22:30'] 

lab1: 

;- - - PLOT 1: Overview - - - 
tvar = [$ 
      'OMNI_HRO_1min_BZ_GSM', $ 
      'OMNI_HRO_1min_Pressure', $ 
      'the_fgs_sm', $ 
      'the_psef_en_eflux', $ 
      'the_peer_en_eflux', $ 
      'rbspa_emfisis_l3_4sec_sm_Mag', $
      'rbspa_ect_mageis_FESA'] 
tplot, tvar, title='SAMPLE PLOT 1' 

;- - - PLOT 2: Line plot for particle data  - - - 
options, 'rbspa_ect_mageis_FESA', 'spec', 0 
tvar = [$ 
      'OMNI_HRO_1min_BZ_GSM', $ 
      'OMNI_HRO_1min_Pressure', $ 
      'rbspa_emfisis_l3_4sec_sm_Mag', $
      'rbspa_ect_mageis_FESA'] 
tplot, tvar, title='SAMPLE PLOT 2' 


end 

