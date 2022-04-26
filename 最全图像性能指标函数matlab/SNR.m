
%求信噪比
%==================================================
%认为融合图像与理想图像的差异就是噪声，理想图像就是信息
%信噪比越大说明融合图像噪声抑制的越好
%==================================================
%输入图像 
clear all
[filename, pathname] = uigetfile('*.*','融合图像');
image1=imread([pathname, filename]);
A=image1; 
A=double(A);
[filename, pathname] = uigetfile('*.*','理想图像');
image2=imread([pathname, filename]);
B=image2;
B=double(B);

sum1=0;
sum2=0;
[M,N]=size(A); 

for i=1:M
    for j=1:N
        sum1=sum1+(B(i,j))^2;
        sum2=sum2+(A(i,j)-B(i,j))^2;
    end
end
y=10*log(sum1/sum2)