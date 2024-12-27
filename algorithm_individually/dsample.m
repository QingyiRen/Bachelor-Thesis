function Idown = dsample(I,N) 
[row,col] = size(I); 
drow = round(row/N); 
dcol = round(col/N); 
Idown = zeros(drow,dcol); 
p =1; 
q =1; 
for i = 1:N:row 
    for j = 1:N:col 
         Idown(p,q) = I(i,j); 
         q = q+1; 
    end 
    q =1; 
    p = p+1; 
end 
%======================================================== 
%   Name: dsample.m 
%   功能：降采样 
%   输入：采样图片 I, 降采样系数N 
%   输出：采样后的图片Idown 
%======================================================== 
