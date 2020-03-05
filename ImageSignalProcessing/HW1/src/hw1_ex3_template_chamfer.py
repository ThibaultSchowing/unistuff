"""

Introduction to Signal and Image Processing
Homework 1

Created on Tue Mar 3, 2020
@author:
    
"""

import glob
import os
import numpy as np
import math # for Chamfering Algorithm
import matplotlib.pyplot as plt

# load shapes
shapes = glob.glob(os.path.join('shapes', '*.png'))
for i, shape in enumerate(shapes):  
    # load the edge map
    edge_map = None

    # caclulate distance map
    # distance_map: array_like, same size as edge_map
    distance_map = None

    # the top row of the plots should be the edge maps, and on the bottom the corresponding distance maps
    k, l = None, None
    plt.subplot(2, len(shapes), k)
    plt.imshow(edge_map, cmap='gray')
    plt.subplot(2, len(shapes), l)
    plt.imshow(distance_map, cmap='gray')

plt.show()


