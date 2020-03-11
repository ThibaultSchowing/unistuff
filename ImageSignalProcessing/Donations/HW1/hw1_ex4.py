"""

Introduction to Signal and Image Processing
Homework 1

Created on Tue Mar 3, 2020
@author:
    
"""

import sys
import os
import numpy as np
import matplotlib.pyplot as plt
from bisect import bisect_right

def test_interp():
    # Tests the interp() function with a known input and output
    # Leads to error if test fails

    x = np.array([1, 2, 3, 4, 5, 6, 7, 8])
    y = np.array([0.2, 0.4, 0.6, 0.4, 0.6, 0.8, 1.0, 1.1])
    x_new = np.array((0.5, 2.3, 3, 5.45))
    y_new_solution = np.array([0.2, 0.46, 0.6, 0.69])
    y_new_result = interp(y, x, x_new)
    np.testing.assert_almost_equal(y_new_solution, y_new_result)


def test_interp_1D():
    # Test the interp_1D() function with a known input and output
    # Leads to error if test fails

    y = np.array([0.2, 0.4, 0.6, 0.4, 0.6, 0.8, 1.0, 1.1])
    y_rescaled_solution = np.array([
        0.20000000000000001, 0.29333333333333333, 0.38666666666666671,
        0.47999999999999998, 0.57333333333333336, 0.53333333333333333,
        0.44000000000000006, 0.45333333333333331, 0.54666666666666663,
        0.64000000000000001, 0.73333333333333339, 0.82666666666666677,
        0.91999999999999993, 1.0066666666666666, 1.0533333333333335,
        1.1000000000000001
    ])
    y_rescaled_result = interp_1D(y, 2)
    np.testing.assert_almost_equal(y_rescaled_solution, y_rescaled_result)


def test_interp_2D():
    # Tests interp_2D() function with a known and unknown output
    # Leads to error if test fails

    matrix = np.array([[1, 2, 3], [4, 5, 6]])
    matrix_scaled = np.array([[1., 1.4, 1.8, 2.2, 2.6, 3.],
                              [2., 2.4, 2.8, 3.2, 3.6, 4.],
                              [3., 3.4, 3.8, 4.2, 4.6, 5.],
                              [4., 4.4, 4.8, 5.2, 5.6, 6.]])

    result = interp_2D(matrix, 2)
    np.testing.assert_almost_equal(matrix_scaled, result)


def interp(y_vals, x_vals, x_new):
    # Computes interpolation at the given abscissas
    #
    # Inputs:
    #   x_vals: Given inputs abscissas, numpy array
    #   y_vals: Given input ordinates, numpy array
    #   x_new : New abscissas to find the respective interpolated ordinates, numpy
    #   arrays
    #
    # Outputs:
    #   y_new: Interpolated values, numpy array

    ################### PLEASE FILL IN THIS PART ###############################
    ## If there are only 2 values, output linearly placed points between those two values
    if len(y_vals)==2:
        return np.linspace(y_vals[0],y_vals[1],len(x_new))
    
    ## Sequentiqally calculate the slope between each pairs of points
    intervals = np.squeeze(np.dstack([x_vals[:-1], x_vals[1:], y_vals[:-1], y_vals[1:]]))
    slopes = np.array([(y2 - y1) / (x2 - x1) for x1, x2, y1, y2 in intervals])

    y_new = []
    for x in x_new: #Iterate over the new points
        # If the new abscissa is greater or smaller than the boundary, give it its value
        if x <= x_vals[0]:
            y_new.append(y_vals[0])
            continue
        elif x >= x_vals[-1]:
            y_new.append(y_vals[-1])
            continue
        else:
            i = bisect_right(x_vals, x) - 1 #find index of the new point
            y_new.append(y_vals[i] + slopes[i] * (x - x_vals[i])) #Calculate its value

    y_new = np.array(y_new)
    return y_new


def interp_1D(signal, scale_factor):
    # Linearly interpolates one dimensional signal by a given scaling fcator
    #
    # Inputs:
    #   signal: A one dimensional signal to be samples from, numpy array
    #   scale_factor: scaling factor, float
    #
    # Outputs:
    #   signal_interp: Interpolated 1D signal, numpy array

    ################### PLEASE FILL IN THIS PART ###############################

    #Get as many indices as there's value in the signal vector
    old_indices = np.arange(0,len(signal))
    #Get a scaled number of indices linearly placed in the signal's range
    new_indices = np.linspace(0,len(signal)-1,int(len(signal)*scale_factor))
    
    #Compute the new values
    signal_interp = interp(signal, old_indices, new_indices)
    
    return signal_interp


def interp_2D(img, scale_factor):
    # Applies bilinear interpolation using 1D linear interpolation
    # It first interpolates in one dimension and passes to the next dimension
    #
    # Inputs:
    #   img: 2D signal/image (grayscale or RGB), numpy array
    #   scale_factor: Scaling factor, float
    #
    # Outputs:
    #   img_interp: interpolated image with the expected output shape, numpy array

    ################### PLEASE FILL IN THIS PART ###############################
    #Get shape of the image
    shape = img.shape
    
    #If the image is greyscaled
    if len(shape)==2:
        #Linear interpolation on width of image
        scale_width = np.array([interp_1D(row, scale_factor) for row in img])
        #Linear interpolation on height of image
        scale_height = np.array([interp_1D(col, scale_factor) for col in scale_width.T])

        img_interp = scale_height.T
        return img_interp
        
    else:
        #Create rescaled empty image
        img_interp = np.empty((int(shape[0]*scale_factor),int(shape[1]*scale_factor),3),dtype=np.float32)
        #Iterate over the RGB channels
        for channel in range(3):
            scale_width = np.array([interp_1D(row, scale_factor) for row in img[:,:,channel]])

            scale_height = np.array([interp_1D(col, scale_factor) for col in scale_width.T])

            img_interp[:,:,channel] = scale_height.T

        return img_interp


# set arguments
#filename = 'bird.jpg'
filename = 'butterfly.jpg'
scale_factor = 1.5  # Scaling factor

# Before trying to directly test the bilinear interpolation on an image, we
# test the intermediate functions to see if the functions that are coded run
# correctly and give the expected results.

print('...................................................')
print('Testing test_interp()...')
test_interp()
print('done.')

print('Testing interp_1D()....')
test_interp_1D()
print('done.')

print('Testing interp_2D()....')
test_interp_2D()
print('done.')

print('Testing bilinear interpolation of an image...')
# Read image as a matrix, get image shapes before and after interpolation
img = (plt.imread(filename)).astype('float')  # need to convert to float
in_shape = img.shape  # Input image shape

# Apply bilinear interpolation
img_int = interp_2D(img, scale_factor)
print('done.')

# Now, we save the interpolated image and show the results
print('Plotting and saving results...')
plt.figure()
plt.imshow(img_int.astype('uint8'))  # Get back to uint8 data type
filename, _ = os.path.splitext(filename)
plt.savefig('{}_rescaled.jpg'.format(filename))
plt.close()

plt.figure()
plt.subplot(1, 2, 1)
plt.imshow(img.astype('uint8'))
plt.title('Original')
plt.subplot(1, 2, 2)
plt.imshow(img_int.astype('uint8'))
plt.title('Rescaled by {:2f}'.format(scale_factor))
print('Do not forget to close the plot window --- it happens:) ')
plt.show()

print('done.')
