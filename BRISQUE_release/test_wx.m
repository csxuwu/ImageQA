

% ----------------------
% 20201013
% WXʵ��
% äͼ��ռ�������������BRISQUE�������������÷���أ����ҿ��Բ������г���ʧ�棨����ѹ��α��ģ������������ͼ��������
% A. Mittal, A. K. Moorthy, and A. C. Bovik. No-Reference Image Quality Assessment in the Spatial Domain. IEEE Trans. Image Process.,21(12):4695�C4708, Dec. 2012
% ----------------------

function test_wx()
    clc;close all;clear all;addpath(genpath('./'));     % addpath(genpath('./'))������ǰ�ļ����µ������ļ��ж����������ú�����Ŀ¼
    %% ·������
    methon = 'Dong';
    llTestset = 'DICM';
    % excel���洢����ֵ
    excelName = ['BRISQUE_' methon '_' llTestset  '.xls'];
    outPath = ['F:\Area 51\9.winter_is_here\code_comparative_experiment\quality_assessment_metrics\summary\' methon]; mkdir(outPath);
    excelPath = [outPath '\' excelName]; 
    % ���ն���ǿ���ͼ�� ·��������
    LLPath =  ['F:\Area 51\9.winter_is_here\code_comparative_experiment\LLEnhance-tradition-models\LLEnhance\summary\' methon '\' llTestset '\'];   
    LLDir = dir([LLPath '*.*']);
    lenLL = length(LLDir);
    
    brisque = zeros(lenLL,1);
    name = string(zeros(lenLL,1));
    disp(['start']) 
    
    %% ���� BRISQUE
    for index=3 : lenLL
        
        % ��ȡ��ǿ��ͼ��
        llName = LLDir(index).name;
        filename = [LLPath llName];         
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
    
    
    
    
    