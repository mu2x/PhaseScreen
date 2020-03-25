# -*- coding: utf-8 -*-
"""
Created on Mon Mar  9 12:11:26 2020

@author: ferna
"""
"""

These are changes for the repository.

"""
import math # New change

import matplotlib
import pandas as pd
import numpy as np

# =============
# Incoming Data
# =============

df = pd.read_csv('01_Predictor_Matrix.csv', header=None)

rows = len(df)

coordinates = [[0.0 for y in range(6)] for x in range(rows)]
coordinates = np.array(coordinates)
   
for i in range(rows):
   for j in range(6):
       coordinates[i][j] = float(df.iat[i, j])
   
    
velocity = [[[0.0 for z in range(751)] for y in range(11)] for x in range(31)]
velocity = np.array(velocity)

temperature = [[[0.0 for z in range(751)] for y in range(11)] for x in range(31)]
temperature = np.array(temperature)

pressure = [[[0.0 for z in range(751)] for y in range(11)] for x in range(31)]
pressure = np.array(pressure)

results = [[[0.0 for z in range(751)] for y in range(11)] for x in range(31)]
results = np.array(results)

counter = 0

# =============================================================
# Assigning Matrix Values to temperature, Temperature, Pressure
# =============================================================

for i in range(rows):
                               
    velocity[abs(int(coordinates[counter,2]*100/2)-30), int(coordinates[counter,1]*100/2), abs(int(coordinates[counter,0]*100/2))] = coordinates[counter, 3]
    temperature[abs(int(coordinates[counter,2]*100/2)-30), int(coordinates[counter,1]*100/2), abs(int(coordinates[counter,0]*100/2))] = coordinates[counter, 4]
    pressure[abs(int(coordinates[counter,2]*100/2)-30), int(coordinates[counter,1]*100/2), abs(int(coordinates[counter,0]*100/2))] = coordinates[counter, 5]

    counter = counter + 1

x, y, z = velocity.shape

# print('x, y, z', x, y ,z)

accum = 0
counter = 0
integral = 0
average_integral = 0
square_difference = 0

# Base Analysis  
for c in range(z):
    for a in range(x):
        for b in range(y):
            # Delta Analysis
            for f in range(z):
                for d in range(x):
                    for e in range(y):
                        
                        slope_1 = 0.31
                        cross_1 = 15.5
            
                        if a > slope_1 * c + cross_1:
                            continue
                        
                        if a+d > slope_1 * c+f + cross_1:
                            continue
            
                        slope_2 = -0.17
                        cross_2 = 110.5
            
                        if a > slope_2 * c + cross_2:
                            continue
                        
                        if a+d > slope_2 * c+f + cross_2:
                            continue
                        
                        if  0 <= a + d < x and \
                            0 <= b + e < y and \
                            0 <= c + f < z:
                            
                           square_difference = (velocity[a,b,c] - velocity[a+d,b+e,c+f])**2
                           accum += square_difference
                           integral += square_difference
                           counter += 1
#                          print('a, b, c: ', a, b, c)
                           
            results[a, b, c] = accum
            print('a, b, c:', a, b, c)
#           print('results: ', results)
            accum = 0

if counter > 0:
    average_integral = integral/counter

stacked = pd.Panel(velocity.swapaxes(2,1)).to_frame().stack().reset_index()
stacked.columns = ['x', 'y', 'z', 'velocity']
stacked.to_csv('velocity.csv', index=False)

stacked = pd.Panel(results.swapaxes(2,1)).to_frame().stack().reset_index()
stacked.columns = ['x', 'y', 'z', 'results']
stacked.to_csv('results.csv', index=False)

# ===================
# Vectors for Results
# ===================

final_results = [0.0 for x in range(3)]
final_results = np.array(final_results)

final_results[0] = integral
final_results[1] = average_integral

np.savetxt('final_results.csv', final_results, delimiter=",")

