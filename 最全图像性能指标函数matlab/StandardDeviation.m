
%�����׼��
%======================================================================
%��׼���ӳ�˻Ҷ�����ڻҶȾ�ֵ����ɢ�̶ȡ���׼��Խ����Ҷȼ��ֲ�Խ��ɢ��
%======================================================================

clear all
[filename,pathname]=uigetfile('*.*','ͼ��');
A=imread([pathname,filename]);
A=double(A);
Average=mean2(A(:));
[M,N]=size(A);
sum=0;

for i=1:M
    for j=1:N
        sum=sum+(A(i,j)-Average)^2;
    end
end

SD=sqrt(sum/(M*N))