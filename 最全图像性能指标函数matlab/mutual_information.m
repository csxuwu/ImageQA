%计算互信息 

%输入图像 
[filename, pathname] = uigetfile('*.*','融合源图像1');
image1=imread([pathname, filename]);
A=image1; 
s=size(size(A));
if s(2)==3
    A=rgb2gray(A);
end
[filename, pathname] = uigetfile('*.*','融合源图像2');
image2=imread([pathname, filename]);
B=image2; 
s=size(size(B));
if s(2)==3
    B=rgb2gray(B);
end
[filename, pathname] = uigetfile('*.*','融合图像3');
image3=imread([pathname, filename]);
C=image3; 
s=size(size(C));
if s(2)==3
    C=rgb2gray(C);
end


[M,N]=size(A); 
temp1=zeros(256); 
temp2=zeros(256,256); 
temp3=zeros(256,256,256); 

%对图像的灰度值成对地做统计 
for m=1:M; 
for n=1:N; 

i=A(m,n)+1; 
j=B(m,n)+1; 
k=C(m,n)+1; 

temp1(k)=temp1(k)+1; 
temp2(i,j)=temp2(i,j)+1; 
temp3(i,j,k)=temp3(i,j,k)+1; 
end 
end 
temp1=temp1./(M*N); 
temp2=temp2./(M*N); 
temp3=temp3./(M*N); 

%由熵的定义做计算 
result=0; 

for i=1:size(temp1) 
for j=1:size(temp2)
for k=1:size(temp3)
if temp3(i,j,k)==0 || temp2(i,j)==0 || temp1(k)==0  
result=result; 
else 
result=result+temp3(i,j,k)*log2(temp3(i,j,k)/temp2(i,j)/temp1(k)); 
end 
end 
end 
end
result
