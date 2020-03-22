# # Exercise 0.2
import numpy as np
import matplotlib.pyplot as plt


# Write a function create_image that generates an image with the height/width dimensions of n x m with uniform randomly distributed
# red and black pixels. Add a single green pixel at a random location.
def create_image(n,m):
    R = np.random.randint(2,size=(n,m))
    Z = np.zeros((n,m), dtype=int)
    img = np.dstack((R,Z,Z))
    img[np.random.randint(n),np.random.randint(m),:] = [0,1,0]
    return img


# Next, write a function find_pixels that finds the indexes of pixels with the values 'pixel_values' in an image 'img'
def find_pixels(img, pixel_values):
    mask = np.logical_and(img[:,:,0]==pixel_values[0], 
                          img[:,:,1]==pixel_values[1], 
                          img[:,:,2]==pixel_values[2])
    return np.argwhere(mask)


# Using the image img, compute the euclidean distance of each red pixel from the green pixel without the use of any for loops
def compute_distances(img):
    green_idx = find_pixels(img, [0,1,0])
    red_idx = find_pixels(img, [1,0,0])
    n = red_idx.shape[0]
    diff = np.ones((n, 1))*green_idx - red_idx
    return np.sqrt(np.sum(np.square(diff),axis=1))


# Display the computed distance vector 'dist' in a histogram (with 100 bins), compute the mean, standard deviation and the median.
# Display the values as a title above the plot
def visualize_results(dist):
    plt.hist(dist, bins =100)
    plt.title('distance mean=%f, std=%f, median=%f'
                %(np.mean(dist), np.std(dist), np.median(dist)))
    plt.show()

# Execute
img = create_image(100 ,200)
dist = compute_distances(img)
visualize_results(dist)


# plt.imshow(img*255, interpolation='nearest')
# plt.show()