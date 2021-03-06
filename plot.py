#!/usr/bin/python3

import matplotlib.pyplot as plt
import numpy as np
import csv 
import os 
import glob

csvs = [f for f in glob.glob("*.csv")]

# plt.figure()
fig, ax = plt.subplots()
ax.set_xscale('log', base=2)


for i in csvs:
    x = []
    y = []

    with open(i,'r') as csvfile:    
        lines = csv.reader(csvfile, delimiter=',')
        count_mod = 0
        tempy = 0.0
        for row in lines:
            tempy += float(row[1])
            if count_mod % 3 == 0:
                x.append(row[0])
                y.append(float(tempy/3.0))
                tempy = 0.0
            count_mod += 1

    x = x[::-1]
    x = [int(i) for i in x]
    y = y[::-1]
    plt.plot(x, y, linestyle = 'dashed',
            marker = 'o', label=i)

# Local Worksation half peak is 15732 MFLOP/s.
cores = os.cpu_count() / 2 # hyperthreading
plt.hlines(y=15732 * 10**6, xmin=2**5, xmax=2**24, colors='red', linestyles='dashed')

ax.legend()    

plt.gca().invert_xaxis()
plt.grid()
plt.show()
