
%�����ֵ����׼��ء�ƽ���ݶȡ����ϵ����Ť���̶ȡ�ƫ��ָ��
%======================================================================
%��ֵ��ͼ�����صĻҶ�ƽ��ֵ�������۷�ӳΪƽ�����ȡ�
%��׼���ӳ�˻Ҷ�����ڻҶȾ�ֵ����ɢ�̶ȡ���׼��Խ����Ҷȼ��ֲ�Խ��ɢ��
%�أ�ͼ���ƽ����Ϣ����
%ƽ���ݶȣ���ӳ��ͼ��������̶ȣ�ͬʱ��ӳ��ͼ����΢Сϸ�ڷ��������任������
%���ϵ������ӳ������ͼ��֮�������ԣ����ϵ��Խ������ͼ������Ƴ̶�Խ�ߡ�
%Ť���̶ȣ���ӳӰ��Ĺ���ʧ��̶ȡ�
%ƫ��ָ������ӳ����ͼ���ڹ�����Ϣ�ϵ�ƥ��̶ȣ�ƫ��ָ��ֵԽС����˵���ںϺ�ͼ
%��������˿ռ�ֱ��ʵ�ͬʱ���Ϻõı����˶����ͼ��Ĺ�����Ϣ��
%=======================================================================

clear all
[filename,pathname]=uigetfile('*.*','�ں�ͼ��');
F=imread([pathname,filename]);
[filename,pathname]=uigetfile('*.*','�����ͼ��');
A=imread([pathname,filename]);
%[filename,pathname]=uigetfile('*.*','SARͼ��');
%B=imread([pathname,filename]);
Fimage=double(F);
A=double(A);
%B=double(B);

%���ں�ͼ��ĻҶȾ�ֵ
mean=mean2(Fimage(:));

%���׼ƫ��
std=std2(Fimage(:));

%����
ent=entropy(F(:));

[mf,nf,kf]=size(F);
q=0;

%���ں�ͼ���ƽ���ݶ�
for i=1:1:mf-1
    for j=1:1:nf-1
        q=q+(sqrt(((Fimage(i,j)-Fimage(i+1,j))^2+(Fimage(i,j)-Fimage(i,j+1))^2)/2));
    end
end
grad=q/((mf-1)*(nf-1));

%�����ϵ�� ��ӳ���ױ�������
rmul=imresize(A,[mf,nf],'bicubic');
c=corr2(rmul(:),Fimage(:));

%��Ť���̶� ֱ�ӷ�ӳӰ��Ĺ���ʧ��̶�
q1=0;
for i=1:1:mf
    for j=1:1:nf
        q1=q1+abs(Fimage(i,j)-rmul(i,j));
    end
end
warp=q1/(mf*nf);

%��ƫ��ָ��
q2=0;
for i=1:1:mf
    for j=1:1:nf
        q2=q2+abs(Fimage(i,j)-rmul(i,j))/rmul(i,j);
    end
end
bras=q2/(mf*nf);

result=zeros(1,7);
result=[mean std ent grad c warp bras];
disp('     ��ֵ     ��׼��       ��     ƽ���ݶ�   ���ϵ��   Ť���̶�   ƫ��ָ��');
disp(result );%std ,ent ,grad ,c ,warp, bras); 

