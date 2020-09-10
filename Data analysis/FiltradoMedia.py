import numpy as np
import pandas as pd
from scipy.optimize import curve_fit


def datos_int(dir_data):
    '''
    
    Calcula la media de las muestras de un archivo de datos 
    y retorna el set de datos completo, el promedio, la dispersión
    el intervalo de los grados y el error en la medisión 
    
    
    '''
    
    Data  = pd.read_csv(dir_data)
    variable = Data['Intensidad'][100]
    tama1=len(Data)
    lindex = Data[Data['Intensidad'] == variable].index
    tama = len(lindex)
    
    
    Data_2 = np.ones(tama)
    Data_2_dist = np.ones(tama)
    Data_2[0] = Data[0:100].astype(float).mean()
    Data_2_dist[0] = Data[0:100].astype(float).std()
    for i in range(1,tama-1):
        Data_2[i] = Data[lindex[i]+1:lindex[i+1]].astype(float).mean()
        Data_2_dist[i] = Data[lindex[i]+1:lindex[i+1]].astype(float).std()

    Data_2[tama-1] = Data[lindex[i+1]+1:tama1-1].astype(float).mean()
    Data_2_dist[tama-1] = Data[lindex[i+1]+1:tama1-1].astype(float).std()
    
    grados_10 = range(0,tama*5,5)
    grados_dist = np.ones(tama)
    
    return [Data, Data_2, Data_2_dist, grados_10, grados_dist]

def ajuste_int(all_data):
    '''
    
    Calcula la media de las muestras de un archivo de datos 
    y retorna el set de datos completo, el promedio, la dispersión
    el intervalo de los grados y el error en la medisión 
    
    
    '''
    
    Data, Data_2, Data_2_dist, grados_10, grados_dist = all_data
    
    def malus(x,a,c,d):
        return a*(np.cos(np.radians(x) + c)**2) + d
    
    popt, pcov = curve_fit(malus, grados_10, Data_2, sigma = Data_2_dist, absolute_sigma=True)
    
    grados = np.linspace(0,max(grados_10),len(grados_10))
    teo = malus(grados, popt[0], popt[1], popt[2])
    
    return [grados, teo]

