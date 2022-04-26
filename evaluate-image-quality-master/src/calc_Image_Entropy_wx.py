import cv2
import sys
import matplotlib.pyplot as plt
import numpy as np


# ----------------------------
# 2022.1.4
# csxuwu@163.com
# 计算单张图像的 entropy
# ----------------------------

# args = sys.argv
# if len(args) != 2:
#     sys.exit()

def read_img( _img_name ):
    img_BGR = cv2.imread( _img_name )
    img_RGB = cv2.cvtColor( img_BGR, cv2.COLOR_BGR2RGB )

    return img_RGB

def calc_entropy( _histogram, _num_of_pixels ):
    entropy = 0

    for i in range( 256 ):
        # Calc the probability of appearance of pixel value "i"
        p = _histogram[i] / _num_of_pixels

        if p == 0:
            continue
        entropy -= p * np.log2( p )

    return entropy

if __name__ == "__main__":



    # Read one image
    img_path = r'G:\Code\Comparative-Experiment\code_comparative_experiment\quality_assessment_metrics\evaluate-image-quality-master\src\images\e_2.bmp'
    img_RGB = read_img( img_path )

    # Convert RGB to Grayscale
    img_Gray = cv2.cvtColor( img_RGB, cv2.COLOR_RGB2GRAY )

    # Get histogram of the input image
    img_hist, img_bins = np.histogram( np.array( img_Gray ).flatten(), bins=np.arange( 256+1 ) )
    # print( img_hist.shape ) (255,)

    # Calculate entropy of the input image
    num_of_pixels = img_RGB.shape[0] * img_RGB.shape[1]
    entropy = calc_entropy( img_hist, num_of_pixels )
    print( 'Entropy: {:.2f}'.format( entropy ) )