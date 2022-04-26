

% ----------------------
% 2022-1-7
% WX实现
% 能够一次性测试多个同一路径下的数据集
% BIQE
% "Lin Zhang, Lei Zhang, and A.C. Bovik, A feature-enriched completely blind image quality evaluator" TIP
% ----------------------

function test_wx()
    clc;close all;clear all;addpath(genpath('./'));     % addpath(genpath('./'))：将当前文件夹下的所有文件夹都包括进调用函数的目录
    %% 路径设置
    methon = 'INetv2313 0';
%     ll_list = ["NASA"; "MEF";"LIME";"DICM";"VV";"LOL";];
%     ll_list = ["NPE9"];
%     ll_list = ["MEF";"LIME";"DICM";"VV";"LOL"];
    ll_list = ["NPE9"];
%     ll_list = ["TID2013"; "MEF";"LIME";];
%     LLBasicPath = strcat('G:\Code\Hailstone\logs\ZS_v2_0\test_ZS_v2_0_ExDark_all_256_spa_color_exp_tv\out\LOL\',methon);
%     LLBasicPath = 'G:\Code\Comparative-Experiment\compare\real_imgs\DL-based\';
%     LLBasicPath = 'G:\Code\Jaguar\logs\INet_v231_0\test_INet_v231_0_Syn5_256_l2_per\out\LL_all2';
    LLBasicPath = 'G:\Code\Jaguar\logs\INet_v2313_0\test_INet_v2313_0_Syn5_256_l2_per\out\LL_all2';
    for i_ll= 1:length(ll_list)
        
        llTestset = ll_list(i_ll);
        disp([llTestset])
        % excel，存储参数值
        excelName = strcat('BIQE_', methon, '_', llTestset, '.xls');
        outPath = strcat('G:\Code\Comparative-Experiment\code_comparative_experiment\quality_assessment_metrics\summary\', methon);
        mkdir(outPath);
        excelPath = strcat(outPath, '\', excelName);
        % 低照度增强后的图像 路径、数量
%         LLPath = strcat(LLBasicPath ,methon, '\', llTestset, "\" );
        LLPath = strcat(LLBasicPath ,  "\",llTestset, "\" );
        LLDir = dir(strcat(LLPath,'*.*'));
        lenLL = length(LLDir);
        if lenLL == 0
            disp(['dataset is null.'])
            break;
        end

        score = zeros(lenLL,1);
        name = string(zeros(lenLL,1));
        disp(['start']) 

        %% 计算 BIQE
        for index=3 : lenLL

            % 读取增强后图像
            llName = LLDir(index).name;
            filename = strcat(LLPath, llName);
%             filename = [LLPath llName];         
%             LL = (im2double(imread(filename)));
            LL = imread(filename);


            % 计算 BIQE
            templateModel = load('templatemodel.mat');
            templateModel = templateModel.templateModel;
            mu_prisparam = templateModel{1};
            cov_prisparam = templateModel{2};
            meanOfSampleData = templateModel{3};
            principleVectors = templateModel{4};

            qualityscore = computequality(LL,mu_prisparam,cov_prisparam,principleVectors,meanOfSampleData);

            % 存储并显示BRISQUE等信息
            score(index-2) = qualityscore;  
            name(index-2) = llName;
            disp(['-----------------------'])
            disp([num2str(index-2)])
            disp (['image :' llName])
            str = ['BIQE : ' num2str(qualityscore)];
            disp(str)
        end
       %% 将数据存储到excel
        state_name = xlswrite(excelPath,name, '1', 'A');
        state_BRISQUE = xlswrite(excelPath,score, '1', 'B');

        if state_BRISQUE == 1 && state_name == 1
            disp(['*********************'])
            disp(['all data has saved.'])
        end
       
    end

    
    
    
    
    
