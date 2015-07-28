PRO PRED_LOGGS_DIST, calibration, color, ra, dec, ploton,outfile

  ;calibration - calibration that you want to use 
;               - 1 u-r
;               - 2 u-i
;               - 3 u-'
;               - 4 u-K
;               - 5 g-r
;               - 6 g-i
;               - 7 g-J
;               - 8 g-K
;               - 9 u-r  & b/a
;               - 10 u-i  & b/a
;               - 11 u-J  & b/a
;               - 12 u-K  & b/a
;               - 13 g-r  & b/a
;               - 14 g-i  & b/a
;               - 15 g-J  & b/a
;               - 16 g-K  & b/a
  ;color    - array of input colors             ex: [3.1,4.4,5.2]
  ;ra       - array of ra matched to color 
  ;dec      - array of dec matched to color
  ;ploton   - set to 1 if you want to see         
  ;           plots of distributions, 0 if
  ;           just want to calculate distributions
  ;outfile  - name of file to save final distribution arrays ex:'gsdistfile.dat'

;;;;;;;;;;;;;;Figure out parameters

  IF (calibration eq 1) THEN BEGIN
     params=[17.00,0.33,0.22,-1.69 ,2.56 ,0.21 ,46.02 ,2.21 ,0.14,1.357]
  ENDIF
  IF (calibration eq 2) THEN BEGIN
     params=[34.83,0.46,0.24,-1.37 ,2.40 ,0.19 ,68.10 ,2.55 ,0.20,1.460]
  ENDIF
  IF (calibration eq 3) THEN BEGIN
     params=[32.57,1.01,0.17,-1.04 ,3.09 ,0.11 ,53.14 ,3.89 ,0.26,1.227]
  ENDIF
  IF (calibration eq 4) THEN BEGIN
     params=[30.32,1.26,0.14,-0.99 ,3.75 ,0.09 ,41.59 ,4.78 ,0.33,1.435]
  ENDIF
  IF (calibration eq 5) THEN BEGIN
     params=[19.47,-1.15,0.48,-3.60 ,1.50 ,0.87 ,110.6 ,0.72 ,0.05,1.893]
  ENDIF
  IF (calibration eq 6) THEN BEGIN
     params=[19.66,-0.70,0.45,-2.49 ,1.58 ,0.56 ,70.74 ,1.05 ,0.09,1.381]
  ENDIF
  IF (calibration eq 7) THEN BEGIN
     params=[17.03,0.51,0.19,-1.55 ,2.84 ,0.18 ,42.72 ,2.38 ,0.15,1.034]
  ENDIF
  IF (calibration eq 8) THEN BEGIN
     params=[30.74,0.91,0.15,-1.27 ,3.38 ,0.13 ,61.78 ,3.29 ,0.23,1.248]
  ENDIF
  IF (calibration eq 9) THEN BEGIN
     params=[39.06,1.07,0.21,-0.89 ,2.82 ,0.09 ,45.22 ,4.48 ,0.30,1.152]
  ENDIF
  IF (calibration eq 10) THEN BEGIN
     params=[37.99,0.97,0.21,-0.94 ,2.73 ,0.10 ,50.59 ,4.10 ,0.27,1.046]
  ENDIF
  IF (calibration eq 11) THEN BEGIN
     params=[38.02,1.24,0.16,-0.97 ,3.58 ,0.08 ,44.81 ,4.78 ,0.31,1.146]
  ENDIF
  IF (calibration eq 12) THEN BEGIN
     params=[35.89,1.42,0.14,-0.91 ,4.01 ,0.07 ,42.31 ,5.47 ,0.33,1.122]
  ENDIF
  IF (calibration eq 13) THEN BEGIN
     params=[42.33,0.37,0.37,-1.01 ,1.80 ,0.17 ,56.99 ,2.87 ,0.23,1.298]
  ENDIF
  IF (calibration eq 14) THEN BEGIN
     params=[40.55,0.45,0.35,-1.01 ,1.90 ,0.17 ,55.53 ,2.89 ,0.23,1.248]
  ENDIF
  IF (calibration eq 15) THEN BEGIN
     params=[37.37,1.08,0.18,-0.99 ,3.17 ,0.09 ,52.54 ,4.10 ,0.26,1.146]
  ENDIF
  IF (calibration eq 16) THEN BEGIN
     params=[34.84,1.31,0.14,-0.95 ,3.76 ,0.08 ,44.62 ,4.81 ,0.30,1.079]
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
