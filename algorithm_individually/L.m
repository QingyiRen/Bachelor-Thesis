function y = L(rou,I)
%%拉普拉斯算子增强（卷积在下面）
k=round(6*rou+1); % kernel大小
kernel=zeros(k);
m=(k+1)/2;
sigma=2*rou*rou;
for i=-1*(k-1)/2:(k-1)/2
   for j=-1*(k-1)/2:(k-1)/2
      kernel(i+m,j+m)=(-1/(pi*sigma))*exp(-1*(i^2+j^2)/sigma);
   end
end
sum=0;
for i=1:k
    for j=1:k
        sum=sum+kernel(i,j);
    end
end
kernel=kernel./sum;  % 归一化
% y = myconv(kernel,I);
y = conv2(I, kernel, 'same');%以h为卷积核对I进行卷积，返回与I相同大小的中心部分

% figure, imshow(J, []);
% figure, imshow(K, []);


