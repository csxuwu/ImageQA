import cv2, matplotlib
import numpy as np
import matplotlib.pyplot as plt


# 比较两张图pixel value不同的地方，用直方图表示

plt.style.use('seaborn-white')

# ------------------------------
# ----- Placement settings -----
# ------------------------------
fig, ax = plt.subplots(3, figsize=(8, 9)) # figsize(width, height)
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

img_origin        = read_img(r'G:\Dataset\LL_Set\LIME\2.bmp')
img_origin_RL10   = read_img(r'G:\Dataset\LL_Set\LIME\2.bmp')
img_origin_RL100  = read_img(r'G:\Dataset\LL_Set\LIME\2.bmp')
img_noised        = read_img(r'G:\Code\Comparative-Experiment\code_comparative_experiment\quality_assessment_metrics\evaluate-image-quality-master\src\images\2_INet_v23_00.jpg')
img_noised_RL10   = read_img(r'G:\Code\Comparative-Experiment\code_comparative_experiment\quality_assessment_metrics\evaluate-image-quality-master\src\images\k_2.bmp')
img_noised_RL100  = read_img(r'G:\Code\Comparative-Experiment\code_comparative_experiment\quality_assessment_metrics\evaluate-image-quality-master\src\images\z2.bmp')
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

#show_img(0, img_origin,       "Original Image (RL=1)")
#show_img(1, img_origin_RL10,  "Original Image (RL=10)")
show_img(0, img_origin_RL100, "Original Image (RL=100)")
#show_img(1, img_noised,       "Noised Image (RL=1)")
#show_img(1, img_noised_RL10,  "Noised Image (RL=10)")
show_img(1, img_noised_RL100, "Noised Image (RL=100)")



# -------------------------------
# ----- Convert RGB to Gray -----
# -------------------------------
gray_img_origin       = cv2.cvtColor(img_origin,        cv2.COLOR_RGB2GRAY)
gray_img_origin_RL10  = cv2.cvtColor(img_origin_RL10,   cv2.COLOR_RGB2GRAY)
gray_img_origin_RL100 = cv2.cvtColor(img_origin_RL100,  cv2.COLOR_RGB2GRAY)
gray_img_noised       = cv2.cvtColor(img_noised,        cv2.COLOR_RGB2GRAY)
gray_img_noised_RL10  = cv2.cvtColor(img_noised_RL10,   cv2.COLOR_RGB2GRAY)
gray_img_noised_RL100 = cv2.cvtColor(img_noised_RL100,  cv2.COLOR_RGB2GRAY)
# print("gray_img_origin : ", gray_img_origin.shape)  
# print("gray_img_noised : ", gray_img_noised.shape)
# print("\n")



# --------------------------------------------------------------------
# ----- Calc difference of brightness values of two input images -----
# --------------------------------------------------------------------
bigger      = np.maximum(gray_img_origin, gray_img_noised)
smaller     = np.minimum(gray_img_origin, gray_img_noised)

bigger_RL10   = np.maximum(gray_img_origin_RL10, gray_img_noised_RL10)
smaller_RL10  = np.minimum(gray_img_origin_RL10, gray_img_noised_RL10)

bigger_RL100  = np.maximum(gray_img_origin_RL100, gray_img_noised_RL100)
smaller_RL100 = np.minimum(gray_img_origin_RL100, gray_img_noised_RL100)

diff_RL1      = bigger        - smaller
diff_RL10     = bigger_RL10   - smaller_RL10
diff_RL100    = bigger_RL100  - smaller_RL100



# ---------------------
# ----- Histogram -----
# ---------------------
# store values of "histogram and bin boundary" in two variables(hist, bins)
#hist_origin,         bins_origin       = np.histogram(gray_img_origin.ravel(),       256, [0, 256])
# hist_origin_RL10,   bins_origin_RL10  = np.histogram(gray_img_origin_RL10.ravel(),  256, [0, 256])
# hist_origin_RL100,  bins_origin_RL100 = np.histogram(gray_img_origin_RL100.ravel(), 256, [0, 256])

# #hist_noised,         bins_noised       = np.histogram(gray_img_noised.ravel(),       256, [0, 256])
# hist_noised,        bins_noised       = np.histogram(gray_img_noised.ravel())
# hist_noised_RL10,   bins_noised_RL10  = np.histogram(gray_img_noised_RL10.ravel(),  256, [0, 256])
# hist_noised_RL100,  bins_noised_RL100 = np.histogram(gray_img_noised_RL100.ravel(), 256, [0, 256])

# diff_hist_origin,   diff_bins_origin  = np.histogram(diff_RL1.ravel(),    256, [0, 256])
# diff_hist_RL10,     diff_bins_RL10    = np.histogram(diff_RL10.ravel(),   256, [0, 256])
# diff_hist_RL100,    diff_bins_RL100   = np.histogram(diff_RL100.ravel(),  256, [0, 256])



# -----------------------------------------------
# ----- Get statistical data of pixel value -----
# -----------------------------------------------
def get_data_of_pixel_value(_pixel_value):
  print("===== Statistical Data of Pixel Values =====")
  print("> 最大値:", np.max(_pixel_value))
  print("> 最小値:", np.min(_pixel_value))
  print("> 平均値:", np.mean(_pixel_value))
  print("> 中央値:", np.median(_pixel_value))
  print("\n")
  return 

# get_data_of_pixel_value(gray_img_origin)
# get_data_of_pixel_value(gray_img_origin_RL10)
# get_data_of_pixel_value(gray_img_origin_RL100)
# get_data_of_pixel_value(gray_img_noised)
# get_data_of_pixel_value(gray_img_noised_RL10)
# get_data_of_pixel_value(gray_img_noised_RL100)

# Normalize brightness of image
#img = (img - np.mean(img))/np.std(img)*16+64



# ------------------------
# ----- Matplotlib -----
# ------------------------

# ----- origin data -----
#ax[2].plot(hist_origin, label="Original(RepeatLevel=1)", color='red')
#ax[2].plot(hist_origin_RL10, label="Original(RepeatLevel=10)")
#ax[2].plot(hist_origin_RL100, label="Original(RepeatLevel=100)")
#ax[2].hist(gray_img_origin.ravel(), bins=50, color='red', alpha=0.5, label="Original Image (RL=1)")
#ax[2].hist(gray_img_origin_RL10.ravel(), bins=50, color='red', alpha=0.5, label="Original Image (RL=10)")
#ax[2].hist(gray_img_origin_RL100.ravel(), bins=50, color='blue', alpha=0.5, label="Original Image (RL=100)")

# ----- noised data -----
#ax[2].plot(hist_noised, label="Noised(RepeatLevel=1)", color='blue')
#ax[2].plot(hist_noised_RL10, label="Noised(RepeatLevel=10)")
#ax[2].plot(hist_noised_RL100, label="Noised(RepeatLevel=100)")
#ax[2].hist(gray_img_noised.ravel(), bins=50, color='red', alpha=0.5, label="Noised Image (RL=1)")
#ax[2].hist(gray_img_noised_RL10.ravel(), bins=50, color='blue', alpha=0.5, label="Noised Image (RL=10)")
#ax[2].hist(gray_img_noised_RL100.ravel(), bins=50, color='blue', alpha=0.5, label="Noised Image (RL=100)")

# ----- diff data -----
# plt.plot(diff_hist_origin,  label='Diff b/w "Origin(RL=1)" and "Noised(RL=1)"')
# plt.plot(diff_hist_RL10,    label='Diff b/w "Origin(RL=10)" and "Noised(RL=10)"')
# plt.plot(diff_hist_RL100,   label='Diff b/w "Origin(RL=100)" and "Noised(RL=100)"')
#ax[2].hist(diff_RL1.ravel(),   bins=50)
ax[2].hist(diff_RL100.ravel(), bins=50)

ax[2].set_title("Histogram of Pixel Value Difference", fontsize=16)
ax[2].set_xlabel("pixel value", fontsize=12)    # 画素値 
ax[2].set_ylabel("Number of pixels", fontsize=12) # 画素値の度数
ax[2].set_xlim([-10, 266])
#plt.ylim([0, 2500])
#plt.grid()
#ax[2].legend(fontsize=16)

fig.show()
plt.show()

