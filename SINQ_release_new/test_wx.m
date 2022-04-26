

% ----------------------
% 20201013
% WX实现
% 一次性测试给定的方法、给定的测试集
% ----------------------


clc;   
%% 路径设置
ll_list = ["ExDark"];
%     ll_list = ["MEF";"LIME";"NPE";"DICM";"VV";"ExDark120"];
method_list = ["Dong","JED","LIME","Ying_2017_ICCV"];
% method_list = ["Zero","KinD"];
% LLBasicPath = 'F:\Area 51\9.winter_is_here\storm\compare\ACE-VAE';
% LLBasicPath = 'F:\Area 51\9.winter_is_here\storm\compare\真实图\基于深度学习方法';
LLBasicPath ='F:\Area 51\9.winter_is_here\code_comparative_experiment\LLEnhance-tradition-models\LLEnhance\summary';

for i_m = 1:length(method_list)

    methon = method_list(i_m); % RetinexNet KinD
    for i_ll= 1:length(ll_list)

        llTestset = ll_list(i_ll);
%         disp([llTestset])
        % excel，存储参数值
        excelName = strcat('SINQ_', methon, '_', llTestset, '.xls');
        outPath = strcat('F:\Area 51\9.winter_is_here\code_comparative_experiment\quality_assessment_metrics\summary\', methon); mkdir(outPath);
        excelPath = strcat(outPath, '\', excelName);
        % 低照度增强后的图像 路径、数量
%         LLPath = strcat(LLBasicPath ,methon, '\', llTestset, "\" );
        LLPath = strcat(LLBasicPath ,  "\",methon, "\",llTestset, "\" );
        LLDir = dir(strcat(LLPath, '*.*'));
        lenLL = length(LLDir);
        if lenLL == 0
            disp([strcat('dataset:',llTestset, ' is null.')])
            continue;
        end

        brisque = zeros(lenLL,1);
        name = string(zeros(lenLL,1));
        disp(['start']) 
        load model.mat;
        %% 计算 BRISQUE
        for index=3 : lenLL

            % 读取增强后图像
            llName = LLDir(index).name;
            filename = strcat(LLPath, llName);

            LL = (im2double(imread(filename)));


            qualityscore = computeSINQ(filename);
            % 存储并显示BRISQUE等信息
            brisque(index-2) = qualityscore;  
            name(index-2) = llName;
            disp(['-----------------------'])
            disp([strcat('methon : ', methon)])
            disp([strcat('testset : ', llTestset)])
            disp(['index : ' num2str(index-2)])
            disp (['image :' llName])
            str = ['SINQ : ' num2str(qualityscore)];
            disp(str)
           

            clearvars qualityscore
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



function score = computeSINQ(path)
   
    % Read the example picture
    % img = imread('demo_pic.bmp');
    img = imread(path);
%     imshow(img)
    % call function compute_feature.m to calculate the quality score of the example picture
    score = compute_score(img);
    str = ['SINQ : ' num2str(score)];
    disp(str)
end
    
    
    
    
