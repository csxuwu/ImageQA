import numpy as np
import math
import cv2

# Check arguments
import sys
args = sys.argv
if len(args) != 3:
    print( '\nUSAGE : $ python calc_PSNR.py [reference_image] [evaluation_image]' )
    sys.exit()

def read_img( _img_name ):
    img_BGR = cv2.imread( _img_name )
    img_RGB = cv2.cvtColor( img_BGR, cv2.COLOR_BGR2RGB )

    return img_RGB

def calc_psnr( _img_ref, _img_eva, data_range=255 ):
    mse = np.mean( (_img_ref.astype(float) - _img_eva.astype(float)) ** 2 )
    return 10 * np.log10( (data_range ** 2) / mse )

if __name__ == "__main__":
    # Read two images
    img_RGB_ref = read_img( args[1] )
    img_RGB_eva = read_img( args[2] )

    # https://docs.opencv.org/4.2.0/d2/de8/group__core__array.html#ga3119e3ea73010a6f810bb05aa36ac8d6
    psnr = cv2.PSNR( img_RGB_ref, img_RGB_eva )
    # psnr = calc_psnr( img_RGB_ref, img_RGB_eva )
    print( 'PSNR: {}'.format( psnr ) )