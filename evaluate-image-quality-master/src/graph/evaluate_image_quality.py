import os
import numpy as np
import cv2
import math

# Check arguments
import sys
args = sys.argv
if len(args) != 3:
    print("\nUSAGE : $ python evaluate_image_quality.py [reference_image] [evaluation_image]")
    sys.exit()

# image1 is the original image, image2 is the noisy image
def computeMSE(image1,image2):
    rows, columns = grayImage1.shape
    meanSquaredError = np.sum((grayImage1.astype("float") - grayImage2.astype("float")) ** 2)
    meanSquaredError /= float(rows * columns)
    return meanSquaredError

def computeNMSE(image1,image2):
    meanSquaredError_numer = np.sum((grayImage1.astype("float") - grayImage2.astype("float")) ** 2)
    meanSquaredError_denom = np.sum((grayImage1.astype("float")) ** 2)
    normalizedMeanSquaredError = meanSquaredError_numer / meanSquaredError_denom

    # print("\nMSE_numer\n>", meanSquaredError_numer)
    # print("\nMSE_denom\n>", meanSquaredError_denom)

    return normalizedMeanSquaredError

# # Computing Peak Signal to Noise ratio
# def computePSNR(image1,image2):
#     meanSquaredError = computeMSE(image1,image2)    
#     PSNR = 10 * math.log(((255**2)/meanSquaredError),10)
#     return PSNR

# def computeColourPSNR(image1,image2):
#     lumaImage1 = cv2.cvtColor(image1, cv2.COLOR_BGR2YCR_CB)
#     lumaImage2 = cv2.cvtColor(image2, cv2.COLOR_BGR2YCR_CB)
#     cv2.imwrite("luma1.jpg",lumaImage1)
#     Y1, Cr1, Cb1 = cv2.split(lumaImage1)
#     Y2, Cr2, Cb2 = cv2.split(lumaImage2)
#     return computePSNR(Y1,Y2)    

if __name__ == "__main__":
    # Read two images
    img1 = cv2.imread( args[1] )
    img2 = cv2.imread( args[2] )

    # Converting to grayscale
    grayImage1 = cv2.cvtColor(img1, cv2.COLOR_BGR2GRAY)
    grayImage2 = cv2.cvtColor(img2, cv2.COLOR_BGR2GRAY)

    # Testing MSE
    mse = computeMSE(grayImage1,grayImage2)
    print ("\nMSE for different images")
    print (mse)

    # Testing MSE
    # different image
    nmse = computeNMSE(grayImage1,grayImage2)
    print ("\nNMSE for different images")
    print (nmse)

    # # Testing PSNR
    # PSNR = computePSNR(grayImage1,grayImage2)
    # print ("PSNR for different images")
    # print (PSNR)

    # # Testing coloured PSNR
    # colouredPSNR = computeColourPSNR(img1,img2)
    # print ("colouredPSNR for different images")
    # print (colouredPSNR)

    print("\n")