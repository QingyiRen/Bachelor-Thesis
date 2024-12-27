keyFinalone=[];
keyFinaltwo=[];
keyFinalthree=[];
for i=1:size(keyFinalAll,2)
    if keyFinalAll(3,i)==2
          new1=[keyFinalAll(1:2,i);rou_oct(2);0];
          keyFinalone=[keyFinalone new1];
    end
    if keyFinalAll(3,i)==3
         new2=[keyFinalAll(1:2,i);rou_oct(3);0];
         keyFinaltwo=[keyFinaltwo new2];
    end
     if keyFinalAll(3,i)==4
         new3=[keyFinalAll(1:2,i);rou_oct(4);0];
         keyFinalthree=[keyFinalthree new3];
    end
end

key_F1=[];%删去边界处理不了的关键点
s=2;
rou=1.5*rou_oct(s);%当前层的尺度信息
radius1=round(3*rou);%当前点的窗口半径
for i=1:size(keyFinalone,2)%便利未删减的所有关键点
    if ~((keyFinalone(1,i)<=radius1+1)||(keyFinalone(1,i)>=pixel-radius1-1)...
            ||(keyFinalone(2,i)<=radius1+1)||(keyFinalone(2,i)>=pixel-radius1-1))
        key_F1=[key_F1,keyFinalone(:,i)];
    end
end
key_F2=[];%删去边界处理不了的关键点
s=3;
rou=1.5*rou_oct(s);%当前层的尺度信息
radius2=round(3*rou);%当前点的窗口半径
for i=1:size(keyFinaltwo,2)%便利未删减的所有关键点
    if ~((keyFinaltwo(1,i)<=radius2+1)||(keyFinaltwo(1,i)>=pixel-radius2-1)...
            ||(keyFinaltwo(2,i)<=radius2+1)||(keyFinaltwo(2,i)>=pixel-radius2-1))
        key_F2=[key_F2,keyFinaltwo(:,i)];
    end
end
key_F3=[];%删去边界处理不了的关键点
s=4;
rou=1.5*rou_oct(s);%当前层的尺度信息
radius3=round(3*rou);%当前点的窗口半径
for i=1:size(keyFinalthree,2)%便利未删减的所有关键点
    if ~((keyFinalthree(1,i)<=radius3+1)||(keyFinalthree(1,i)>=pixel-radius3-1)...
            ||(keyFinalthree(2,i)<=radius3+1)||(keyFinalthree(2,i)>=pixel-radius3-1))
        key_F3=[key_F3,keyFinalthree(:,i)];
    end
end
%% 对所有关键点邻域作计算
for dot=1:size(key_F1,2)
    xnow=key_F1(1,dot);
    ynow=key_F1(2,dot);
    matNew=[];
    for i=-radius1:radius1
        for j=-radius1:radius1
           if sqrt((i)^(2)+(j)^(2))<=radius1%在半径radius的邻域内取点
               [mag,theta]=mtheta(I((xnow+i-1):(xnow+i+1),(ynow+j-1):(ynow+j+1)));%得到梯度幅值和方向的信息
               weight=(1/(pi*sigma))*exp(-1*(i^2+j^2)/sigma);%得到梯度权重信息
               bin=ceil(theta/10);           
               info=[xnow+i;ynow+i;mag;theta;weight;bin];%6个信息：x,y,梯度，角度，权重，组别
               matNew=[matNew,info];
           end
        end
    end
    Y=zeros(1,36);%36组直方图高度
    for m=1:36
        H=[];%36个组每组的所有点的6个信息构成矩阵
        p=find(matNew(6,:)==m);
        for i=1:size(p,2)
            H=[H,matNew(:,p(i))];
        end
        for jj=1:size(H,2)
            Y(1,m)=Y(1,m)+H(3,jj)*H(5,jj);
        end
        info36cell{dot,m}=H;
    end
    
    Main_dots=[];%主方向包含的同一组内的所有点
    [MaxY,Main_dic]=max(Y);%主方向Y极值，主方向所在组数
    Main_dots=info36cell{dot,Main_dic};
    ave_main_deg=0;
    for i=1:size(Main_dots,2)%主方向角度加权计算
        ave_main_deg=ave_main_deg+Main_dots(4,i)*Main_dots(3,i)*Main_dots(5,i)/MaxY;
    end
    
    Vice_dic=[];%副方向点所在组数
    for m=1:36%负方向寻找
        if Y(1,m)>=0.8*MaxY&&Y(1,m)<MaxY 
            Vice_dic=[Vice_dic,m];
        end
    end
    
    Vice_dots=[];%副方向包含的同一组内的所有点
    if isempty(Vice_dic)%如果没有产生副方向则直接返回0组数和0角度
        ave_vice_deg=0;       
        Vice_dic=0;
    else%产生一个或多个副方向
        ave_vice_deg=zeros(1,size(Vice_dic,2));%副方向对应角度
        for i=1:size(Vice_dic,2)%多个负方向角度加权计算
            Vice_dots=info36cell{dot,Vice_dic(i)};%Vice_dic(i)副方向角所在组数
            Vice_Y=Y(1,Vice_dic(i));%当前副方向Y值
            for j=1:size(Vice_dots,2)
                ave_vice_deg(i)=ave_vice_deg(i)+Vice_dots(4,j)*Vice_dots(3,j)*Vice_dots(5,j)/Vice_Y;
            end
        end
    end
    Main_Vice_dic{1,dot}=Main_dic;%1主方向组数
    Main_Vice_dic{2,dot}=ave_main_deg;%2主方向平均角（单个）
    Main_Vice_dic{3,dot}=Vice_dic;%3副方向组数（多值）
    Main_Vice_dic{4,dot}=ave_vice_deg;%4副方向平均角（多个）
%     figure(dot)%可视化
%     bar(1:36,Y)
end