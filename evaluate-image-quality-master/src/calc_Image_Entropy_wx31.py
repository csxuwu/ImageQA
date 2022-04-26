import cv2
import sys
import matplotlib.pyplot as plt
import numpy as np
import glob
import os
import pandas as pd


# ----------------------------
# 2022.1.4
# csxuwu@163.com
# 计算多张图像的 entropy
# ----------------------------

def read_img( _img_name ):
    img_BGR = cv2.imread( _img_name )
    img_RGB = cv2.cvtColor( img_BGR, cv2.COLOR_BGR2RGB )

    return img_RGB

def calc_entropy( _histogram, _num_of_pixels ):
    entropy = 0

    for i in range( 256 ):
        # Calc the probability of appearance of pixel value "i"
        p = _histogram[i] / _num_of_pixels

        if p == 0:
            continue
        entropy -= p * np.log2( p )

    return entropy

if __name__ == "__main__":

    method_list = ['INetv2313 0 epoch9 L1_mssim_per']
    # test_set = ['MEF4', 'LIME4', 'MEF6', 'LIME6']
    test_set = ['MEF9']
    # test_set = ['TID9','LIME9','MEF9','NPE9']
    # test_set = ['LIME9']
    # test_set = ['MEF', 'LIME', 'TID2013', 'NPE']

    # basic_path = r'G:\Code\Jaguar\logs\INet_v121_0\test_INet_v121_0_Syn5_256_l2_per\out\LL_all2'
    # basic_path = os.path.join(r'H:\伍旭\storm\compare\real_imgs\DL-based', method)
    # basic_path = r'G:\Code\Comparative-Experiment\code_comparative_experiment\LLEnhance-tradition-models\LLEnhance\summary\JED'
    # basic_path = r'G:\Code\Comparative-Experiment\Comparative-Experiment\EnlightenGAN_wx\test_results'
    # basic_path = r'G:\Code\Comparative-Experiment\Comparative-Experiment\KinD_wx\test_results\KinD-LLTest'
    # basic_path = r'G:\Code\Comparative-Experiment\Comparative-Experiment\RetinexNet\test_results\RetinexNet-LLTest'
    # basic_path = r'G:\Code\Comparative-Experiment\Comparative-Experiment\wuxu-code-Zero-DCE-master\Zero-DCE\Zero-DCE_code\data\org_model\Zero-LL-Test'
    # basic_path = r'G:\Code\Comparative-Experiment\Comparative-Experiment\wuxu-code-Zero-DCE-master\Zero-DCE\Zero-DCE_code\data\org_model\Zero++-LL-Test'
    basic_path = r'G:\Code\Comparative-Experiment\compare\real_imgs\DL-based'
    # basic_path = r'G:\Code\Jaguar\logs\INet_v2313_0\test_INet_v2313_0_Syn5_256_l2_per\out\LL_all2'

    for j in range(0, len(method_list)):
        method = method_list[j]
        out_path = os.path.join(
            r'G:\Code\Comparative-Experiment\code_comparative_experiment\quality_assessment_metrics\summary', method)
        if not os.path.exists(out_path):
            os.makedirs(out_path)
            print('creating :{}'.format(out_path))

        for j in range(0, len(test_set)):
            cur_set = test_set[j]
            path_list = glob.glob(os.path.join(basic_path, method, cur_set, '*.*'))
            # path_list = glob.glob(os.path.join(basic_path, cur_set ,'*.*'))
            result = {'index': [], 'name': [], 'entropy': []}

            for i in range(0, len(path_list)):
                img_name = path_list[i].split('\\')[-1]
                img_RGB = read_img(path_list[i])

                # Convert RGB to Grayscale
                img_Gray = cv2.cvtColor(img_RGB, cv2.COLOR_RGB2GRAY)

                # Get histogram of the input image
                img_hist, img_bins = np.histogram(np.array(img_Gray).flatten(), bins=np.arange(256 + 1))
                # print( img_hist.shape ) (255,)

                # Calculate entropy of the input image
                num_of_pixels = img_RGB.shape[0] * img_RGB.shape[1]
                entropy = calc_entropy(img_hist, num_of_pixels)

                # saving
                result['index'].append(str(i))
                result['name'].append(img_name)
                result['entropy'].append(entropy)

                print('Entropy: {:.2f}'.format(entropy))

            data_frame = pd.DataFrame(data={'index': result['index'],
                                            'name': result['name'],
                                            'entropy': result['entropy']},
                                      index=range(0, len(result['index'])))
            save_path = os.path.join(out_path, 'Entropy_' + method + '_' + cur_set + '.csv')
            data_frame.to_csv(save_path)
            print('Saving', cur_set, '-', method)