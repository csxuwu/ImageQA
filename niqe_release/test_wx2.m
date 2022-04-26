

% ----------------------
% 20201013
% WXʵ��
% һ���Բ��Ը����ķ����������Ĳ��Լ�
% ----------------------

function test_wx()
    clc;close all;clear all;addpath(genpath('./'));     % addpath(genpath('./'))������ǰ�ļ����µ������ļ��ж����������ú�����Ŀ¼
    %% ·������
    %ll_list = ["NASA"];
    %method_list = ["Zero++-LL-Test"]; %Zero++-LL-Test
     method_list = ["ACMMM_h2_0";"ACMMM_h2_base_trans_cont_0"]; % "ACMMM_h2_0";
     %ll_list = ["TID2013"; "MEF";"DICM";"LOL"];
    ll_list = ["TID2013"; "NASA"; "MEF";"LIME";"DICM";"NPE";"LOL"];
%     method_list = ["ACE-VAE-3107-LLtest-epoch5"];
%     method_list = ["Dong";"JED";"Ying_2017_ICCV";"Ying_2017_CAIP";];
%     LLBasicPath = 'F:\Area 51\9.winter_is_here\storm\compare\ACE-VAE';
%     LLBasicPath = 'G:\Code\Comparative-Experiment\Comparative-Experiment\wuxu-code-Zero-DCE-master\Zero-DCE\Zero-DCE_code\data\org_model\Zero-LL-Test\';
    LLBasicPath ='G:\Code\Comparative-Experiment\compare\real_imgs\DL-based';
%     LLBasicPath = 'F:\Area 51\9.winter_is_here\storm\compare\��ʵͼ\�������ѧϰ����\RetinexNet-LLTest';
%     LLBasicPath = 'F:\Area 51\9.winter_is_here\storm\compare\��ʵͼ\��ͳ����\revise_compare';
%     LLBasicPath = 'F:\Area 51\9.winter_is_here\storm\compare\��ʵͼ\�������ѧϰ����';
    
    for i_m = 1:length(method_list)
        
        methon = method_list(i_m); % RetinexNet KinD
        for i_ll= 1:length(ll_list)
        
            llTestset = ll_list(i_ll);
            disp([llTestset])
            % excel���洢����ֵ
            excelName = strcat('NIQE_', methon, '_', llTestset, '.xls');
            outPath = strcat('G:\Code\Comparative-Experiment\code_comparative_experiment\quality_assessment_metrics\summary\', methon);mkdir(outPath);
            
            excelPath = strcat(outPath, '\', excelName);
            % ���ն���ǿ���ͼ�� ·��������
    %         LLPath = strcat(LLBasicPath ,methon, '\', llTestset, "\" );
            LLPath = strcat(LLBasicPath ,  "\",methon, "\",llTestset, "\" );
%              LLPath = strcat(LLBasicPath ,  "\", "\",llTestset, "\" );
            LLDir = dir(strcat(LLPath, '*.*'));
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
                disp([strcat('methon : ', methon)])
                disp([strcat('testset : ', llTestset)])
                disp(['index : ' num2str(index-2)])
                disp (['image :' llName])
                str = ['NIQE : ' num2str(qualityscore)];
                disp(str)
            end
           %% �����ݴ洢��excel
            state_name = xlswrite(excelPath,name, '1', 'A');
            state_BRISQUE = xlswrite(excelPath,brisque, '1', 'B');

            if state_BRISQUE == 1 && state_name == 1
                disp(['*********************'])
                disp(['all data has saved: ' excelPath])
            end
        end
       
    end

end
    
    
    
    
