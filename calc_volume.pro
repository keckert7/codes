PRO CALC_VOLUME,czin,czout,ra1,ra2,dec1,dec2,volume

;;;;;;;;;;;;;;;;;Written by Kathleen Eckert;;;;;;;;;
;computes the volume for a given geometry by 
;1. finding volume between two spheres
;2. computing the solid angle of the desired on sky coordinates
;3. multiply the shell volume by that portion
; parameters
;      czin   - inner redshift of desired volume(km/s)
;      czout  - outer redshift of desired volume (km/s)
;      ra1    - smaller value of RA range (decimal degrees)
;      ra2    - larger value of RA (decimal degrees)
;      dec1   - smaller value of Dec range (decimal degrees)
;      ra2    - larger value of Dec range (decimal degrees)
;      volume - returns computed volume 
; to test find 1/4 of hemisphere (1/8 of volume of sphere)
;CALC_VOLUME,0,10000,0,90,0,90,volume

;use lumdist code to measure distances with full cosmology, right now
;assume Omega_M=0.3 Lambda =0.7 but could change that if you wanted

Ho=100d ; km/s/Mpc, change if want to compute for 70
c=2.998d5

;1. Compute volumes of inner and outer spheres
disin=LUMDIST(DOUBLE(czin)/c,H0=Ho)   ; compute inner radius in (Mpc/h)
disout=LUMDIST(DOUBLE(czout)/c,H0=Ho) ; compute outer radius in (Mpc/h)

sphereinvol=(4d/3d)*!dpi*(disin/(1d + DOUBLE(czin)/c))^3 ; volume of inner Sphere (Mpc/h)^3
sphereoutvol=(4d/3d)*!dpi*(disout/(1d + DOUBLE(czout)/c))^3 ; volume of outer Sphere (Mpc/h)^3

shellvol=sphereoutvol-sphereinvol ; volume of shell between inner and outer sphere


;2. Compute Solid angle of on-sky geometry


;;;;RA;;;
;for RA doesn't matter where on sphere calculated
; compute difference in RA

IF (ra2 gt ra1) THEN radiff=ra2-ra1
IF (ra1 gt ra2) THEN radiff = (360.-ra1)+(ra2-0)

raarray=dindgen(ROUND(radiff*100))*0.01d

;;;;Dec;;;
;for Dec does matter where on sphere calculated
; compute array for Dec
decdiff=dec2-dec1
decarray=dindgen(ROUND(decdiff*200))*0.005+DOUBLE(dec1)

szra=N_ELEMENTS(raarray)
szdec=N_ELEMENTS(decarray)
;figure out changing RA due to different Dec
dec2dcorr=transpose(rebin(cos(decarray*!dpi/180d),szdec,szra))
ra2darray=rebin(raarray,szra,szdec)*dec2dcorr

;
dx=DBLARR(N_ELEMENTS(raarray)-1,N_ELEMENTS(decarray))

FOR i=0,N_ELEMENTS(raarray)-2 DO BEGIN
   dx[i,*]=ra2darray[i+1,*]-ra2darray[i,*]
ENDFOR


solidangle=total(dx*.005d)  


volume=(shellvol)*solidangle/(4d*!dpi*3282d)

print,'volume = ',volume, '(Mpc/h)^3'

; if run test case, can print out this statement to show 1/8 of sphere
;print,'should be 1/8 of sphere', volume/sphereoutvol



END
