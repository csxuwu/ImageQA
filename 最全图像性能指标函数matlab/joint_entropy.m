%���������� 

%����ͼ�� 
[filename, pathname] = uigetfile('*.*','������ͼ��1');
image1=imread([pathname, filename]);
A=image1; 
[filename, pathname] = uigetfile('*.*','������ͼ��2');
image2=imread([pathname, filename]);
B=image2; 

[M,N]=size(A); 
temp=zeros(256,256); 

%��ͼ��ĻҶ�ֵ�ɶԵ���ͳ�� 
for m=1:M; 
for n=1:N; 

if A(m,n)==0; 
i=1; 
else 
i=A(m,n)+1; 
end 

if B(m,n)==0; 
j=1; 
else 
j=B(m,n)+1; 
end 

temp(i,j)=temp(i,j)+1; 
end 
end 
temp=temp./(M*N); 

%���صĶ��������� 
result=0; 

for i=1:size(temp,1) 
for j=1:size(temp,2) 
if temp(i,j)==0; 
result=result; 
else 
result=result-temp(i,j)*log2(temp(i,j)); 
end 
end 
end 
result
