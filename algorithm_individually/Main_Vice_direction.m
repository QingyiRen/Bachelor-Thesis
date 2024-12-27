%% ����
keyFinalAll_radius_deducted=[];%ɾȥ�뾶�����������ƽ����ͼ��ؼ���
for smooth_layer=1:3
    smoothed_pic=img_p{smooth_layer};%ȡ��ͬƽ��������ͼƬ
    s=smooth_layer+1;
    rou=1.5*rou_oct(s);%��ǰ��ĳ߶���Ϣ
    sigma=2*rou*rou;  
    radius=round(3*rou);%��ǰ��Ĵ��ڰ뾶
    [m1,n1]=size(smoothed_pic); %���ص���
    keyFinal_smooth=[];%ɾȥ�߽�뾶�ڴ����˵Ĺؼ���
    for i=1:size(keyFinalAll,2)
        if keyFinalAll(3,i)==smooth_layer+1%�ڶ��������Ĳ�ƽ����
            %���ڰ뾶��
            if ~((keyFinalAll(1,i)<=radius+1)||(keyFinalAll(1,i)>=m1-radius-1)...
                ||(keyFinalAll(2,i)<=radius+1)||(keyFinalAll(2,i)>=n1-radius-1))
                keyFinal_smooth=[keyFinal_smooth,keyFinalAll(:,i)];
            end
        end
    end
    keyFinalAll_radius_deducted=[keyFinalAll_radius_deducted,keyFinal_smooth];

    %% �����йؼ�������������
    Main_Vice_dic_smooth={};%ÿһ��ƽ���������ؼ���Ԫ��
    for dot=1:size(keyFinal_smooth,2)   
        info36cell={};%��һ��ƽ��������йؼ��㰴��36����ÿ�麬�е����е����λ��Ϣ
        xnow=keyFinal_smooth(1,dot);
        ynow=keyFinal_smooth(2,dot);
        matNew=[];%�ؼ����������е���λ��Ϣ
        for i=-radius:radius
            for j=-radius:radius
               if sqrt((i)^(2)+(j)^(2))<=radius%�ڰ뾶radius��������ȡ��
                   [mag,theta]=mtheta(smoothed_pic((xnow+i-1):(xnow+i+1),(ynow+j-1):(ynow+j+1)));%�õ��ݶȷ�ֵ�ͷ������Ϣ
                   weight=(1/(pi*sigma))*exp(-1*(i^2+j^2)/sigma);%�õ��ݶ�Ȩ����Ϣ
                   bin=ceil(theta/10);           
                   info=[xnow+i;ynow+i;mag;theta;weight;bin];%6����Ϣ��x,y,�ݶȣ��Ƕȣ�Ȩ�أ����
                   matNew=[matNew,info];
               end
            end
        end
        Y=zeros(1,36);%36��ֱ��ͼ�߶�
        for m=1:36
            H=[];%36����ÿ������е��6����Ϣ���ɾ���
            p=find(matNew(6,:)==m);
            for i=1:size(p,2)
                H=[H,matNew(:,p(i))];
            end
            for jj=1:size(H,2)
                Y(1,m)=Y(1,m)+H(3,jj)*H(5,jj);
            end
            info36cell{dot,m}=H;
        end

        Main_dots=[];%�����������ͬһ���ڵ����е�
        [MaxY,Main_dic]=max(Y);%������Y��ֵ����������������
        Main_dots=info36cell{dot,Main_dic};
        ave_main_deg=0;
        for i=1:size(Main_dots,2)%������Ƕȼ�Ȩ����
            ave_main_deg=ave_main_deg+Main_dots(4,i)*Main_dots(3,i)*Main_dots(5,i)/MaxY;
        end

        Vice_dic=[];%���������������
        for m=1:36%������Ѱ��
            if Y(1,m)>=0.8*MaxY&&Y(1,m)<MaxY 
                Vice_dic=[Vice_dic,m];
            end
        end

        Vice_dots=[];%�����������ͬһ���ڵ����е�
        if isempty(Vice_dic)%���û�в�����������ֱ�ӷ���0������0�Ƕ�
            ave_vice_deg=0;       
            Vice_dic=0;
        else%����һ������������
            ave_vice_deg=zeros(1,size(Vice_dic,2));%�������Ӧ�Ƕ�
            for i=1:size(Vice_dic,2)%���������Ƕȼ�Ȩ����
                Vice_dots=info36cell{dot,Vice_dic(i)};%Vice_dic(i)���������������
                Vice_Y=Y(1,Vice_dic(i));%��ǰ������Yֵ
                for j=1:size(Vice_dots,2)
                    ave_vice_deg(i)=ave_vice_deg(i)+Vice_dots(4,j)*Vice_dots(3,j)*Vice_dots(5,j)/Vice_Y;
                end
            end
        end
        Main_Vice_dic_smooth{1,dot}=Main_dic;%1����������
        Main_Vice_dic_smooth{2,dot}=ave_main_deg;%2������ƽ���ǣ�������
        Main_Vice_dic_smooth{3,dot}=Vice_dic;%3��������������ֵ��
        Main_Vice_dic_smooth{4,dot}=ave_vice_deg;%4������ƽ���ǣ������
    %     figure(dot)%���ӻ�����������ʾ���йؼ�������ѭ����ֱ��ͼ
    %     bar(1:36,Y)
    end
    Main_Vice_dic{smooth_layer,1}=Main_Vice_dic_smooth;
end
