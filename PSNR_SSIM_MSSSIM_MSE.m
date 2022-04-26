

% ----------------------
% 20201013
% WX实现
% 一次性测试给定的方法、给定的测试集
% ----------------------

function test_wx()
    clc;close all;clear all;addpath(genpath('./'));     % addpath(genpath('./'))：将当前文件夹下的所有文件夹都包括进调用函数的目录
    addpath('./ms_ssim');
    %% 路径设置
    method_list = ["EnlightenGAN"];
    is_resize = 0;
    ll_list = ["NASA"];
    high_list = ["NASA-high"];
%     LLBasicPath = 'F:\Area 51\9.winter_is_here\storm\compare\ACE-VAE';
%     LLBasicPath = 'F:\Area 51\9.winter_is_here\code_comparative_experiment\LLEnhance-tradition-models\LLEnhance\summary';
    LLBasicPath = 'F:\Area 51\9.winter_is_here\storm\compare\real_imgs\DL-based';
    highBasicPath = 'H:\3.CV_dataset\LLTest_Set';
    
    for i_m = 1:length(method_list)
        
        methon = method_list(i_m); % RetinexNet KinD
        for i_ll= 1:length(ll_list)
        
            llTestset = ll_list(i_ll);
            highTestset = high_list(i_ll);
            disp([llTestset])
            % excel，存储参数值
            excelName = strcat('PSNR-SSIM-MSSSIM-MSE_', methon, 'org_full_', llTestset, '.xlsx');
            outPath = strcat('F:\Area 51\9.winter_is_here\code_comparative_experiment\quality_assessment_metrics\summary\', methon); mkdir(outPath);
            excelPath = strcat(outPath, '\', excelName);
            % 低照度增强后的图像 路径、数量
    %         LLPath = strcat(LLBasicPath ,methon, '\', llTestset, "\" );
            LLPath = strcat(LLBasicPath ,  "\",methon, "\",llTestset, "\" );
            highPath = strcat(highBasicPath, "\", highTestset, "\");
            LLDir = dir(strcat(LLPath, '*.*'));
            lenLL = length(LLDir);
            if lenLL == 0
                disp([strcat('dataset:',llTestset, ' is null.')])
                continue;
            end

            PSNR = string(zeros(lenLL-1,1));    PSNR(1) = "PSNR";
            SSIM = string(zeros(lenLL-1,1));    SSIM(1) = "SSIM";
            MSSSIM = string(zeros(lenLL-1,1));  MSSSIM(1) = "MS-SSIM";
            MSE = string(zeros(lenLL-1,1));     MSE(1) = "MSE";
            name = string(zeros(lenLL-1,1));
            disp(['start']) 

            %% 计算 PSNR
            for index=3 : lenLL

                % 读取增强后图像
                llName = LLDir(index).name;
                if contains(llName, "_kindle")
                    tp0 = strrep(llName, "_kindle", "");
                    tp = split(tp0,'.');
                    highName = strcat(tp(1), '-rtx00.jpg');
                else
%                     highName = llName;
                    tp = split(llName,'.');
                    highName = strcat(tp(1), '-rtx00.jpg');
                end                
                LLFullPath = strcat(LLPath, llName);
                highFullPath = strcat(highPath, highName);
    %             LLFullPath = [LLPath llName];         
                enhanced = (im2double(imread(LLFullPath)));
                high = (im2double(imread(highFullPath)));
                if is_resize == 1
                    high = imresize(high,[512,512]);
                end
               

                % 计算
                psnrVal = psnr(enhanced, high);        
                ssimVal = ssim(enhanced, high);    
                msssimVal = msssim_wx(rgb2gray(enhanced), rgb2gray(high)); 
                mseVal = immse(enhanced, high);        
                

                % 存储并显示PSNR等信息
                PSNR(index-1) = psnrVal;  
                SSIM(index-1) = ssimVal;  
                MSSSIM(index-1) = msssimVal;  
                MSE(index-1) = mseVal;  
                name(index-1) = llName;
                disp(['-----------------------'])
                disp([strcat('methon : ', methon)])
                disp([strcat('testset : ', llTestset)])
                disp(['index : ' num2str(index-2)])
                disp (['image :' llName])
                str = ['PSNR : ' num2str(psnrVal)];
                str1 = ['SSIM : ' num2str(ssimVal)];
                str2 = ['MS-SSIM : ' num2str(msssimVal)];
                str3 = ['MSE : ' num2str(mseVal)];
                disp(str)
                disp(str1)
                disp(str2)
                disp(str3)
            end
           %% 将数据存储到excel
            state_name = xlswrite(excelPath,name, '1', 'A');
            state_PSNR = xlswrite(excelPath,PSNR, '1', 'B');
            xlswrite(excelPath,SSIM, '1', 'C');
            xlswrite(excelPath,MSSSIM, '1', 'D');
            xlswrite(excelPath,MSE, '1', 'E');

            if state_PSNR == 1 && state_name == 1
                disp(['*********************'])
                disp(['all data has saved.'])
            end
        end
       
    end

end
    
    
    
    
