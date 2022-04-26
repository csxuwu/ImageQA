import numpy as np
import math
import cv2

# Check arguments
import sys
args = sys.argv
if len(args) != 3:
    print( '\nUSAGE : $ python calc_NMSE.py [reference_image] [evaluation_image]' )
    sys.exit()

def read_img( _img_name ):
    img_BGR = cv2.imread( _img_name )
    img_RGB = cv2.cvtColor( img_BGR, cv2.COLOR_BGR2RGB )

    return img_RGB

def calc_nmse( _img_ref, _img_eva ):
    # Convert RGB to Gray
    img_gray_ref = cv2.cvtColor( _img_ref, cv2.COLOR_RGB2GRAY )
    img_gray_eva = cv2.cvtColor( _img_eva, cv2.COLOR_RGB2GRAY )

    # Calc NMSE
    # Grayscale ver.
    numer = np.sum( (img_gray_ref - img_gray_eva) ** 2 )
    denom = np.sum( (img_gray_ref) ** 2 )

    # RGB color ver.
    # numer = np.sum( (_img_ref - _img_eva) ** 2 )
    # denom = np.sum( (_img_ref) ** 2 )

    print( 'numer: {}'.format( numer ) )
    print( 'denom: {}'.format( denom ) )

    nmse = numer / denom
    return nmse

if __name__ == "__main__":
    # Read two images
    img_RGB_ref = read_img( args[1] )
    img_RGB_eva = read_img( args[2] )

    # Calc NMSE
    nmse = calc_nmse( img_RGB_ref, img_RGB_eva )
    print( 'NMSE : {:.2f}'.format( nmse ) )