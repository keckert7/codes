PRO PRED_LOGGS_DIST, calibration, color, ra, dec, ploton,outfile

;;;;;;;;Written by Kathleen Eckert;;;;;;;;;;;
;code takes array of galaxies and outputs log(G/S) distribution
;for a given PGF probability density field model calibration 
;from Eckert et al. (2015) 

;***note that if you want to use a calibration with "modified color" 
;you must input that modified color rather than color by itself***

;calibration - set calibration that you want to use 
;               - 1 u-r (Table 4)
;               - 2 u-i (Table 4)
;               - 3 u-J (Table 4)
;               - 4 u-K (Table 4)
;               - 5 g-r (Table 4)
;               - 6 g-i (Table 4)
;               - 7 g-J (Table 4)
;               - 8 g-K (Table 4)
;               - 9  u-r  & b/a (Table 5)
;               - 10 u-i  & b/a (Table 5)
;               - 11 u-J  & b/a (Table 5)
;               - 12 u-K  & b/a (Table 5)
;               - 13 g-r  & b/a (Table 5)
;               - 14 g-i  & b/a (Table 5)
;               - 15 g-J  & b/a (Table 5)
;               - 16 g-K  & b/a (Table 5)
;               - 17 u-r w/ High M/L gals (Table 6)
;               - 18 u-i w/ High M/L gals (Table 6)
;               - 19 u-J w/ High M/L gals (Table 6)
;               - 20 u-K w/ High M/L gals (Table 6)
;               - 21 g-r w/ High M/L gals (Table 6)
;               - 22 g-i w/ High M/L gals (Table 6)
;               - 23 g-J w/ High M/L gals (Table 6)
;               - 24 g-K w/ High M/L gals (Table 6)
;               - 25 u-r  & b/a w/ High M/L gals (Table 7)
;               - 26 u-i  & b/a w/ High M/L gals (Table 7)
;               - 27 u-J  & b/a w/ High M/L gals (Table 7)
;               - 28 u-K  & b/a w/ High M/L gals (Table 7)
;               - 29 g-r  & b/a w/ High M/L gals (Table 7)
;               - 30 g-i  & b/a w/ High M/L gals (Table 7)
;               - 31 g-J  & b/a w/ High M/L gals (Table 7)
;               - 32 g-K  & b/a w/ High M/L gals (Table 7)
;color    - array of input colors or modified colors  ex: [3.1,4.4,5.2]
;ra       - array of ra matched to color 
;dec      - array of dec matched to color
;ploton   - set to 1 if you want to see         
;           plots of distributions, 0 if
;           just want to calculate distributions
;outfile  - name of file to save final distribution arrays ex:'gsdistfile.dat'

;;;;;;;;;;;;;;Figure out parameters

  IF (calibration eq 1) THEN BEGIN
     params=[17.22,0.33,0.22,-1.67 ,2.56 ,0.21 ,47.65 ,2.21 ,0.14]
  ENDIF
  IF (calibration eq 2) THEN BEGIN
     params=[35.05,0.46,0.24,-1.37 ,2.40 ,0.19 ,68.44 ,2.55 ,0.20]
  ENDIF
  IF (calibration eq 3) THEN BEGIN
     params=[32.55,1.00,0.17,-1.04 ,3.07 ,0.11 ,53.39 ,3.88 ,0.26]
  ENDIF
  IF (calibration eq 4) THEN BEGIN
     params=[30.18,1.26,0.13,-0.99 ,3.75 ,0.09 ,42.35 ,4.79 ,0.33]
  ENDIF
  IF (calibration eq 5) THEN BEGIN
     params=[19.70,-1.15,0.48,-3.65 ,1.51 ,0.87 ,115.1 ,0.72 ,0.05] 
  ENDIF
  IF (calibration eq 6) THEN BEGIN
     params=[19.99,-0.70,0.45,-2.47 ,1.58 ,0.55 ,72.29 ,1.05 ,0.09] 
  ENDIF
  IF (calibration eq 7) THEN BEGIN
     params=[16.99,0.51,0.19,-1.52 ,2.80 ,0.18 ,42.87 ,2.37 ,0.16]
  ENDIF
  IF (calibration eq 8) THEN BEGIN
     params=[31.08,0.91,0.15,-1.22 ,3.27 ,0.14 ,61.95 ,3.29 ,0.22]
  ENDIF
  IF (calibration eq 9) THEN BEGIN
     params=[38.78,1.05,0.20,-0.89 ,2.80 ,0.09 ,47.95 ,4.44 ,0.29]
  ENDIF
  IF (calibration eq 10) THEN BEGIN
     params=[37.78,0.97,0.21,-0.93 ,2.70 ,0.10 ,51.88 ,4.10 ,0.27]
  ENDIF
  IF (calibration eq 11) THEN BEGIN
     params=[38.13,1.25,0.16,-0.93 ,3.49 ,0.08 ,44.57 ,4.82 ,0.31]
  ENDIF
  IF (calibration eq 12) THEN BEGIN
     params=[34.54,1.43,0.14,-0.88 ,3.92 ,0.07 ,40.53 ,5.53 ,0.34]
  ENDIF
  IF (calibration eq 13) THEN BEGIN
     params=[42.65,0.37,0.37,-0.97 ,1.74 ,0.18 ,62.12 ,2.92 ,0.21]
  ENDIF
  IF (calibration eq 14) THEN BEGIN
     params=[40.95,0.45,0.36,-0.99 ,1.87 ,0.17 ,60.79 ,2.95 ,0.21]
  ENDIF
  IF (calibration eq 15) THEN BEGIN
     params=[36.40,1.10,0.18,-0.94 ,3.08 ,0.10 ,51.50 ,4.16 ,0.26]
  ENDIF
  IF (calibration eq 16) THEN BEGIN
     params=[33.79,1.37,0.14,-0.91 ,3.83 ,0.08 ,45.48 ,5.10 ,0.31]
  ENDIF
  IF (calibration eq 17) THEN BEGIN
     params=[34.56,0.31,0.23,-1.66 ,2.57 ,0.24 ,90.35 ,2.21 ,0.15] 
  ENDIF
  IF (calibration eq 18) THEN BEGIN
     params=[35.01,0.44,0.24,-1.44 ,2.54 ,0.20 ,68.48 ,2.55 ,0.20]
  ENDIF
  IF (calibration eq 19) THEN BEGIN
     params=[32.37,1.00,0.17,-1.10 ,3.28 ,0.12 ,53.83 ,3.88 ,0.26]
  ENDIF
  IF (calibration eq 20) THEN BEGIN
     params=[29.47,1.26,0.13,-1.03 ,3.93 ,0.10 ,42.53 ,4.78 ,0.33]
  ENDIF
  IF (calibration eq 21) THEN BEGIN
     params=[19.24,-1.17,0.49,-3.74 ,1.56 ,0.93 ,115.8 ,0.72 ,0.05] 
  ENDIF
  IF (calibration eq 22) THEN BEGIN
     params=[19.75,-0.71,0.45,-2.54 ,1.63 ,0.58 ,72.31 ,1.05 ,0.09] 
  ENDIF
  IF (calibration eq 23) THEN BEGIN
     params=[32.44,0.50,0.20,-1.54 ,2.87 ,0.22 ,82.06 ,2.39 ,0.17]
  ENDIF
  IF (calibration eq 24) THEN BEGIN
     params=[29.46,0.91,0.15,-1.29 ,3.46 ,0.15 ,62.12 ,3.29 ,0.23]
  ENDIF
  IF (calibration eq 25) THEN BEGIN
     params=[38.82,1.05,0.21,-0.90 ,2.84 ,0.10 ,48.06 ,4.44 ,0.29]
  ENDIF
  IF (calibration eq 26) THEN BEGIN
     params=[37.44,0.96,0.21,-0.96 ,2.79 ,0.11 ,51.32 ,4.10 ,0.27]
  ENDIF
  IF (calibration eq 27) THEN BEGIN
     params=[36.98,1.24,0.16,-0.98 ,3.66 ,0.08 ,44.90 ,4.82 ,0.31]
  ENDIF
  IF (calibration eq 28) THEN BEGIN
     params=[33.11,1.43,0.14,-0.91 ,4.05 ,0.07 ,40.99 ,5.53 ,0.34]
  ENDIF
  IF (calibration eq 29) THEN BEGIN
     params=[41.40,0.36,0.37,-1.01 ,1.82 ,0.19 ,61.93 ,2.91 ,0.21]
  ENDIF
  IF (calibration eq 30) THEN BEGIN
     params=[39.53,0.44,0.35,-1.03 ,1.97 ,0.18 ,60.35 ,2.95 ,0.21]
  ENDIF
  IF (calibration eq 31) THEN BEGIN
     params=[35.19,1.10,0.18,-0.97 ,3.20 ,0.10 ,51.74 ,4.16 ,0.26]
  ENDIF
  IF (calibration eq 32) THEN BEGIN
     params=[32.02,1.37,0.14,-0.94 ,3.96 ,0.08 ,45.97 ,5.10 ,0.31]
  ENDIF

 ;;;;;;;;;;; ; setup G/S "y" array
  yy=FINDGEN(101)/25.-2
  ycut=ALOG10(0.05)
 ;;;;;;;;;;; ; setup prob arrays
  zz1a = FLTARR(N_ELEMENTS(yy),N_ELEMENTS(color))
  zz1b = FLTARR(N_ELEMENTS(yy),N_ELEMENTS(color))
  zz2  = FLTARR(N_ELEMENTS(yy),N_ELEMENTS(color))
  zz   = FLTARR(N_ELEMENTS(yy),N_ELEMENTS(color))
;;;;;;;;;;; figure out distribution for each galaxy
  FOR i=0,N_ELEMENTS(color) -1 DO BEGIN
 
     ; main relation
     peak=params[0]*exp(-(ALOG(color[i])-params[1])^2/(2.*params[2]^2))/(color[i]*params[2]*sqrt(2.*!pi))

     zz1a[*,i] = peak*exp(-(yy-(params[3]*color[i]+params[4]))^2/(2.*(params[5]*color[i])^2))*(yy gt -1.3)
     zz1b[*,i] = peak*(((1./2.)*(params[5]*color[i])*sqrt(2.*!pi)) - (erf(ABS(ycut-(params[3]*color[i]+params[4]))/sqrt(2.*(params[5]*color[i])^2))*sqrt(2.*!Pi)*(params[5]*color[i])/2.))*(yy le -1.3 and yy gt -1.4)
     ; limit relation
     zz2[*,i] = params[6]*exp(-(color[i]-params[7])^2/(2.*params[8]^2))*(yy le -1.3 and yy gt -1.4)
     zz[*,i]=(zz1a[*,i]+zz1b[*,i]+zz2[*,i])/TOTAL(zz1a[*,i]+zz1b[*,i]+zz2[*,i])
  ;;;check


     IF (ploton) THEN BEGIN
        plot,yy,zz[*,i],xtitle='G/S',ytitle='probability'
        stop
     ENDIF
  ENDFOR

ragsdist=ra
decgsdist=dec
p_loggs=zz
loggs=yy
;;;;;;;;;;;;save out file with distributions
SAVE,ragsdist,decgsdist,p_loggs,loggs,filename=outfile

END
