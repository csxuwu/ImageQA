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
    print("\nUSAGE: $ python {} [original_mean_pixel_value.csv] [noise_mean_pixel_value.csv]\n".format(args[0]))
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
diff = apv_original - apv_noise
diff_apv = np.abs(diff)
print(diff_apv)

# diff
plt.scatter(LR_original, diff_apv, color='black')
# plt.ylim([-5, 100])

# plt.xticks([1, 10, 100, 150])
plt.xticks([1, 50, 100, 150])
# plt.xticks([1, 50, 100])
plt.yticks([0, 50, 100, 150, 200, 255])
# plt.yticks([0, 50, 100])

plt.xlabel('$L$', fontsize=16)
plt.ylabel('Difference of mean pixel value', fontsize=16) # Diff

plt.show()