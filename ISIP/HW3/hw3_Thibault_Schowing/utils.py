from skimage import io
import matplotlib.pyplot as plt
import numpy as np
import random
import os.path
# DEPRECATED
# from scipy.misc import imread
# Import PIL or use imread from other packages
from matplotlib.pyplot import imread


##############################################################################
#                        Functions for you to complete                       #
##############################################################################

################
# EXERCISE 2.1 #
################

def compute_ssd(patch, mask, texture, patch_half_size):
    # For all possible locations of patch in texture_img, computes sum square
    # difference for all pixels where mask = 0
    #
    # Inputs:
    #   patch: numpy array of size (2 * patch_half_size + 1, 2 * patch_half_size + 1, 3)
    #   mask: numpy array of size (2 * patch_half_size + 1, 2 * patch_half_size + 1)
    #   texture: numpy array of size (tex_rows, tex_cols, 3)
    #
    # Outputs:
    #   ssd: numpy array of size (tex_rows - 2 * patch_half_size, tex_cols - 2 * patch_half_size)
    
    patch_rows, patch_cols = np.shape(patch)[0],np.shape(patch)[1]
    
    assert patch_rows == 2 * patch_half_size + 1 and patch_cols == 2 * patch_half_size + 1, "patch size and patch_half_size do not match"
    tex_rows, tex_cols = np.shape(texture)[0], np.shape(texture)[1]
    ssd_rows = tex_rows - 2 * patch_half_size
    ssd_cols = tex_cols - 2 * patch_half_size
    ssd = np.zeros((ssd_rows, ssd_cols))
    
    patch[mask] = [0,0,0]
    
    # Loop center point  of SSD in texture
    for center_i in range(patch_half_size, tex_rows - patch_half_size):
        for center_j in range(patch_half_size, tex_cols - patch_half_size):
            
            tmp_texture = np.array(texture[center_i - patch_half_size:center_i + patch_half_size + 1, 
                                           center_j - patch_half_size:center_j + patch_half_size + 1])
            tmp_texture[mask == 0] = [0,0,0]
            ssd[center_i-patch_half_size, center_j-patch_half_size] = ((tmp_texture - patch)**2).sum()
            
    return ssd


################
# EXERCISE 2.2 #
################


def copy_patch(img, mask, texture, iPatchCenter, jPatchCenter, iMatchCenter, jMatchCenter, patch_half_size):
    # Copies the patch of size (2 * patch_half_size + 1, 2 * patch_half_size + 1)
    # centered on (iMatchCenter, jMatchCenter) in texture into the image
    # img with center coordinates (iPatchCenter, jPatchCenter) for each
    # pixel where mask = 1.
    #
    # Inputs:
    #   img: ndarray of size (im_rows, im_cols, 3)
    #   mask: numpy array of size (2 * patch_half_size + 1, 2 * patch_half_size + 1)
    #   texture: numpy array of size (tex_rows, tex_cols, 3)
    #   iPatchCenter, jPatchCenter, iMatchCenter, jMatchCenter, patch_half_size: integers
    #
    # Outputs:
    #   res: ndarray of size (im_rows, im_cols, 3)
    
    res = np.copy(img)
    
    patchSize = 2 * patch_half_size + 1
    iPatchTopLeft = iPatchCenter - patch_half_size
    jPatchTopLeft = jPatchCenter - patch_half_size
    iMatchTopLeft = iMatchCenter - patch_half_size
    jMatchTopLeft = jMatchCenter - patch_half_size
    
    
    for i in range(patchSize):
        for j in range(patchSize):
            # If it is not in the black region, don't fill
            if(mask[i, j] == 1 ):
                continue
            else:
                # Copy the pixel from the patch
                res[iPatchTopLeft + i, jPatchTopLeft + j] = texture[iMatchTopLeft + i, jMatchTopLeft + j]
            
    return res


def find_edge(mask):
    # Returns the edges of a binary mask image.
    # The result edge_mask is a binary image highlighting the edges
    [cols, rows] = np.shape(mask)
    edge_mask = np.zeros(np.shape(mask))
    for y in range(rows):
        for x in range(cols):
            if (mask[x, y]):
                if (mask[x - 1, y] == 0 or mask[x + 1, y] == 0 or mask[x, y - 1] == 0 or mask[x, y + 1] == 0):
                    edge_mask[x, y] = 1
    return edge_mask

