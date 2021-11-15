#!/usr/bin/python3

import matplotlib.pyplot as plt
import numpy as np
import csv
import math 

csvs = [('g','hpx.csv'), ('b', 'omp.csv')]

# plt.figure()
fig, ax = plt.subplots()
ax.set_xscale('log', basex=2)


for i in csvs:
    x = []
    y = []

    with open(i[1],'r') as csvfile:    
        lines = csv.reader(csvfile, delimiter=',')
        count_mod = 0
        tempy = 0.0
        for row in lines:
            print(row[1])
            tempy += float(row[1])
            if count_mod % 3 == 0:
                x.append(row[0])
                y.append(float(tempy/3.0))
                tempy = 0.0
            count_mod += 1

    x = x[::-1]
    x = [int(i) for i in x]
    y = y[::-1] 
    print(x)
    print(y)
    plt.plot(x, y, color = i[0], linestyle = 'dashed',
            marker = 'o')
    

# Local Worksation half peak is 15732 MFLOP/s.
plt.hlines(y=15732 * 10**6, xmin=2**5, xmax=2**24, colors='red', linestyles='dashed')

plt.gca().invert_xaxis()
plt.grid()
plt.show()
