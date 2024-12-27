function y = guiyihua(I)
max_value=max(max(I));
min_value=min(min(I));
d=max_value-min_value;
[m,n]=size(I);
K=min_value.*ones(m,n);
O=0.1.*ones(m,n);
y=(I-K)./d+O;



