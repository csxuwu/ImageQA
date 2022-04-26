

% ----------------------
% 20201013
% WXʵ��
% �ܹ�һ���Բ��Զ��ͬһ·���µ����ݼ�
% äͼ��ռ�������������BRISQUE�������������÷���أ����ҿ��Բ������г���ʧ�棨����ѹ��α��ģ������������ͼ��������
% A. Mittal, A. K. Moorthy, and A. C. Bovik. No-Reference Image Quality Assessment in the Spatial Domain. IEEE Trans. Image Process.,21(12):4695�C4708, Dec. 2012
% ----------------------

function test_wx()
    clc;close all;clear all;addpath(genpath('./'));     % addpath(genpath('./'))������ǰ�ļ����µ������ļ��ж����������ú�����Ŀ¼
    %% ·������
    methon = 'ACMMM_h2_base_trans_cont_0';
%    methon_list = ["ACMMM_h2_0";"ACMMM_h2_base_trans_cont_0"]; % "ACMMM_h2_0";
     %ll_list = ["TID2013"; "MEF";"DICM";"LOL"];
    ll_list = ["TID2013"; "NASA"; "MEF";"LIME";"DICM";"NPE";"LOL"];
%     LLBasicPath = strcat('G:\Code\Hailstone\logs\ZS_v2_0\test_ZS_v2_0_ExDark_all_256_spa_color_exp_tv\out\LOL\',methon);
    %LLBasicPath = 'G:\Code\Comparative-Experiment\code_comparative_experiment\LLEnhance-tradition-models\LLEnhance\summary\JED\';
     LLBasicPath = 'G:\Code\Comparative-Experiment\compare\real_imgs\DL-based\';
    for i_ll= 1:length(ll_list)
        
        llTestset = ll_list(i_ll);
        disp([llTestset])
        % excel���洢����ֵ
        excelName = strcat('BRISQUE_', methon, '_', llTestset, '.xls');
        outPath = strcat('G:\Code\Comparative-Experiment\code_comparative_experiment\quality_assessment_metrics\summary\', methon);
        mkdir(outPath);
        excelPath = strcat(outPath, '\', excelName);
        % ���ն���ǿ���ͼ�� ·��������
        LLPath = strcat(LLBasicPath ,methon, '\', llTestset, "\" );
%         LLPath = strcat(LLBasicPath ,  "\",llTestset, "\" );
        LLDir = dir(strcat(LLPath,'*.*'));
        lenLL = length(LLDir);
        if lenLL == 0
            disp(['dataset is null.'])
            break;
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
            qualityscore = brisquescore(LL);

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

    
    
    
    
    
