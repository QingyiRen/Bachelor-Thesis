function   Inte_img = Integral_Image(matrix)
[row,column] = size(matrix); % ��ȡ��row����column
newMatrix = zeros(row,column); % newMatrixΪ����ͼ���ľ�֤
sum = 0;  % ��Ϊ��ʱ����ʹ��

%% ������ֵ
if row == 1 && column == 1
    newMatrix = matrix;
end

%% �ж�������������������
if row == 1 || column == 1
    %�����������
    if column == 1 && row ~=1
        for k = 1: row
            sum = sum + matrix(k ,column);
            newMatrix(k ,column) = sum;
        end
    end
    %�����������
    if row == 1 && column ~= 1
        for k = 1: column
            sum = sum + matrix(row ,k);
            newMatrix(row ,k) = sum;
        end
    end
end

%%  ��������
sum = 0;
% �������һ�к͵�һ�еĻ���ͼ��
% ��һ��
for m =1 :column
    sum = sum + matrix(1,m);
    newMatrix(1,m) = sum;
end

sum = 0;
num=0;
% ��һ��
for  n = 1: row
    sum = sum + matrix(n, 1);
    newMatrix(n,1) = sum;
    if matrix(n, 1)~=0
        num=num+1;
    end
end


% �ӵڶ��еڶ��п�ʼ������־�֤newMatrix
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


