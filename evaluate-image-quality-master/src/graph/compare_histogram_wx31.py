#
# 2枚の画像のヒストグラムを作成し，比較するプログラム
# 比较两张图的直方图
# https://github.com/tom-uchida/evaluate-image-quality
#

import os
import cv2, matplotlib
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.pyplot import savefig
plt.style.use('seaborn-white')

from matplotlib import cycler
colors = cycler('color', ['#EE6666', '#3388BB', '#9988DD', '#EECC55', '#88BB44', '#FFBBBB'])
# plt.rc('axes', facecolor='w', edgecolor='None', axisbelow=True, grid=False, prop_cycle=colors)
plt.rc('grid', color='grey', linestyle='solid')
# plt.rc('patch', edgecolor='#E6E6E6')
# plt.rc('lines', linewidth=2)

plt.rcParams["mathtext.fontset"] = "stix"
plt.rcParams["mathtext.rm"] = "Times New Roman"


# ------------------------------
# ----- Placement settings -----
# ------------------------------
fig, ax = plt.subplots(2, figsize=(9, 3.5)) # figsize(width, height)
# fig.subplots_adjust(hspace=0.4, wspace=0.4) # interval
# ax[0] = plt.subplot2grid((2,2), (0,0))
# ax[1] = plt.subplot2grid((2,2), (0,1))
ax[0] = plt.subplot2grid((1,1), (0,0), colspan=2)
# ax[0].plot
# fig, ax = plt.subplots(2, figsize=(9, 4)) # figsize(width, height)
# # fig.subplots_adjust(hspace=0.4, wspace=0.4) # interval
# # ax[0] = plt.subplot2grid((2,2), (0,0))
# # ax[1] = plt.subplot2grid((2,2), (0,1))
# ax[0] = plt.subplot2grid((1,1), (0,0), colspan=2)

# ----------------------------
# ----- Read input image -----
# ----------------------------
def read_img(_img_name):
    # read input image
    img = cv2.imread(_img_name)

    # convert color (BGR → RGB)
    img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)

    return img


# ----------------------------
# ----- Show input image -----
# ----------------------------
def show_img(_i, _img, _img_name):
    ax[_i].set_title(_img_name)

    # show image
    ax[_i].imshow(_img)

    return

img_name = 'low_light'

img_low_light = read_img(r'E:\Area 51\paper\olympic\figs\fig1\2.bmp')
# img_enhanced = read_img(r'E:\Area 51\paper\olympic\figs\fig1\2_INet_v2313_l1_misssim_per.jpg')
img_enhanced = read_img(r'E:\Area 51\paper\olympic\figs\fig1\enlightenGAN.bmp')
# img_enhanced = read_img(r'E:\Area 51\paper\olympic\figs\fig1\Zero+.bmp')
# img_enhanced = read_img(r'E:\Area 51\paper\olympic\figs\fig1\2.bmp')

# -------------------------------
# ----- Convert RGB to Gray -----
# -------------------------------
gray_img_low_light = cv2.cvtColor(img_low_light, cv2.COLOR_RGB2GRAY)
gray_img_enhanced = cv2.cvtColor(img_enhanced, cv2.COLOR_RGB2GRAY)

# exclude pixel value == 0
gray_img_low_light_nonzero = gray_img_low_light[gray_img_low_light > 0]
gray_img_enhanced_nonzero = gray_img_enhanced[gray_img_enhanced > 0]


# ----------------------
# ----- Matplotlib -----
# ----------------------
# Original image
ax[0].hist(gray_img_low_light_nonzero.ravel(), bins=50, color='r', alpha=0.5, label="Low-light image")
# Noise image
ax[0].hist(gray_img_enhanced_nonzero.ravel(), bins=50, color='b', alpha=0.5, label=img_name)

# ax[0].set_title("Comparative histogram", fontsize=14)
ax[0].set_xlabel("Pixel value", fontsize=16)
ax[0].set_ylabel("Number of pixels", fontsize=16)
ax[0].set_xlim([0, 255])
# ax[0].set_ylim([0,41000])
ax[0].set_ylim([0,21000])

ax[0].set_yticks([0, 5000, 10000, 15000, 20000])
ax[0].tick_params(labelsize=14)
ax[0].legend(fontsize=14, frameon=True)

ax[0].spines['bottom'].set_linewidth(1)

# fig.show()
plt.grid(axis='x')
# plt.grid()

# ax[0].imshow()
# p1 = r'E:\Area 51\paper\olympic\figs\fig1'
p1 = r'E:\Area 51\paper\olympic\ACMMM2022\figs\fig1 原图\HE_img'
op = p1 + '\\' + img_name + '.jpg'
savefig(op)
plt.show()
