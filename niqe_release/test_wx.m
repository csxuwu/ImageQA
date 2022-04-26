

% ----------------------
% 20201013
% WXʵ��
% �ܹ�һ���Բ��Զ��ͬһ·���µ����ݼ�
% ----------------------

function test_wx()
    clc;close all;clear all;addpath(genpath('./'));     % addpath(genpath('./'))������ǰ�ļ����µ������ļ��ж����������ú�����Ŀ¼
    %% ·������
    methon = 'RetinexNet'; % RetinexNet KinD
    ll_list = ["MEF"; "LIME"; "DICM"; "NPE"; "VV"; "ExDark120"];
%     LLBasicPath = 'F:\Area 51\9.winter_is_here\storm\compare\ACE-VAE\acevae3_1_0��ʵ��';
%     LLBasicPath = 'F:\Area 51\9.winter_is_here\storm\compare\��ʵͼ\�������ѧϰ����\KinD-LLTest';
%     LLBasicPath = 'F:\Area 51\9.winter_is_here\storm\compare\��ʵͼ\�������ѧϰ����\RetinexNet-LLTest';
    LLBasicPath = 'F:\Area 51\9.winter_is_here\storm\compare\��ʵͼ\��ͳ����\revise_compare';
    for i_ll= 1:length(ll_list)
        
        llTestset = ll_list(i_ll);
        disp([llTestset])
        % excel���洢����ֵ
        excelName = strcat('NIQE_', methon, '_', llTestset, '.xls');
        outPath = strcat('F:\Area 51\9.winter_is_here\code_comparative_experiment\quality_assessment_metrics\summary\', methon);
        excelPath = strcat(outPath, '\', excelName);
        % ���ն���ǿ���ͼ�� ·��������
%         LLPath = strcat(LLBasicPath ,methon, '\', llTestset, "\" );
        LLPath = strcat(LLBasicPath ,  "\",llTestset, "\" );
        LLDir = dir(strcat(LLPath,'*.*'));
        lenLL = length(LLDir);
        if lenLL == 0
            disp([strcat('dataset:',llTestset, ' is null.')])
            continue;
        end

        brisque = zeros(lenLL,1);
        name = string(zeros(lenLL,1));
        disp(['start']) 

        %% ���� BRISQUE
        for index=3 : lenLL

            % ��ȡ��ǿ��ͼ��
            llName = LLDir(index).name;
            filename = strcat(LLPath, llName);
%             filename = [LLPath llName];         
            LL = (im2double(imread(filename)));

            % ����BRISQUE
            load modelparameters.mat;
 
            blocksizerow    = 96;
            blocksizecol    = 96;
            blockrowoverlap = 0;
            blockcoloverlap = 0;
            qualityscore = computequality(LL,blocksizerow,blocksizecol,blockrowoverlap,blockcoloverlap, ...
    mu_prisparam,cov_prisparam);

            % �洢����ʾBRISQUE����Ϣ
            brisque(index-2) = qualityscore;  
            name(index-2) = llName;
            disp(['-----------------------'])
            disp([num2str(index-2)])
            disp (['image :' llName])
            str = ['BRISQUE : ' num2str(qualityscore)];
            disp(str)
        end
       %% �����ݴ洢��excel
        state_name = xlswrite(excelPath,name, '1', 'A');
        state_BRISQUE = xlswrite(excelPath,brisque, '1', 'B');

        if state_BRISQUE == 1 && state_name == 1
            disp(['*********************'])
            disp(['all data has saved.'])
        end
       
    end

    
    
    
    
    