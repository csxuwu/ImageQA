%function y=Corr(A,B)
%计算相关系数
%====================================================================
%相关系数，反映了两幅图像之间的相关性，相关系数越大两幅图像的相似程度越高。
%====================================================================

clear all
[filename,pathname]=uigetfile('*.*','图像1');
A=imread([pathname,filename]);
[filename,pathname]=uigetfile('*.*','图像2');
B=imread([pathname,filename]);

A=double(A);
B=double(B);

M1=(A-mean2(A(:)));
M2=(B-mean2(B(:)));
M3=M1.^2;
M4=M2.^2;
total1=sum(sum(M1(:).*M2(:)));
total2=sqrt(sum(sum(M3(:)))*sum(sum(M4(:))));

y=total1/total2