

% ----------------------
% 20201013
% WX实现
% 盲图像空间质量评估器（BRISQUE）与主观质量得分相关，并且可以测量具有常见失真（例如压缩伪像，模糊和噪声）的图像质量。
% A. Mittal, A. K. Moorthy, and A. C. Bovik. No-Reference Image Quality Assessment in the Spatial Domain. IEEE Trans. Image Process.,21(12):4695–4708, Dec. 2012
% ----------------------

function test_wx()
    clc;close all;clear all;addpath(genpath('./'));     % addpath(genpath('./'))：将当前文件夹下的所有文件夹都包括进调用函数的目录
    %% 路径设置
    methon = 'Dong';
    llTestset = 'DICM';
    % excel，存储参数值
    excelName = ['BRISQUE_' methon '_' llTestset  '.xls'];
    outPath = ['F:\Area 51\9.winter_is_here\code_comparative_experiment\quality_assessment_metrics\summary\' methon]; mkdir(outPath);
    excelPath = [outPath '\' excelName]; 
    % 低照度增强后的图像 路径、数量
    LLPath =  ['F:\Area 51\9.winter_is_here\code_comparative_experiment\LLEnhance-tradition-models\LLEnhance\summary\' methon '\' llTestset '\'];   
    LLDir = dir([LLPath '*.*']);
    lenLL = length(LLDir);
    
    brisque = zeros(lenLL,1);
    name = string(zeros(lenLL,1));
    disp(['start']) 
    
    %% 计算 BRISQUE
    for index=3 : lenLL
        
        % 读取增强后图像
        llName = LLDir(index).name;
        filename = [LLPath llName];         
        LL = (im2double(imread(filename)));
        
        % 计算BRISQUE
        qualityscore = brisquescore(LL);
        
        % 存储并显示BRISQUE等信息
        brisque(index-2) = qualityscore;  
        name(index-2) = llName;
        disp(['-----------------------'])
        disp([num2str(index-2)])
        disp (['image :' llName])
        str = ['BRISQUE : ' num2str(qualityscore)];
        disp(str)
    end
    %% 将数据存储到excel
    state_name = xlswrite(excelPath,name, '1', 'A');
    state_BRISQUE = xlswrite(excelPath,brisque, '1', 'B');
    
    if state_BRISQUE == 1 && state_name == 1
        disp(['*********************'])
        disp(['all data has saved.'])
    end
    
    
    
    
    