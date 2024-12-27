%% 处理
keyFinalAll_radius_deducted=[];%删去半径包含点后三层平滑层图象关键点
for smooth_layer=1:3
    smoothed_pic=img_p{smooth_layer};%取不同平滑层像素图片
    s=smooth_layer+1;
    rou=1.5*rou_oct(s);%当前层的尺度信息
    sigma=2*rou*rou;  
    radius=round(3*rou);%当前点的窗口半径
    [m1,n1]=size(smoothed_pic); %像素点数
    keyFinal_smooth=[];%删去边界半径内处理不了的关键点
    for i=1:size(keyFinalAll,2)
        if keyFinalAll(3,i)==smooth_layer+1%第二、三、四层平滑层
            %窗口半径内
            if ~((keyFinalAll(1,i)<=radius+1)||(keyFinalAll(1,i)>=m1-radius-1)...
                ||(keyFinalAll(2,i)<=radius+1)||(keyFinalAll(2,i)>=n1-radius-1))
                keyFinal_smooth=[keyFinal_smooth,keyFinalAll(:,i)];
            end
        end
    end
    keyFinalAll_radius_deducted=[keyFinalAll_radius_deducted,keyFinal_smooth];

    %% 对所有关键点邻域作计算
    Main_Vice_dic_smooth={};%每一层平滑层主副关键点元胞
    for dot=1:size(keyFinal_smooth,2)   
        info36cell={};%将一层平滑层的所有关键点按照36组存放每组含有的所有点的六位信息
        xnow=keyFinal_smooth(1,dot);
        ynow=keyFinal_smooth(2,dot);
        matNew=[];%关键点邻域所有点六位信息
        for i=-radius:radius
            for j=-radius:radius
               if sqrt((i)^(2)+(j)^(2))<=radius%在半径radius的邻域内取点
                   [mag,theta]=mtheta(smoothed_pic((xnow+i-1):(xnow+i+1),(ynow+j-1):(ynow+j+1)));%得到梯度幅值和方向的信息
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
        Main_Vice_dic_smooth{1,dot}=Main_dic;%1主方向组数
        Main_Vice_dic_smooth{2,dot}=ave_main_deg;%2主方向平均角（单个）
        Main_Vice_dic_smooth{3,dot}=Vice_dic;%3副方向组数（多值）
        Main_Vice_dic_smooth{4,dot}=ave_vice_deg;%4副方向平均角（多个）
    %     figure(dot)%可视化，不建议显示所有关键点完整循环的直方图
    %     bar(1:36,Y)
    end
    Main_Vice_dic{smooth_layer,1}=Main_Vice_dic_smooth;
end
