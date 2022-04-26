

% ----------------------
% 2022-01-03
% WX实现
% 计算CEIQ
% 一次性测试给定的方法、给定的测试集
% ----------------------



function test_wx()
    addpath('utils', 'data', 'images');
    clc;close all;clear all;addpath(genpath('./'));     % addpath(genpath('./'))：将当前文件夹下的所有文件夹都包括进调用函数的目录
    %% 路径设置
    %ll_list = ["NASA"];
    method_list = ["Zero++-LL-Test"];
    %method_list = ["LLCNN";"KinD";"RetinexNet";"Zero";"EnlightenGAN"];
     ll_list = ["TID2013";];
     
%     LLBasicPath = 'G:\Code\Comparative-Experiment\Comparative-Experiment\wuxu-code-Zero-DCE-master\Zero-DCE\Zero-DCE_code\data\org_model\Zero++-LL-Test'    % zero++
%     LLBasicPath = 'G:\Code\Comparative-Experiment\Comparative-Experiment\KinD_wx\test_results\KinD-LLTest';
%     LLBasicPath = 'G:\Code\Comparative-Experiment\Comparative-Experiment\RetinexNet\test_results\RetinexNet-LLTest';
%     LLBasicPath = 'G:\Code\Comparative-Experiment\code_comparative_experiment\LLEnhance-tradition-models\LLEnhance\summary\JED';
%     LLBasicPath = 'G:\Code\Comparative-Experiment\code_comparative_experiment\LLEnhance-tradition-models\LLEnhance\summary\JED';
    LLBasicPath = 'G:\Code\Comparative-Experiment\compare\real_imgs\DL-based\';
    
    for i_m = 1:length(method_list)
        
        methon = method_list(i_m); % RetinexNet KinD
        for i_ll= 1:length(ll_list)
        
            llTestset = ll_list(i_ll);
            disp([llTestset])
            % excel，存储参数值
            excelName = strcat('CEIQ_', methon, '_', llTestset, '.xls');
            outPath = strcat('G:\Code\Comparative-Experiment\code_comparative_experiment\quality_assessment_metrics\summary\', methon);mkdir(outPath);
            
            excelPath = strcat(outPath, '\', excelName);
            % 低照度增强后的图像 路径、数量
             LLPath = strcat(LLBasicPath ,  "\",methon, "\",llTestset, "\" );
            LLDir = dir(strcat(LLPath, '*.*'));
            lenLL = length(LLDir);
            if lenLL == 0
                disp([strcat('dataset:',llTestset, ' is null.')])
                continue;
            end

            score = zeros(lenLL,1);  % 存储图像质量评分
            name = string(zeros(lenLL,1));
            disp(['start']) 

            %% 计算 CEIQ
            for index=3 : lenLL

                % 读取增强后图像
                llName = LLDir(index).name;
                filename = strcat(LLPath, llName);
    %             filename = [LLPath llName];         
                LL = (im2double(imread(filename)));

                % 计算CEIQ

                qualityscore = CEIQ(LL);

                % 存储并显示BRISQUE等信息
                score(index-2) = qualityscore;  
                name(index-2) = llName;
                disp(['-----------------------'])
                disp([strcat('methon : ', methon)])
                disp([strcat('testset : ', llTestset)])
                disp(['index : ' num2str(index-2)])
                disp (['image :' llName])
                str = ['CEIQ : ' num2str(qualityscore)];
                disp(str)
            end
           %% 将数据存储到excel
            state_name = xlswrite(excelPath,name, '1', 'A');
            state_BRISQUE = xlswrite(excelPath,score, '1', 'B');

            if state_BRISQUE == 1 && state_name == 1
                disp(['*********************'])
                disp(['all data has saved: ' excelPath])
            end
        end
       
    end

end
    
    
    
    
