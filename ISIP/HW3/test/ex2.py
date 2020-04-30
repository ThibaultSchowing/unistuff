from skimage import io
import matplotlib.pyplot as plt
import numpy as np
import random
import os.path

from scipy import stats

# DEPRECATED
# from scipy.misc import imread
# Import PIL or use imread from other packages
from matplotlib.pyplot import imread


import utils as utls

def show(img, name = "Some image"):
    plt.imshow(img)
    plt.axis('off')
    plt.title(name)
    plt.show()



#
# Constants
#

# Change patch_half_size to change the patch size used (patch size is 2 * patch_half_size + 1)
patch_half_size = 10
patchSize = 2 * patch_half_size + 1

# Display results interactively
showResults = True

# Read input image

filename = '../img/donkey'
#filename = './img/tomato'
# filename = './img/yacht'

# load image
im_array = imread(filename + '.jpg')#, mode='RGB')
imRows, imCols, imBands = np.shape(im_array)

# load fill region mask
fill_region = imread(filename + '_fill.png')

# load texture mask
texture_region = imread(filename + '_texture.png')

# prepare to display the first 2 subplots of the output
if showResults:
    plt.subplot(1,3,1)
    plt.imshow(im_array)
    plt.title('original Image')

    # create an image with the masked region blacked out, and a rectangle indicating where to
    # fill it from
    im_mask_fill = np.copy(im_array)
    im_mask_fill[np.where(fill_region)] = [0, 0, 0] #blacks out the donkey
    texture_outline = utls.find_edge(texture_region) 
    im_mask_fill[np.where(texture_outline)] = [255, 255, 255] # white border of texture region

    # show it
    plt.subplot(1,3,2)
    plt.imshow(im_mask_fill)
    plt.title('Image with masked region and region to take texture from')

#
# Get coordinates for masked region and texture regions
#
fill_indices = fill_region.nonzero() #2d indexes of pixels to fill 
assert((min(fill_indices[0]) >= patch_half_size) and
        (max(fill_indices[0]) < imRows - patch_half_size) and
        (min(fill_indices[1]) >= patch_half_size) and
        (max(fill_indices[1]) < imCols - patch_half_size)), "Masked region is too close to the edge of the image for this patch size"

texture_indices = texture_region.nonzero() #2d indexes of texture to take 
# Rectangle of texture taken from the image
texture_img = im_array[min(texture_indices[0]):max(texture_indices[0]) + 1,
                        min(texture_indices[1]):max(texture_indices[1]) + 1, :] 
assert((texture_img.shape[0] > patchSize) and
        (texture_img.shape[1] > patchSize)), "Texture region is smaller than patch size"




#
# Initialize im_filled for texture synthesis (i.e., set fill pixels to 0)
#

# TODO - Verify this
#im_filled = im.copy()
im_filled = im_array.copy()
im_filled[fill_indices] = 0

show(im_filled, "Genesis of imfilled")
# image with black part instead of donkey -> to be filled


#
# Fill the masked region
#

# While there are pixels in the fill_indices 
while (len(fill_indices[0])  > 0):
    print("Number of pixels remaining = ", len(fill_indices[0]) )

    # Set fill_region_edge to pixels on the boundary of the current fill_region
    fill_region_edge = utls.find_edge(fill_region)
    
    edge_pixels = fill_region_edge.nonzero() # Tuple of two lists ([p11,p12,p13],[p21,p22,p23])
    
    #show(fill_region, "fill region")
    #show(fill_region_edge, "fill region edgeu")
    
    
    while(len(edge_pixels[0]) > 0):
        # for the random pixel
        l = len(edge_pixels[0])
        
        # Pick a random pixel from the fill_region_edge
        # Select one pixel randomly of the edge_pixels tuple of list 
        
        
        rand = random.randint(0,l-1)
        #print("length edge_pixels: ", l-1)
        #print("Rand: ", rand)
        patch_center_i, patch_center_j = edge_pixels[0][rand] , edge_pixels[1][rand]
        
        
        
        
        
        
        # Image around patch_center
        show(im_filled, "imfilled beforepatch")
        patch_to_fill = im_filled[patch_center_i-patch_half_size:patch_center_i+patch_half_size+1,
                                  patch_center_j-patch_half_size:patch_center_j+patch_half_size+1]
        show(im_filled, "imfilled afterpatch")
        
        show(patch_to_fill, "Patch to fill ")
        
        # 1/0 of the image patch that is black or not
        patch_mask = np.where(np.all(patch_to_fill == [0,0,0], axis=-1), 0, 1 )
        #show(patch_mask, "patch mask")
        
        
        #
        # Compute masked SSD of patch_to_fill and texture_img
        #
        
        # TODO: put back utls.
        ssd_img = utls.compute_ssd(patch_to_fill, patch_mask, texture_img, patch_half_size)
        min_ssd = np.where(ssd_img == np.amin(ssd_img))
        selected_center_i, selected_center_j = min_ssd[0][0], min_ssd[1][0]
        
        
        
        #
        # Copy patch into masked region
        #
        
        # TODO: put back utls.
        show(im_filled, "imfilled before copy patch")
        show(texture_img, "texture passed to copy")
        im_filled = utls.copy_patch(im_filled, patch_mask, texture_img, patch_center_i, patch_center_j, selected_center_i, selected_center_j, patch_half_size)
        show(im_filled, "imfilled after copy patch")
        
        
        #TODO
        # Update fill_region_edge and fill_region by removing locations that overlapped the patch
        
        fill_region_edge[patch_center_i-patch_half_size:patch_center_i+patch_half_size+1,
                         patch_center_j-patch_half_size:patch_center_j+patch_half_size+1] = 0
        
        
        
        # update edge pixels
        edge_pixels = fill_region_edge.nonzero()
        
    
    
    fill_region[patch_center_i-patch_half_size:patch_center_i+patch_half_size+1,
                patch_center_j-patch_half_size:patch_center_j+patch_half_size+1] = 0
    
    
    fill_indices = fill_region.nonzero()

#
# Output results
#
if showResults:
    plt.subplot(1,3,3)
    plt.imshow(im_filled)
    plt.title('Filled Image')
    
    plt.show()
