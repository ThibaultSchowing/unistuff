import numpy as np
import matplotlib.pyplot as plt
from scipy import signal
import os

#This sets the gray colormap as default for matplotlib
plt.rcParams['image.cmap'] = 'gray'

img = plt.imread('cat.jpg').astype(np.float32)

def boxfilter(n):
    # this function returns a box filter of size nxn
    return (1./(n ** 2))*np.ones((n, n))


bsize = 10

box_filter = boxfilter(bsize)
conv_image_box = signal.convolve2d(img, box_filter)
plt.subplot(121)
plt.imshow(img)
plt.title('Original image')
plt.axis('off')
plt.subplot(122)
plt.imshow(conv_image_box)
plt.axis('off')
plt.title('Image filtered with box filter of size ' + str(bsize))

plt.savefig(os.path.join('..', 'pics', 'q2.eps'))
#plt.show()
