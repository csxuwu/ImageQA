#
# 2枚の画像のヒストグラムを作成し，比較するプログラム
# 比较两张图的直方图
# https://github.com/tom-uchida/evaluate-image-quality
#

import cv2, matplotlib
import numpy as np
import matplotlib.pyplot as plt
plt.style.use('seaborn-white')

from matplotlib import cycler
colors = cycler('color', ['#EE6666', '#3388BB', '#9988DD', '#EECC55', '#88BB44', '#FFBBBB'])
plt.rc('axes', facecolor='#E6E6E6', edgecolor='none', axisbelow=True, grid=False, prop_cycle=colors)
plt.rc('grid', color='w', linestyle='solid')
plt.rc('patch', edgecolor='#E6E6E6')
plt.rc('lines', linewidth=2)

plt.rcParams["mathtext.fontset"] = "stix"
plt.rcParams["mathtext.rm"] = "Times New Roman"



# ------------------------------
# ----- Placement settings -----
# ------------------------------
fig, ax = plt.subplots(3, figsize=(9, 8)) # figsize(width, height)
fig.subplots_adjust(hspace=0.4, wspace=0.4) # interval
ax[0] = plt.subplot2grid((2,2), (0,0))
ax[1] = plt.subplot2grid((2,2), (0,1))
ax[2] = plt.subplot2grid((2,2), (1,0), colspan=2)



# ----------------------------
# ----- Read input image -----
# ----------------------------
def read_img(_img_name):
	# read input image
	img = cv2.imread(_img_name)

	# convert color (BGR → RGB)
	img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)

	return img

# img_origin_RL1	 = read_img('images/DATA/uniformly/1024/plane_10M_RL1.bmp')
# img_origin_RL100 = read_img('images/DATA/uniformly/1024/plane_10M_RL100.bmp')
# img_noised_RL1	 = read_img('images/DATA/uniformly/1024/gaussian_9M_1M_RL1.bmp')
# img_noised_RL100 = read_img('images/DATA/uniformly/1024/gaussian_9M_1M_RL100.bmp')
img_origin_RL1   = read_img(r'G:\Code\Comparative-Experiment\code_comparative_experiment\quality_assessment_metrics\evaluate-image-quality-master\src\images\2_INet_v23_00.jpg')
# img_origin_RL100 = read_img(r'G:\Dataset\LL_Set\LIME\2.bmp')
img_origin_RL100 = read_img(r'G:\Code\Comparative-Experiment\code_comparative_experiment\quality_assessment_metrics\evaluate-image-quality-master\src\images\2_INet_v23_00.jpg')
img_noised_RL1   = read_img(r'G:\Code\Comparative-Experiment\code_comparative_experiment\quality_assessment_metrics\evaluate-image-quality-master\src\images\k_2.bmp')
img_noised_RL100 = read_img(r'G:\Code\Comparative-Experiment\code_comparative_experiment\quality_assessment_metrics\evaluate-image-quality-master\src\images\2_INet_v121_00.jpg')
# image information（height × width × 色数）
# print("img_origin : ", img_origin.shape)  
# print("img_noised : ", img_noised.shape)
# print("\n")



# ----------------------------
# ----- Show input image -----
# ----------------------------
def show_img(_i, _img, _img_name):
  ax[_i].set_title(_img_name)

  # show image
  ax[_i].imshow(_img)

  return

#show_img(0, img_origin_RL1,    "Original image, $L_{\mathrm{R}}=1$")
show_img(0, img_origin_RL100,  "Original image, $L_{\mathrm{R}}=100$")
# show_img(0, img_noised_RL1,    "Noise image, $L_{\mathrm{R}}=1$")
show_img(1, img_noised_RL100,  "Noise image, $L_{\mathrm{R}}=100$")



# -------------------------------
# ----- Convert RGB to Gray -----
# -------------------------------
gray_img_origin_RL1   = cv2.cvtColor(img_origin_RL1,   cv2.COLOR_RGB2GRAY)
gray_img_origin_RL100 = cv2.cvtColor(img_origin_RL100, cv2.COLOR_RGB2GRAY)
gray_img_noised_RL1 	= cv2.cvtColor(img_noised_RL1,   cv2.COLOR_RGB2GRAY)
gray_img_noised_RL100 = cv2.cvtColor(img_noised_RL100, cv2.COLOR_RGB2GRAY)

# exclude pixel value == 0 
gray_img_origin_RL1_nonzero   = gray_img_origin_RL1[gray_img_origin_RL1     > 0]
gray_img_origin_RL100_nonzero = gray_img_origin_RL100[gray_img_origin_RL100 > 0]
gray_img_noised_RL1_nonzero   = gray_img_noised_RL1[gray_img_noised_RL1     > 0]
gray_img_noised_RL100_nonzero = gray_img_noised_RL100[gray_img_noised_RL100 > 0]


# print("gray_img_origin : ", gray_img_origin.shape)  
# print("gray_img_noised : ", gray_img_noised.shape)
# print("\n")



# --------------------------------------------------------------------
# ----- Calc difference of brightness values of two input images -----
# --------------------------------------------------------------------
# bigger_RL1 		= np.maximum(gray_img_origin_RL1_nonzero, gray_img_noised_RL1_nonzero)
# smaller_RL1 	= np.minimum(gray_img_origin_RL1_nonzero, gray_img_noised_RL1_nonzero)

# bigger_RL100 	= np.maximum(gray_img_origin_RL100_nonzero, gray_img_noised_RL100_nonzero)
# smaller_RL100 = np.minimum(gray_img_origin_RL100_nonzero, gray_img_noised_RL100_nonzero)

# diff_RL1      = bigger_RL1   - smaller_RL1
# diff_RL100    = bigger_RL100 - smaller_RL100



# ---------------------
# ----- Histogram -----
# ---------------------
# store values of "histogram and bin boundary" in two variables(hist, bins)
#hist_origin, 		    bins_origin 		  = np.histogram(gray_img_origin.ravel(),			  256, [0, 256])
# hist_origin_RL100, 	bins_origin_RL100 = np.histogram(gray_img_origin_RL100.ravel(),	256, [0, 256])

# #hist_noised, 		    bins_noised 		  = np.histogram(gray_img_noised.ravel(),  		  256, [0, 256])
# hist_noised,        bins_noised       = np.histogram(gray_img_noised.ravel())
# hist_noised_RL100, 	bins_noised_RL100 = np.histogram(gray_img_noised_RL100.ravel(), 256, [0, 256])

# diff_hist_origin,   diff_bins_origin  = np.histogram(diff.ravel(), 		    256, [0, 256])
# diff_hist_RL100,    diff_bins_RL100   = np.histogram(diff_RL100.ravel(),  256, [0, 256])



# -----------------------------------------------
# ----- Get statistical data of pixel value -----
# -----------------------------------------------
def get_data_of_pixel_value(_pixel_value):
  print("===== Statistical Data of Pixel Values =====")
  print("> Max    : ", np.max(_pixel_value))
  print("> Min    : ", np.min(_pixel_value))
  print("> Mean   : ", np.mean(_pixel_value))
  #print("> Median : ", np.median(_pixel_value))
  print("\n")
  return 

# get_data_of_pixel_value(gray_img_origin_RL1_nonzero)
# get_data_of_pixel_value(gray_img_origin_RL100_nonzero)
# get_data_of_pixel_value(gray_img_noised_RL1_nonzero)
# get_data_of_pixel_value(gray_img_noised_RL100_nonzero)



# ----------------------
# ----- Matplotlib -----
# ----------------------
# Original image
#ax[2].hist(gray_img_origin_RL1_nonzero.ravel(), bins=1, color='r', alpha=0.5, label="Original image, $L_{\mathrm{R}}=1$")
ax[2].hist(gray_img_origin_RL100_nonzero.ravel(), bins=50, color='r', alpha=0.5, label="Original image, $L_{\mathrm{R}}=100$")

# Noise image
#ax[2].hist(gray_img_noised_RL1_nonzero.ravel(), bins=50, color='r', alpha=0.5, label="Noise image, $L_{\mathrm{R}}=1$")
ax[2].hist(gray_img_noised_RL100_nonzero.ravel(), bins=50, color='b', alpha=0.5, label="Noise image, $L_{\mathrm{R}}=100$")

# Text
#props = dict(boxstyle='round', facecolor='red', alpha=0.5)
#ax[2].text(0.82, 0.88, "mean:255", transform=ax[2].transAxes, fontsize=14, color='r')
ax[2].text(0.2, 0.25, "mean:41", transform=ax[2].transAxes, fontsize=14, color='r')
# ax[2].text(0.55, 0.4, "mean:165", transform=ax[2].transAxes, fontsize=14, color='r')
ax[2].text(0.08, 0.25, "mean:40", transform=ax[2].transAxes, fontsize=14, color='b')

# ----- diff image data -----
# plt.plot(diff_hist_origin,  label='Diff b/w "Origin(RL=1)" and "Noised(RL=1)"')
# plt.plot(diff_hist_RL100,   label='Diff b/w "Origin(RL=100)" and "Noised(RL=100)"')
# ax[2].hist(diff_RL1.ravel(), bins=50, color='red', alpha=0.5)
# ax[2].hist(diff_RL100.ravel(), bins=50, color='red', alpha=0.5)

ax[2].set_title("Comparative histogram", fontsize=12)
#ax[2].set_title("Histogram of Pixel Value Difference", fontsize=12)
ax[2].set_xlabel("Pixel value", fontsize=12)
ax[2].set_ylabel("Number of pixels", fontsize=12)
ax[2].set_xlim([-10, 266])
ax[2].set_ylim([0, 50000])
#plt.grid()
ax[2].legend(fontsize=12)

fig.show()
plt.show()

