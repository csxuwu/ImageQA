

% ----------------------
% 20201013
% WXʵ��
% һ���Բ��Ը����ķ����������Ĳ��Լ�
% ----------------------

function test_wx()
    clc;close all;clear all;addpath(genpath('./'));     % addpath(genpath('./'))������ǰ�ļ����µ������ļ��ж����������ú�����Ŀ¼
    %% ·������
    method_list = ["INetv231_0_epoch12"];
%     ll_list = ["MEF"; "LIME"; "DICM"; "NPE"; "VV"; "ExDark120";];
    ll_list = ["MEF12", "LIME12"];
    LLBasicPath = 'G:\Code\Jaguar\logs\INet_v231_0\test_INet_v231_0_Syn5_256_l2_per\out\LL_all2';

%     ll_list = ["MEF";"LIME";"NPE";"DICM";"VV";"ExDark120"];
%     method_list = ["RetinexNet";"KinDt";"Zero"];
%     method_list = ["Dong";"JED";"Ying_2017_ICCV";"Ying_2017_CAIP";];
%     LLBasicPath = 'F:\Area 51\9.winter_is_here\storm\compare\ACE-VAE\acevae3_1_0��ʵ��';
%     LLBasicPath = 'F:\Area 51\9.winter_is_here\storm\compare\��ʵͼ\�������ѧϰ����\KinD-LLTest';
%     LLBasicPath = 'F:\Area 51\9.winter_is_here\storm\compare\��ʵͼ\�������ѧϰ����\RetinexNet-LLTest';
%     LLBasicPath = 'F:\Area 51\9.winter_is_here\storm\compare\��ʵͼ\��ͳ����\revise_compare';
%     LLBasicPath = 'F:\Area 51\9.winter_is_here\storm\compare\��ʵͼ\�������ѧϰ����';
%     LLBasicPath = 'F:\Area 51\9.winter_is_here\storm\compare\ACE-VAE';
    
    for i_m = 1:length(method_list)
        
        methon = method_list(i_m); % RetinexNet KinD
        for i_ll= 1:length(ll_list)
        
            llTestset = ll_list(i_ll);
            disp([llTestset])
            % excel���洢����ֵ
            excelName = strcat('PIQE_', methon, '_', llTestset, '.xls');
            outPath = strcat('G:\Code\Comparative-Experiment\code_comparative_experiment\quality_assessment_metrics\summary\', methon); mkdir(outPath);
            excelPath = strcat(outPath, '\', excelName);
            % ���ն���ǿ���ͼ�� ·��������
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

            %% ���� BRISQUE
            for index=3 : lenLL

                % ��ȡ��ǿ��ͼ��
                llName = LLDir(index).name;
                filename = strcat(LLPath, llName);
    %             filename = [LLPath llName];         
                LL = (im2double(imread(filename)));

                % ����
                qualityscore = piqe(LL);

                % �洢����ʾBRISQUE����Ϣ
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
           %% �����ݴ洢��excel
            state_name = xlswrite(excelPath,name, '1', 'A');
            state_BRISQUE = xlswrite(excelPath,brisque, '1', 'B');

            if state_BRISQUE == 1 && state_name == 1
                disp(['*********************'])
                disp(['all data has saved.'])
            end
        end
       
    end

end
    
    
    
    
