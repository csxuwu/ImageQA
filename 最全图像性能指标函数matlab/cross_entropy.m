%���㽻���� 

%����ͼ�� 
[filename, pathname] = uigetfile('*.*','������ͼ��1');
image1=imread([pathname, filename]);
A=image1; 
[filename, pathname] = uigetfile('*.*','������ͼ��2');
image2=imread([pathname, filename]);
B=image2; 

[M,N]=size(A); 
temp1=zeros(1,256); 
temp2=zeros(1,256); 

%��ͼ��ĻҶ�ֵ�ɶԵ���ͳ�� 
for m=1:M; 
for n=1:N; 
    
i=A(m,n)+1; 
j=B(m,n)+1; 

temp1(i)=temp1(i)+1; 
temp2(j)=temp2(j)+1; 

end 
end 
temp1=temp1./(M*N); 
temp2=temp2./(M*N); 

%�ɽ����صĶ��������� 
result=0; 

for i=1:length(temp1)
if temp1(i)==0 || temp2(i)==0
result=result; 
else 
result=result+temp1(i)*log2(temp1(i)/temp2(i)); 
end 
end  
result