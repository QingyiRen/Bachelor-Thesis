function result = myconv(kernel,img)
    [k,num] = size(kernel);
    %判断传入的是否为double类型的数据，否则进行转化
    if ~isa(img,'double')
        p1 = double(img);
    else
        p1 = img;
    end
    [m,n] = size(p1);
    result = zeros(m-k+1,n-k+1);
    for i = ((k-1)/2+1):(m-(k-1)/2)
        for j = ((k-1)/2+1):(n-(k-1)/2)
            result(i-(k-1)/2,j-(k-1)/2) = sum(sum(kernel .* p1(i-(k-1)/2:i+(k-1)/2,j-(k-1)/2:j+(k-1)/2)));
        end
    end
end

