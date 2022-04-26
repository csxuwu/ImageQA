

% ----------------------
% 20201013
% WX实现
% 一次性测试给定的方法、给定的测试集
% ----------------------

function test_wx()
    clc;close all;clear all;addpath(genpath('./'));     % addpath(genpath('./'))：将当前文件夹下的所有文件夹都包括进调用函数的目录
    %% 路径设置
    method_list = ["INetv231_0_epoch12"];
%     ll_list = ["MEF"; "LIME"; "DICM"; "NPE"; "VV"; "ExDark120";];
    ll_list = ["MEF12", "LIME12"];
    LLBasicPath = 'G:\Code\Jaguar\logs\INet_v231_0\test_INet_v231_0_Syn5_256_l2_per\out\LL_all2';

%     ll_list = ["MEF";"LIME";"NPE";"DICM";"VV";"ExDark120"];
%     method_list = ["RetinexNet";"KinDt";"Zero"];
%     method_list = ["Dong";"JED";"Ying_2017_ICCV";"Ying_2017_CAIP";];
%     LLBasicPath = 'F:\Area 51\9.winter_is_here\storm\compare\ACE-VAE\acevae3_1_0号实验';
%     LLBasicPath = 'F:\Area 51\9.winter_is_here\storm\compare\真实图\基于深度学习方法\KinD-LLTest';
%     LLBasicPath = 'F:\Area 51\9.winter_is_here\storm\compare\真实图\基于深度学习方法\RetinexNet-LLTest';
%     LLBasicPath = 'F:\Area 51\9.winter_is_here\storm\compare\真实图\传统方法\revise_compare';
%     LLBasicPath = 'F:\Area 51\9.winter_is_here\storm\compare\真实图\基于深度学习方法';
%     LLBasicPath = 'F:\Area 51\9.winter_is_here\storm\compare\ACE-VAE';
    
    for i_m = 1:length(method_list)
        
        methon = method_list(i_m); % RetinexNet KinD
        for i_ll= 1:length(ll_list)
        
            llTestset = ll_list(i_ll);
            disp([llTestset])
            % excel，存储参数值
            excelName = strcat('PIQE_', methon, '_', llTestset, '.xls');
            outPath = strcat('G:\Code\Comparative-Experiment\code_comparative_experiment\quality_assessment_metrics\summary\', methon); mkdir(outPath);
            excelPath = strcat(outPath, '\', excelName);
            % 低照度增强后的图像 路径、数量
    %         LLPath = strcat(LLBasicPath ,methon, '\', llTestset, "\" );
%             LLPath = strcat(LLBasicPath ,  "\",methon, "\",llTestset, "\" );
            LLPath = strcat(LLBasicPath ,  "\",llTestset, "\" );
            LLDir = dir(strcat(LLPath, '*.*'));
            lenLL = length(LLDir);
            if lenLL == 0
                disp([strcat('dataset:',llTestset, ' is null.')])
                continue;
            end

            brisque = zeros(lenLL,1);
            name = string(zeros(lenLL,1));
            disp(['start']) 

            %% 计算 BRISQUE
            for index=3 : lenLL

                % 读取增强后图像
                llName = LLDir(index).name;
                filename = strcat(LLPath, llName);
    %             filename = [LLPath llName];         
                LL = (im2double(imread(filename)));

                % 计算
                qualityscore = piqe(LL);

                % 存储并显示BRISQUE等信息
                brisque(index-2) = qualityscore;  
                name(index-2) = llName;
                disp(['-----------------------'])
                disp([strcat('methon : ', methon)])
                disp([strcat('testset : ', llTestset)])
                disp(['index : ' num2str(index-2)])
                disp (['image :' llName])
                str = ['PIQE : ' num2str(qualityscore)];
                disp(str)
            end
           %% 将数据存储到excel
            state_name = xlswrite(excelPath,name, '1', 'A');
            state_BRISQUE = xlswrite(excelPath,brisque, '1', 'B');

            if state_BRISQUE == 1 && state_name == 1
                disp(['*********************'])
                disp(['all data has saved.'])
            end
        end
       
    end

end
    
    
    
    
