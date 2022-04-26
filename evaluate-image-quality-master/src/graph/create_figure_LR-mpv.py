#
# リピートレベルと平均輝度値の関係を表すグラフを作成するプログラム
#

import numpy as np
import pandas as pd

import matplotlib.pyplot as plt
plt.style.use('bmh')
plt.rcParams["mathtext.fontset"] = "cm"
plt.rcParams["mathtext.rm"] = "Times New Roman"
plt.rcParams["font.size"] = 14
plt.figure( figsize=(8, 6) )

# Check arguments
import sys
args = sys.argv
if len(args) != 3:
    print("\nUSAGE : $ python {} [original_avg_pixel_value.cav] [noise_avg_pixel_value.csv]\n".format(args[0]))
    sys.exit()

# Read csv file
df_original = pd.read_csv( args[1], header=None )
df_noise    = pd.read_csv(args[2] , header=None )

original    = df_original.values
noise       = df_noise.values

# 0, 10, 100, 200
index = [0, 2, 11, 13]

LR_original  = original[:16,0]
apv_original = original[:16,1]
# LR_original  = original[:21,0]
# apv_original = original[:21,1]
# LR_original  = original[:11,0]
# apv_original = original[:11,1]

LR_noise    = noise[:16,0]
apv_noise   = noise[:16,1]
# LR_noise    = noise[:21,0]
# apv_noise   = noise[:21,1]
# LR_noise    = noise[:11,0]
# apv_noise   = noise[:11,1]

# Calc diff b/w Original Image and Noise Image
# diff = api_original - api_noised
# diff_api = np.abs(diff);
# print(diff_api)

# Figure
plt.rcParams["mathtext.fontset"] = "stix"
plt.rcParams["mathtext.rm"] = "Times New Roman"
plt.rcParams["font.size"] = 12

plt.scatter(LR_original, apv_original, color='blue', label="Ground truth")
plt.scatter(LR_noise, apv_noise, color='red', label=r"Gaussian noise, $σ^2=1.0 \times 10^{-5}$")

# error bar
# plt.errorbar(RL_original, api_original, yerr=std_original, fmt='ro', ecolor='blue')
# plt.errorbar(RL_noised, api_noised, yerr=std_noised, fmt='ro', ecolor='red')

# diff
# plt.plot(RL_original, diff_api, color='black')
# plt.scatter(RL_original, diff_api, color='black')
# plt.text(5, 90, "91", fontsize=12, color='black')
# plt.text(14, 20, "18", fontsize=12, color='black')
# plt.text(104, 4, "2", fontsize=12, color='black')
# plt.ylim([-5, 100])

plt.xlabel('$L$', fontsize=14)
plt.ylabel('Average pixel value', fontsize=14)
# plt.ylabel('Difference of mean pixel value', fontsize=12) # Diff

# draw circle
# plt.scatter(RL_original[2], api_original[2], facecolor='none', s=200, edgecolor='black')
# plt.scatter(RL_noised[2], api_noised[2], facecolor='none', s=200, edgecolor='black')
# plt.scatter(RL_original[11], api_original[11], facecolor='none', s=200, edgecolor='black')
# plt.scatter(RL_noised[11], api_noised[11], facecolor='none', s=200, edgecolor='black')

# Text
# plt.text(-10, 240, "255", fontsize=12, color='b')
# plt.text(-10, 150, "164", fontsize=12, color='r')
# plt.text(15, 192-1, "192", fontsize=12, color='b')
# plt.text(15, 174-1, "174", fontsize=12, color='r')
# plt.text(104, 45, "41", fontsize=12, color='b')
# plt.text(104, 25, "39", fontsize=12, color='r')

plt.xticks([1, 50, 100, 150])
# plt.xticks([1, 50, 100, 150, 200])
# plt.xticks([1, 50, 100])
plt.yticks([0, 50, 100, 150, 200, 250])

plt.grid()
plt.legend(fontsize=14)

plt.show()