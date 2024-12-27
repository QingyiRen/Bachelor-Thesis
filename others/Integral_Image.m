function   Inte_img = Integral_Image(matrix)
[row,column] = size(matrix); % 获取行row，列column
newMatrix = zeros(row,column); % newMatrix为积分图像后的举证
sum = 0;  % 作为临时变量使用

%% 单个数值
if row == 1 && column == 1
    newMatrix = matrix;
end

%% 判断是行向量或者列向量
if row == 1 || column == 1
    %如果是列向量
    if column == 1 && row ~=1
        for k = 1: row
            sum = sum + matrix(k ,column);
            newMatrix(k ,column) = sum;
        end
    end
    %如果是行向量
    if row == 1 && column ~= 1
        for k = 1: column
            sum = sum + matrix(row ,k);
            newMatrix(row ,k) = sum;
        end
    end
end

%%  整个矩阵
sum = 0;
% 先求出第一行和第一列的积分图像
% 第一行
for m =1 :column
    sum = sum + matrix(1,m);
    newMatrix(1,m) = sum;
end

sum = 0;
num=0;
% 第一列
for  n = 1: row
    sum = sum + matrix(n, 1);
    newMatrix(n,1) = sum;
    if matrix(n, 1)~=0
        num=num+1;
    end
end


% 从第二行第二列开始求出积分举证newMatrix
for m=2 : row
    for n=2 :column
        sum = 0;
        for k=1:n
            sum = sum + matrix(m,k);
        end
        newMatrix(m,n) = sum + newMatrix(m-1,n);
        if newMatrix(m-1,n)~=0
        num=num+1;
        end
    end
end

Inte_img= newMatrix;
end


