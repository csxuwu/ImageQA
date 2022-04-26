import cv2
import sys
import matplotlib.pyplot as plt
import numpy as np

args = sys.argv
if len(args) != 2:
    sys.exit()

def read_img( _img_name ):
    img_BGR = cv2.imread( _img_name )
    img_RGB = cv2.cvtColor( img_BGR, cv2.COLOR_BGR2RGB )

    return img_RGB

def calc_statistics( _img ):
    print( 'statistics:' )
    print( 'max   : {}'.format( np.max(_img) ) )
    print( 'max   : {}'.format( np.min(_img) ) )
    print( 'mean  : {:.0f} ({:.0f})'.format( np.mean(_img), _img[_img != 0].mean() ) )
    print( 'std   : {:.0f} ({:.0f})'.format( np.std(_img), _img[_img != 0].std() ) )

if __name__ == "__main__":
    # Read one image
    img_RGB = read_img( r'G:\Code\Comparative-Experiment\code_comparative_experiment\quality_assessment_metrics\evaluate-image-quality-master\src\images\e_2.bmp' )

    # Convert RGB to Grayscale
    img_Gray = cv2.cvtColor( img_RGB, cv2.COLOR_RGB2GRAY )

    # Calculate statistics of the input image
    calc_statistics( img_Gray )