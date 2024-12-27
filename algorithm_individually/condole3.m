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

key_F1=[];%ɾȥ�߽紦���˵Ĺؼ���
s=2;
rou=1.5*rou_oct(s);%��ǰ��ĳ߶���Ϣ
radius1=round(3*rou);%��ǰ��Ĵ��ڰ뾶
for i=1:size(keyFinalone,2)%����δɾ�������йؼ���
    if ~((keyFinalone(1,i)<=radius1+1)||(keyFinalone(1,i)>=pixel-radius1-1)...
            ||(keyFinalone(2,i)<=radius1+1)||(keyFinalone(2,i)>=pixel-radius1-1))
        key_F1=[key_F1,keyFinalone(:,i)];
    end
end
key_F2=[];%ɾȥ�߽紦���˵Ĺؼ���
s=3;
rou=1.5*rou_oct(s);%��ǰ��ĳ߶���Ϣ
radius2=round(3*rou);%��ǰ��Ĵ��ڰ뾶
for i=1:size(keyFinaltwo,2)%����δɾ�������йؼ���
    if ~((keyFinaltwo(1,i)<=radius2+1)||(keyFinaltwo(1,i)>=pixel-radius2-1)...
            ||(keyFinaltwo(2,i)<=radius2+1)||(keyFinaltwo(2,i)>=pixel-radius2-1))
        key_F2=[key_F2,keyFinaltwo(:,i)];
    end
end
key_F3=[];%ɾȥ�߽紦���˵Ĺؼ���
s=4;
rou=1.5*rou_oct(s);%��ǰ��ĳ߶���Ϣ
radius3=round(3*rou);%��ǰ��Ĵ��ڰ뾶
for i=1:size(keyFinalthree,2)%����δɾ�������йؼ���
    if ~((keyFinalthree(1,i)<=radius3+1)||(keyFinalthree(1,i)>=pixel-radius3-1)...
            ||(keyFinalthree(2,i)<=radius3+1)||(keyFinalthree(2,i)>=pixel-radius3-1))
        key_F3=[key_F3,keyFinalthree(:,i)];
    end
end
%% �����йؼ�������������
for dot=1:size(key_F1,2)
    xnow=key_F1(1,dot);
    ynow=key_F1(2,dot);
    matNew=[];
    for i=-radius1:radius1
        for j=-radius1:radius1
           if sqrt((i)^(2)+(j)^(2))<=radius1%�ڰ뾶radius��������ȡ��
               [mag,theta]=mtheta(I((xnow+i-1):(xnow+i+1),(ynow+j-1):(ynow+j+1)));%�õ��ݶȷ�ֵ�ͷ������Ϣ
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
    Main_Vice_dic{1,dot}=Main_dic;%1����������
    Main_Vice_dic{2,dot}=ave_main_deg;%2������ƽ���ǣ�������
    Main_Vice_dic{3,dot}=Vice_dic;%3��������������ֵ��
    Main_Vice_dic{4,dot}=ave_vice_deg;%4������ƽ���ǣ������
%     figure(dot)%���ӻ�
%     bar(1:36,Y)
end