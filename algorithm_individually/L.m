function y = L(rou,I)
%%������˹������ǿ����������棩
k=round(6*rou+1); % kernel��С
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
kernel=kernel./sum;  % ��һ��
% y = myconv(kernel,I);
y = conv2(I, kernel, 'same');%��hΪ����˶�I���о����������I��ͬ��С�����Ĳ���

% figure, imshow(J, []);
% figure, imshow(K, []);


