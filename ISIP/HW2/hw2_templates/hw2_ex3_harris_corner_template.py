""" 3 Corner detection """

# Imports
import numpy as np
import matplotlib.pyplot as plt
plt.rcParams['image.cmap'] = 'gray'
from scipy.signal import convolve2d, convolve
from skimage import color, io
import pdb

# Load the image, convert to float and grayscale
img = io.imread('chessboard.jpg')

# 3.1
# Write a function myharris(image) which computes the harris corner for each pixel in the image. The function should return the R
# response at each location of the image.
# HINT: You may have to play with different parameters to have appropriate R maps.
# Try Gaussian smoothing with sigma=0.2, Gradient summing over a 5x5 region around each pixel and k = 0.1.)
def myharris(image, w_size, sigma, k):
    # This function computes the harris corner for each pixel in the image
    # INPUTS
    # @image    : a 2-D image as a numpy array
    # @w_size   : an integer denoting the size of the window over which the gradients will be summed
    # sigma     : gaussian smoothing sigma parameter
    # k         : harris corner constant
    # OUTPUTS
    # @R        : 2-D numpy array of same size as image, containing the R response for each image location

    ### your code should go here ###

    return R


# 3.2
# Evaluate myharris on the image
R = myharris(img, 5, 0.2, 0.1)
plt.imshow(R)
plt.colorbar()
plt.show()


# 3.3
# Repeat with rotated image by 45 degrees
# HINT: Use scipy.ndimage.rotate() function
R_rotated =     ### your code should go here ###
plt.imshow(R_rotated)
plt.colorbar()
plt.show()


# 3.4
# Repeat with downscaled image by a factor of half
# HINT: Use scipy.misc.imresize() function
R_scaled =      ### your code should go here ###
plt.imshow(R_scaled)
plt.colorbar()
plt.show()
