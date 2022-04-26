% function en=entropy(image)
%输入图像 
[filename, pathname] = uigetfile('*.*','待计算图像1');
image=imread([pathname, filename]);
A=image; 

[M,N]=size(A); 
temp=zeros(1,256); 

%对图像的灰度值在[0,255]上做统计 
for m=1:M; 
for n=1:N; 

if A(m,n)==0; 
i=1; 
else 
i=A(m,n)+1; 
end 
temp(i)=temp(i)+1; 
end 
end 
temp=temp./(M*N); 

%由熵的定义做计算 
en=0; 

for i=1:length(temp) 
if temp(i)==0; 
en=en; 
else 
en=en-temp(i)*log2(temp(i)); 
end 
end 
en

