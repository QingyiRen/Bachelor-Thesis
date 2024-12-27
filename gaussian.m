%高斯平滑滤波器
function result = gaussian(img,k)%img->[335,600]
img_601 = [img,img(:,1)];
img336_601 = [img_601;img_601(1,:)];
img = img336_601;
%     gray_img = toGray(img); %图像灰度化
    %卷积核设定
    kernel = zeros(k,k);
    %sigma大小的确定
    %sigma = 0.8;
    sigma = 1;
    center = 0;
    for i =1:k
        for j = 1:k
            %高斯函数计算模板参数
            %高斯二维分布公式
            temp = exp(-((i-center)^2+(j-center)^2)/(2*sigma^2));
            kernel(i,j) = temp/(2*pi*sigma^2);
        end
    end
    %归一化
    sums = sum(sum(kernel));
    kernel = kernel./sums;
    result = myconv(kernel,img);


