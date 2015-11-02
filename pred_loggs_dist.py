'''
Written by Kathleen Eckert
code takes array of galaxies and outputs log(G/S) distribution
for a given PGF probability density field model calibration 
from Eckert et al. (2015) 

set parameters color, ploton, outfile, and calibration at end of code

         color - array of galaxy color values, must be defined as numpy array
                 ***note that if you want to use a calibration with "modified 
                 color" you must input that modified color rather than color 
                 by itself***
        ploton - 1 shows distribution of log(G/S) for each color value
               - 0 turns plotting off
       outfile - string name of pickle file output 
   calibration - set calibration that you want to use 
               - 1 u-r (Table 4)
               - 2 u-i (Table 4)
               - 3 u-J (Table 4)
               - 4 u-K (Table 4)
               - 5 g-r (Table 4)
               - 6 g-i (Table 4)
               - 7 g-J (Table 4)
               - 8 g-K (Table 4)
               - 9  u-r  & b/a (Table 5)
               - 10 u-i  & b/a (Table 5)
               - 11 u-J  & b/a (Table 5)
               - 12 u-K  & b/a (Table 5)
               - 13 g-r  & b/a (Table 5)
               - 14 g-i  & b/a (Table 5)
               - 15 g-J  & b/a (Table 5)
               - 16 g-K  & b/a (Table 5)
               - 17 u-r w/ High M/L gals (Table 6)
               - 18 u-i w/ High M/L gals (Table 6)
               - 19 u-J w/ High M/L gals (Table 6)
               - 20 u-K w/ High M/L gals (Table 6)
               - 21 g-r w/ High M/L gals (Table 6)
               - 22 g-i w/ High M/L gals (Table 6)
               - 23 g-J w/ High M/L gals (Table 6)
               - 24 g-K w/ High M/L gals (Table 6)
               - 25 u-r  & b/a w/ High M/L gals (Table 7)
               - 26 u-i  & b/a w/ High M/L gals (Table 7)
               - 27 u-J  & b/a w/ High M/L gals (Table 7)
               - 28 u-K  & b/a w/ High M/L gals (Table 7)
               - 29 g-r  & b/a w/ High M/L gals (Table 7)
               - 30 g-i  & b/a w/ High M/L gals (Table 7)
               - 31 g-J  & b/a w/ High M/L gals (Table 7)
               - 32 g-K  & b/a w/ High M/L gals (Table 7)

'''
import sys
import numpy as np
import scipy.special as ss
import matplotlib.pyplot as plt
import pickle

#print calibration
def getpars(calibration):

    if calibration == 1:
        params=np.array([17.22,0.33,0.22,-1.67 ,2.56 ,0.21 ,47.65 ,2.21 ,0.14])

    if calibration == 2:
        params=np.array([35.05,0.46,0.24,-1.37 ,2.40 ,0.19 ,68.44 ,2.55 ,0.20])

    if calibration == 3:
        params=np.array([32.55,1.00,0.17,-1.04 ,3.07 ,0.11 ,53.39 ,3.88 ,0.26])

    if calibration == 4:
        params=np.array([30.18,1.26,0.13,-0.99 ,3.75 ,0.09 ,42.35 ,4.79 ,0.33])
  
    if calibration == 5:
        params=np.array([19.70,-1.15,0.48,-3.65 ,1.51 ,0.87 ,115.1 ,0.72 ,0.05])
 
    if calibration == 6:
        params=np.array([19.99,-0.70,0.45,-2.47 ,1.58 ,0.55 ,72.29 ,1.05 ,0.09])
  
    if calibration == 7:
        params=np.array([16.99,0.51,0.19,-1.52 ,2.80 ,0.18 ,42.87 ,2.37 ,0.16])
  
    if calibration == 8:
        params=np.array([31.08,0.91,0.15,-1.22 ,3.27 ,0.14 ,61.95 ,3.29 ,0.22])
  
    if calibration == 9:
        params=np.array([38.78,1.05,0.20,-0.89 ,2.80 ,0.09 ,47.95 ,4.44 ,0.29])
  
    if calibration == 10:
        params=np.array([37.78,0.97,0.21,-0.93 ,2.70 ,0.10 ,51.88 ,4.10 ,0.27])
  
    if calibration == 11:
        params=np.array([38.13,1.25,0.16,-0.93 ,3.49 ,0.08 ,44.57 ,4.82 ,0.31])
  
    if calibration == 12:
        params=np.array([34.54,1.43,0.14,-0.88 ,3.92 ,0.07 ,40.53 ,5.53 ,0.34])
    
    if calibration == 13:
        params=np.array([42.65,0.37,0.37,-0.97 ,1.74 ,0.18 ,62.12 ,2.92 ,0.21])
  
    if calibration == 14:
        params=np.array([40.95,0.45,0.36,-0.99 ,1.87 ,0.17 ,60.79 ,2.95 ,0.21])
 
    if calibration == 15:
        params=np.array([36.40,1.10,0.18,-0.94 ,3.08 ,0.10 ,51.50 ,4.16 ,0.26])
  
    if calibration == 16:
        params=np.array([33.79,1.37,0.14,-0.91 ,3.83 ,0.08 ,45.48 ,5.10 ,0.31])

    if calibration == 17:
        params=np.array([34.56,0.31,0.23,-1.66 ,2.57 ,0.24 ,90.35 ,2.21 ,0.15])

    if calibration == 18:
        params=np.array([35.01,0.44,0.24,-1.44 ,2.54 ,0.20 ,68.48 ,2.55 ,0.20])

    if calibration == 19:
        params=np.array([32.37,1.00,0.17,-1.10 ,3.28 ,0.12 ,53.83 ,3.88 ,0.26])

    if calibration == 20:
        params=np.array([29.47,1.26,0.13,-1.03 ,3.93 ,0.10 ,42.53 ,4.78 ,0.33])

    if calibration == 21:
        params=np.array([19.24,-1.17,0.49,-3.74 ,1.56 ,0.93 ,115.8 ,0.72 ,0.05])

    if calibration == 22:
        params=np.array([19.75,-0.71,0.45,-2.54 ,1.63 ,0.58 ,72.31 ,1.05 ,0.09])

    if calibration == 23:
        params=np.array([32.44,0.50,0.20,-1.54 ,2.87 ,0.22 ,82.06 ,2.39 ,0.17])

    if calibration == 24:
        params=np.array([29.46,0.91,0.15,-1.29 ,3.46 ,0.15 ,62.12 ,3.29 ,0.23])

    if calibration == 25:
        params=np.array([38.82,1.05,0.21,-0.90 ,2.84 ,0.10 ,48.06 ,4.44 ,0.29])

    if calibration == 26:
        params=np.array([37.44,0.96,0.21,-0.96 ,2.79 ,0.11 ,51.32 ,4.10 ,0.27])

    if calibration == 27:
        params=np.array([36.98,1.24,0.16,-0.98 ,3.66 ,0.08 ,44.90 ,4.82 ,0.31])

    if calibration == 28:
        params=np.array([33.11,1.43,0.14,-0.91 ,4.05 ,0.07 ,40.99 ,5.53 ,0.34])

    if calibration == 29:
        params=np.array([41.40,0.36,0.37,-1.01 ,1.82 ,0.19 ,61.93 ,2.91 ,0.21])

    if calibration == 30:
        params=np.array([39.53,0.44,0.35,-1.03 ,1.97 ,0.18 ,60.35 ,2.95 ,0.21])

    if calibration == 31:
        params=np.array([35.19,1.10,0.18,-0.97 ,3.20 ,0.10 ,51.74 ,4.16 ,0.26])

    if calibration == 32:
        params=np.array([32.02,1.37,0.14,-0.94 ,3.96 ,0.08 ,45.97 ,5.10 ,0.31])

    return params


def estimategovers(color,pars,ploton):
####### setup G/S "y" array
    yy=np.arange(-2,2.04,0.04)
    ycut=np.log10(0.05)


####### setup prob arrays
    zz1a = np.zeros((np.size(yy),np.size(color)))
    zz1b = np.zeros((np.size(yy),np.size(color)))
    zz2  = np.zeros((np.size(yy),np.size(color)))
    zz   = np.zeros((np.size(yy),np.size(color)))


    for i in range(np.size(color)):

        peak=pars[0]*np.exp(-np.power((np.log(color[i])-pars[1]),2)/(2*np.power(pars[2],2)))/(color[i]*pars[2]*np.sqrt(2*np.pi))

        zz1a[np.where(yy > -1.3),i]=peak*np.exp(-np.power((yy[np.where(yy > -1.3)]-(pars[3]*color[i]+pars[4])),2)/(2*np.power((pars[5]*color[i]),2)))
        zz1b[np.where((yy <= -1.3) & (yy > -1.4)),i]=peak*((0.5*(pars[5]*color[i])*np.sqrt(2*np.pi)) - (ss.erf(np.fabs(ycut-(pars[3]*color[i]+pars[4]))/np.sqrt(2*np.power(pars[5]*color[i],2)))*0.5*np.sqrt(2*np.pi)*pars[5]*color[i]))
        zz2[np.where((yy <= -1.3) & (yy > -1.4)),i]=pars[6]*np.exp(-np.power((color[i]-pars[7]),2)/(2*np.power(pars[8],2)))


        zz[:,i]=(zz1a[:,i]+zz1b[:,i]+zz2[:,i])/(np.sum(zz1a[:,i]+zz1b[:,i]+zz2[:,i]))
        #print np.sum(zz[:,i])

        if (ploton >=1):
            plt.plot(yy,zz[:,i])
            plt.show()

    return yy, zz    


if __name__ == '__main__':

    calibration=1
    color=np.array([0.9,1.5,2.2])
    ploton=1
    outfile="test.p"

    # get parameters for particular calibration (see top)
    pars=getpars(calibration) 

    # estimate G/S for provided array of galaxy colors
    ## array of log(G/S) saved as loggs
    ## probability of each distribution of log(G/S) saved in p_loggs
    loggs,p_loggs=estimategovers(color,pars,ploton) 
    
    fileobject=open(outfile,'wb')
    pickle.dump([loggs,p_loggs],fileobject)
    fileobject.close()
    # to open in a new file:
    #in=pickle.load(outfile,'r')
    #loggs=in[0]
    #p_loggs=in[1]
