# # Exercise 0.3

# Given an image I of shape width x height x channels, search for threshold values tmin, tmax, such that a mask m
# contains only pixels of the stop sign.
import numpy as np
import matplotlib.pyplot as plt

img = plt.imread('stopturnsigns.jpg')

plt.imshow(img)
plt.show()

t_min = [230,30,50]
t_max = [255,65,95]

m = np.empty(img.shape)
for c in range(3):
    m[..., c] = np.all([img[..., c] >= t_min[c],img[..., c] <= t_max[c]], axis=0)

plt.imshow(np.all(m,axis=2))
plt.show()


# As you can see, manual thresholding is very difficult and seldomely provides a useable segmentation.
print(np.all(m,axis=2))
