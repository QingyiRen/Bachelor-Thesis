%��˹ƽ���˲���
function result = gaussian(img,k)%img->[335,600]
img_601 = [img,img(:,1)];
img336_601 = [img_601;img_601(1,:)];
img = img336_601;
%     gray_img = toGray(img); %ͼ��ҶȻ�
    %������趨
    kernel = zeros(k,k);
    %sigma��С��ȷ��
    %sigma = 0.8;
    sigma = 1;
    center = 0;
    for i =1:k
        for j = 1:k
            %��˹��������ģ�����
            %��˹��ά�ֲ���ʽ
            temp = exp(-((i-center)^2+(j-center)^2)/(2*sigma^2));
            kernel(i,j) = temp/(2*pi*sigma^2);
        end
    end
    %��һ��
    sums = sum(sum(kernel));
    kernel = kernel./sums;
    result = myconv(kernel,img);


