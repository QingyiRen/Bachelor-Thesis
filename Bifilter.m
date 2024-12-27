function y=Bifilter(ywindow,leftwindow)
[m,n]=size(ywindow);
center=(m+1)/2;
sigma1=1;
sigma2=20;
y=0;
weightsum=0;
for i=1:m
    for j=1:n
        Pdistance=sqrt((i-center)^(2)+(j-center)^(2));%λ�þ���
        Cdistance=abs(leftwindow(i,j)-leftwindow(center,center));%��ɫ����
        weight(i,j)=exp(-Pdistance/sigma1)*exp(-Cdistance/sigma2);
        weightsum=weightsum+weight(i,j);
    end
end
for i=1:m
    for j=1:n
        y=y+weight(i,j)*ywindow(i,j)/weightsum;%��һ��
    end
end