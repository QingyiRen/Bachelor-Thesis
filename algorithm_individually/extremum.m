function key = extremum(cell,k)
m=2^(10-k);
keyadd=zeros(3,1);
key=[];
for ceng=2:4
    img_below=cell2mat(cell(k,ceng-1));%3*3立方体的底层
    img_now=cell2mat(cell(k,ceng));%3*3立方体的当前层
    img_above=cell2mat(cell(k,ceng+1));%3*3立方体的顶层
    for i=2:m-1
        for j=2:m-1
            y=window(img_below,img_now,img_above,i,j,k);
            if y==1 %判断是否为关键点
                keyadd(1,1)=i; %关键点存储第一行，第二行和第三行分别保存三维信息
                keyadd(2,1)=j;
                keyadd(3,1)=ceng;
                key=[key,keyadd];
            end
        end
    end
end
