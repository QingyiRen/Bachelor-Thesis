function key = extremum(cell,k)
m=2^(10-k);
keyadd=zeros(3,1);
key=[];
for ceng=2:4
    img_below=cell2mat(cell(k,ceng-1));%3*3������ĵײ�
    img_now=cell2mat(cell(k,ceng));%3*3������ĵ�ǰ��
    img_above=cell2mat(cell(k,ceng+1));%3*3������Ķ���
    for i=2:m-1
        for j=2:m-1
            y=window(img_below,img_now,img_above,i,j,k);
            if y==1 %�ж��Ƿ�Ϊ�ؼ���
                keyadd(1,1)=i; %�ؼ���洢��һ�У��ڶ��к͵����зֱ𱣴���ά��Ϣ
                keyadd(2,1)=j;
                keyadd(3,1)=ceng;
                key=[key,keyadd];
            end
        end
    end
end
