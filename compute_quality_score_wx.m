


function compute_quality_score_wx()
	clc;close all;clear all;

    %% ���������Լ�
    methons = ["ZS_v2"];
%     testSetList = ["MEF"; "DICM"; "NPE"; "VV"; "TID2013"; "LIME"];
     testSetList = ["epoch_9"];
    basicPath1 = "G:\Code\Hailstone\logs\ZS_v2_0\test_ZS_v2_0_ExDark_all_256_spa_color_exp_tv\out\LOL";
    basicPath2 = "G:\Code\Comparative-Experiment\code_comparative_experiment\quality_assessment_metrics\summary";
    basicPath3 = "G:\Dataset\LL_Set";     % ���նȲ��Լ�

    %% ѭ��ÿ������
    for idxM = 1 : length(methons)
        methonCur = methons(idxM);
%         methonPath = strcat(basicPath1, '\', methonCur);
         methonPath = strcat(basicPath1);
        excelName = strcat(methonCur, '.xlsx');         % �洢���ݵ�excel��
        outPath = strcat(basicPath2, '\', excelName);   % ���·��
       %% ѭ��ÿ�����Լ�
        for idxT = 1 : length(testSetList)
            testSetCur = testSetList(idxT);		% ��ǰ���Լ�
            testSetPath = strcat(methonPath, '\', testSetCur);	% ���Լ�·��
            llSetPath = strcat(basicPath3, '\', testSetCur);    % ���ն����ݼ�·��
            
            testImgs = dir(strcat(testSetPath, '\*'));			% ���Լ�������ͼ��
            llImgs = dir(strcat(llSetPath, '\*'));
            lenTestImgs = length(testImgs);
            if lenTestImgs == 0
                disp("***********************");
                disp(['erro:' testSetCur 'is null.']);
                disp("***********************");
                break;
            end

            % ����洢����ͼ���������۷�����ͼ��÷�
            name = string(zeros(lenTestImgs-1,1));
            niqe = string(zeros(lenTestImgs-1, 1));	niqe(1) = "NIQE";
            piqe = string(zeros(lenTestImgs-1, 1));	piqe(1) = "PIQE";
            loe = string(zeros(lenTestImgs-1, 1));	loe(1)	= "LOE";
            brisque = string(zeros(lenTestImgs-1, 1)); brisque(1) = "BRISQUE";
%             sinq = string(zeros(lenTestImgs-1, 1));	sinq(1)	= "SINQ";

           %% ����ÿ��ͼ��������÷�
            for idxI = 3 : lenTestImgs
                % ��ȡÿ��ͼ��
                imgName = testImgs(idxI).name;
                llImgName = llImgs(idxI).name;
                imgFullPath = strcat(testSetPath, '\', imgName);
                llImgFullPath = strcat(llSetPath, '\', llImgName);
                imgEnhanced = (im2double(imread(imgFullPath)));
                llImg = (im2double(imread(llImgFullPath)));
                
                % ���������÷�
                print(methonCur, testSetCur, imgName, idxI);
                scoreNIQE = computeNIQE(imgEnhanced);	% NIQE
                scorePIQE = computePIQE(imgEnhanced);	% PIQE	
                scoreLOE = computeLOE(llImg, imgEnhanced);		% LOE
%                 scoreSINQ = computeSINQ(imgEnhanced);	% SINQ
                scoreBRISQUE = computeBRISQUE(imgEnhanced);	% BRISQUE                
           
                name(idxI - 1) = imgName;
                niqe(idxI - 1) = num2str(scoreNIQE);
                piqe(idxI - 1) = num2str(scorePIQE);
                loe(idxI - 1) = num2str(scoreLOE);
                brisque(idxI - 1) = num2str(scoreBRISQUE);
%                 sinq(idxI - 1) = num2str(scoreSINQ);
                
                
            end
           
            saveData(outPath, name, testSetCur, niqe, piqe, loe, brisque);
        end	
    end

%% ��������
function saveData(outPath, imgName, testSetCur, scoreNIQE, scorePIQE, scoreLOE, scoreBRISQUE)
	state_name = xlswrite(outPath,imgName, testSetCur, 'A');
    disp(testSetCur)
	state_BRISQUE = xlswrite(outPath,scoreBRISQUE, testSetCur, 'B');
    xlswrite(outPath,scoreNIQE, testSetCur, 'C');
    xlswrite(outPath,scorePIQE, testSetCur, 'D');
    xlswrite(outPath,scoreLOE, testSetCur, 'E');
%     xlswrite(outPath,scoreSINQ, testSetCur, 'F');
%     xlswrite(outPath,scoreSINQ, testSetCur, 'G');
    

	if state_BRISQUE == 1 && state_name == 1
        disp(['*********************'])
        disp(['all data has saved.'])
	end

%% ����SINQ
function score = computeSINQ(img)
	addpath('./SINQ_release');
	load model.mat;
	score = compute_score(img);
	strSINQ = ['SINQ : ' num2str(score)];	
    disp(strSINQ);
	
%% ����LOE
function score = computeLOE(imgLL, imgEnhanced)
 	addpath('./LOE');
 	[m,n,k]=size(imgLL);

    %get the local maximum for each pixel of the input image
    win=7;
    imax=round(max(max(imgLL(:,:,1),imgLL(:,:,2)),imgLL(:,:,3)));
    imax=getlocalmax(imax,win);
    %get the local maximum for each pixel of the enhanced image
    emax=round(max(max(imgEnhanced(:,:,1),imgEnhanced(:,:,2)),imgEnhanced(:,:,3)));
    emax=getlocalmax(emax,win);

    %get the downsampled image
    blkwin=50;
    mind=min(m,n);
    step=floor(mind/blkwin);% the step to down sample the image
    blkm=floor(m/step);
    blkn=floor(n/step);
    ipic_ds=zeros(blkm,blkn);% downsampled of the input image
    epic_ds=zeros(blkm,blkn);% downsampled of the enhanced image
    LOE=zeros(blkm,blkn);%

    for i=1:blkm
        for j=1:blkn
            ipic_ds(i,j)=imax(i*step,j*step);
            epic_ds(i,j)=emax(i*step,j*step);
        end
    end

    for i=1:blkm
        for j=1:blkn%bug
            flag1=ipic_ds>=ipic_ds(i,j);
            flag2=epic_ds>=epic_ds(i,j);
            flag=(flag1~=flag2);
            LOE(i,j)=sum(flag(:));
        end
    end

    score=mean(LOE(:));
   	strLOE = ['LOE : ' num2str(score)];
   	disp(strLOE)
 	
 %% ����PIQE
 function score = computePIQE(img)
	score = piqe(img);
	strPIQE = ['PIQE : ' num2str(score)];
	disp(strPIQE)
 
 %% ����BRISQUE
 function score = computeBRISQUE(img)
 	addpath('./BRISQUE_release');
 	score = brisquescore(img);
 	strBRISQUE = ['BRISQUE : ' num2str(score)];
 	disp(strBRISQUE)
 
 %% ����NIQE
 function score = computeNIQE(img)
 	addpath('./niqe_release');
 	load modelparameters.mat;

	blocksizerow    = 96;
    blocksizecol    = 96;
    blockrowoverlap = 0;
    blockcoloverlap = 0;
    score = computequality(img,blocksizerow,blocksizecol,blockrowoverlap,blockcoloverlap, ...
            mu_prisparam,cov_prisparam);
    strNIQE = ['NIQE : ' num2str(score)];
    disp(strNIQE)

 %% �����ʾ��Ϣ
 function print(methon, llTestset, llName, index)

    disp(['----------------------------------'])
    disp([strcat('methon : ', methon)])
    disp([strcat('testset : ', llTestset)])
    disp(['index : ' num2str(index-2)])
    disp (['image :' llName])
    
function output=getlocalmax(pic,win)
    [m,n]=size(pic);
    extpic=getextpic(pic,win);
    output=zeros(m,n);
    for i=1+win:m+win
        for j=1+win:n+win
            modual=extpic(i-win:i+win,j-win:j+win);
            output(i-win,j-win)=max(modual(:));
        end
    end

function output=getextpic(im,win_size)
    [h,w,c]=size(im);
    extpic=zeros(h+2*win_size,w+2*win_size,c);
    extpic(win_size+1:win_size+h,win_size+1:win_size+w,:)=im;
    for i=1:win_size%extense row
        extpic(win_size+1-i,win_size+1:win_size+w,:)=extpic(win_size+1+i,win_size+1:win_size+w,:);%top edge
        extpic(h+win_size+i,win_size+1:win_size+w,:)=extpic(h+win_size-i,win_size+1:win_size+w,:);%botom edge
    end
    for i=1:win_size%extense column
        extpic(:,win_size+1-i,:)=extpic(:,win_size+1+i,:);%left edge
        extpic(:,win_size+w+i,:)=extpic(:,win_size+w-i,:);%right edge
    end
    output=extpic;
    
    
