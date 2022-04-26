% clc;
% clear;
% 基于LOE_WX，但是允许同时测试多个数据
function LOE()
    clc;
    clear;
   
%     ll_list = ["MEF";"NPE";"DICM";"VV";"ExDark120";"LIME"];
    ll_list = ["MEF";"LIME"];
    methon = "INetv121_0";
    outPath = strcat('G:\Code\Comparative-Experiment\code_comparative_experiment\quality_assessment_metrics\summary\', methon); mkdir(outPath);
    enhancedPath = "G:\Code\Jaguar\logs\INet_v121_0\test_INet_v121_0_Syn5_256_l2_per\out\LL_all2\";
%     outPath = 'G:\Code\Jaguar\logs\INet_v121_0\test_INet_v121_0_Syn5_256_l2_per\out\LL_all2\';
    for i_ll = 1:length(ll_list) 
        
        llTestset = string(ll_list(i_ll));
%         llTestset = tp;
        excelName = strcat('LOE_', methon, '_', llTestset,  '.xlsx');       
%         excelName = strcat('LOE_.xls');   
        excelPath = strcat(outPath, '\', excelName); % excel路径
        ipicPath =  strcat('G:\Dataset\LL_Set\', llTestset, '\');     % 低照度图像
        ipicDir = dir(strcat(ipicPath,'*.*'));

    %     epicPath =   'F:\Area 51\9.winter_is_here\code\quality_assessment_metrics\imgs\zero\';     % 增强后图像
    %     epicPath = 'F:\Area 51\9.winter_is_here\code_comparative_experiment\wuxu-code-LIME-master\LIME\summary\ExDark\';
    %     epicPath = 'F:\Area 51\9.winter_is_here\code_comparative_experiment\wuxu-code-LLEnhance-master\LLEnhance\others\summary\JED\ExDark\';
    %     epicPath = 'F:\Area 51\9.winter_is_here\code_comparative_experiment\wuxu-code-LLEnhance-master\LLEnhance\others\summary\Dong\ExDark\';
%         epicPath = strcat(enhancedPath, methon, '\', llTestset, '\');
         epicPath = strcat(enhancedPath, '\', llTestset, '\')
        
        epicDir = dir(strcat(epicPath, '*.*'));

        len_ipic = length(ipicDir); % 低照度图像
        len_epic = length(epicDir); % 增强后的图像

        inconsistentNum = 0;        % 低照度，增强图像不匹配的对数 

        if len_ipic ~= len_epic
            disp(['erro of dataset.'])
        else
            disp(['data num : ' num2str(len_epic-2)])
        end
        loe = zeros(len_ipic,1);
        name = string(zeros(len_ipic,1));
        disp(['start']) 

        %%
        for index = 3:len_ipic             

            % 低照度图像
            ipicName = ipicDir(index).name;
            ipic=imread(strcat(ipicPath,ipicName));
            ipic=double(ipic);
            % 增强后图像
            epicName = epicDir(index).name;
            epic=imread(strcat(epicPath, epicName));
            epic=double(epic);


           %%
            % 计算LOE
            [m,n,k]=size(ipic);

            %get the local maximum for each pixel of the input image
            win=7;
            imax=round(max(max(ipic(:,:,1),ipic(:,:,2)),ipic(:,:,3)));
            imax=getlocalmax(imax,win);
            %get the local maximum for each pixel of the enhanced image
            emax=round(max(max(epic(:,:,1),epic(:,:,2)),epic(:,:,3)));
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

            LOE=mean(LOE(:));

            % 存储并显示LOE等信息
            loe(index-2) = LOE;  
            name(index-2) = ipicName;
            disp(['-----------------------'])
            disp([num2str(index-2)])
            disp(['testset : ' llTestset])
            disp (['image :' ipicName])
            str = ['the LOE : ' num2str(LOE)];
            disp(str)
        end
        %%
        state_name = xlswrite(excelPath,name, '1', 'A');
        state_loe = xlswrite(excelPath,loe, '1', 'B');
        if state_loe == 1 && state_name == 1
            disp(['*********************'])
            disp(['inconsistentNum :' num2str(inconsistentNum)])
            disp(['all data has saved.: ' excelPath])
        end
    end
end

%%
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
end

%%
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
end

