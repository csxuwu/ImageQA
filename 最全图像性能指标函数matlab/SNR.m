
%�������
%==================================================
%��Ϊ�ں�ͼ��������ͼ��Ĳ����������������ͼ�������Ϣ
%�����Խ��˵���ں�ͼ���������Ƶ�Խ��
%==================================================
%����ͼ�� 
clear all
[filename, pathname] = uigetfile('*.*','�ں�ͼ��');
image1=imread([pathname, filename]);
A=image1; 
A=double(A);
[filename, pathname] = uigetfile('*.*','����ͼ��');
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