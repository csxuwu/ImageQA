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
if len(args) != 2:
    print("\nUSAGE   : $ python create_figure_MSE.py [csv_file_path]")
    sys.exit()


# Read csv file
csv = pd.read_csv(args[1], header=None)

# Convert to numpy
LR_MSE = csv.values
# LR  = LR_MSE[0:11,0] # L=1-100
# MSE = LR_MSE[0:11,1] 
LR  = LR_MSE[0:16,0] # L=1-150
MSE = LR_MSE[0:16,1]

# Create figure
c = plt.scatter(LR, MSE, color='black')

plt.xticks([1, 50, 100, 150], fontsize=14)
plt.yticks([0, 5000, 10000, 15000, 20000], fontsize=14)

plt.xlabel('$L$', fontsize=16)
plt.ylabel('MSE', fontsize=16) # Gray scale

plt.show()