for smooth_layer=1:1
    key_smooth=[];
 	smoothed_pic=img_p{smooth_layer};%ȡ��ͬƽ��������ͼƬ
    for i=1:size(keyFinalAll_radius_deducted,2)
        if keyFinalAll_radius_deducted(3,i)==smooth_layer+1%�ڶ��������Ĳ�ƽ����
           key_smooth=[key_smooth,keyFinalAll(:,i)];
        end
    end
    Main_Vice_dic_smooth=Main_Vice_dic{1,smooth_layer};
    keyCopy=key_smooth;
    for i=1:size(Main_Vice_dic_smooth,2)
        if size(Main_Vice_dic_smooth{3,i},2)==1
           if  Main_Vice_dic_smooth{3,i}~=0 %�����и�����Ĺؼ��㸴�ƶ�ݹؼ���
               newL=[keyCopy(1:3,i);Main_Vice_dic_smooth{4,i}];
               keyCopy=[keyCopy newL];
           end
        elseif size(Main_Vice_dic_smooth{3,i},2)>1
            for j=1:size(Main_Vice_dic_smooth{3,i},2)
                ff=Main_Vice_dic_smooth{4,i};
                newL=[keyCopy(1:3,i);ff(1,j)];
                keyCopy=[keyCopy newL];
            end
        end
        keyCopy(4,i)=Main_Vice_dic_smooth{2,i};%����������Ĺؼ�����ӽǶ���Ϣ
    end

    s=1+smooth_layer;
    d=4;%%%%%%%%%%%%%%����4*4
    [m1,n1]=size(smoothed_pic); %���ص���
%     radiusNew=round(3*rou_oct(s)*(d+1)/sqrt(2));
%     radiusNew=round(round(3*rou_oct(s))/sqrt(2))*(d+1);
    helicopter=round(round(3*rou_oct(s))*sqrt(2))*(d+1);
    if mod(helicopter,2)==0
        radiusNew=helicopter/2;
    else
        helicopter=helicopter+5;
        radiusNew=(helicopter-1)/2;
    end
    key_radius_deducted=[];%ɾȥ�߽紦���˵Ĺؼ���
    for i=1:size(keyCopy,2)%����δɾ�������йؼ���
        if ~((keyCopy(1,i)<=radiusNew+1)||(keyCopy(1,i)>=m1-radiusNew-1)...
                ||(keyCopy(2,i)<=radiusNew+1)||(keyCopy(2,i)>=n1-radiusNew-1))
            key_radius_deducted=[key_radius_deducted,keyCopy(:,i)];
        end
    end
    rou1=d/2;%������ȡd/2
    sigma1=2*rou1*rou1;
    for ii=1:1%size(keyNewFinal,2)
        xnow=key_radius_deducted(1,ii);
        ynow=key_radius_deducted(2,ii);
        matNew=[];
        for i=-radiusNew:radiusNew
            for j=-radiusNew:radiusNew
                   [mag,theta]=mtheta(smoothed_pic((xnow+i-1):(xnow+i+1),(ynow+j-1):(ynow+j+1)));%�õ��ݶȷ�ֵ�ͷ������Ϣ 
                   dic8=ceil(theta/45);  
                   info=[i;j;mag;theta;dic8;0];%6����Ϣ��x,y,�ݶȣ��Ƕȣ�Ȩ�أ����
                   matNew=[matNew,info];
            end
        end
        rtheta=key_radius_deducted(4,ii);
        mat_rotated=[];
        mat_newnew=[];
        for jj=1:size(matNew,2)%��ת
            rotxy=[cos(rtheta) -sin(rtheta);sin(rtheta) cos(rtheta)]*matNew(1:2,jj);
            if  sqrt((rotxy(1,1))^(2)+(rotxy(2,1))^(2))<=radiusNew
             mat_rotated = [mat_rotated rotxy];
             mat_newnew=[mat_newnew matNew(:,jj)];%ֻ����Բ���ڵĵ�
            end
        end
        Mat_rr=mat_rotated/(round(3*rou_oct(s)))+2*ones(2,size(mat_rotated,2));%��ת�����µ����������Ϣ(-2,2)���(0,4)
        mat_newnew(1:2,:)=Mat_rr;
        for mm=1:size(Mat_rr,2)
            weight=(1/(pi*sigma1))*exp(-1*((Mat_rr(1,mm)-2)^2+(Mat_rr(2,mm)-2)^2)/sigma1);%�õ��ݶ�Ȩ����Ϣ
            mat_newnew(3,mm)=weight*mat_newnew(3,mm);%���ݶ���Ϣ��˹��Ȩ
        end
    % ��ֵ����4*4*8
        for mm=1:size(Mat_rr,2)
            mat30=[];
            mat20=[];
            mat10=[];
            mat00=[];
            mat31=[];
            mat21=[];
            mat11=[];
            mat01=[];
            mat32=[];
            mat22=[];
            mat12=[];
            mat02=[];
            mat33=[];
            mat23=[];
            mat13=[];
            mat03=[];
            xx=Mat_rr(1,mm);
            yy=Mat_rr(2,mm);
            dr=ceil(xx)-xx;
            dc=yy-floor(yy);
                if ceil(xx)==2&&ceil(yy)==2
                    weightMag_lb=mat_newnew(3,mm)*(1-dr)*dc;%���½Ǽ�Ȩ
                    weightMag_rb=mat_newnew(3,mm)*(1-dr)*(1-dc);%���½Ǽ�Ȩ
                    weightMag_la=mat_newnew(3,mm)*dr*dc;%���ϽǼ�Ȩ
                    weightMag_ra=mat_newnew(3,mm)*dr*(1-dc);%���ϽǼ�Ȩ
                    mat00=[mat00 [weightMag_lb;mat_newnew(5,mm)]];
                    mat10=[mat10 [weightMag_rb;mat_newnew(5,mm)]];
                    mat01=[mat01 [weightMag_la;mat_newnew(5,mm)]];
                    mat11=[mat11 [weightMag_ra;mat_newnew(5,mm)]];
                elseif ceil(xx)==3&&ceil(yy)==2
                    weightMag_lb=mat_newnew(3,mm)*(1-dr)*dc;%���½Ǽ�Ȩ
                    weightMag_rb=mat_newnew(3,mm)*(1-dr)*(1-dc);%���½Ǽ�Ȩ
                    weightMag_la=mat_newnew(3,mm)*dr*dc;%���ϽǼ�Ȩ
                    weightMag_ra=mat_newnew(3,mm)*dr*(1-dc);%���ϽǼ�Ȩ
                    mat10=[mat10 [weightMag_lb;mat_newnew(5,mm)]];
                    mat20=[mat20 [weightMag_rb;mat_newnew(5,mm)]];
                    mat11=[mat11 [weightMag_la;mat_newnew(5,mm)]];
                    mat21=[mat21 [weightMag_ra;mat_newnew(5,mm)]];
                elseif ceil(xx)==4&&ceil(yy)==2
                    weightMag_lb=mat_newnew(3,mm)*(1-dr)*dc;%���½Ǽ�Ȩ
                    weightMag_rb=mat_newnew(3,mm)*(1-dr)*(1-dc);%���½Ǽ�Ȩ
                    weightMag_la=mat_newnew(3,mm)*dr*dc;%���ϽǼ�Ȩ
                    weightMag_ra=mat_newnew(3,mm)*dr*(1-dc);%���ϽǼ�Ȩ
                    mat20=[mat20 [weightMag_lb;mat_newnew(5,mm)]];
                    mat30=[mat30 [weightMag_rb;mat_newnew(5,mm)]];
                    mat21=[mat21 [weightMag_la;mat_newnew(5,mm)]];
                    mat31=[mat31 [weightMag_ra;mat_newnew(5,mm)]];
                elseif ceil(xx)==2&&ceil(yy)==3
                    weightMag_lb=mat_newnew(3,mm)*(1-dr)*dc;%���½Ǽ�Ȩ
                    weightMag_rb=mat_newnew(3,mm)*(1-dr)*(1-dc);%���½Ǽ�Ȩ
                    weightMag_la=mat_newnew(3,mm)*dr*dc;%���ϽǼ�Ȩ
                    weightMag_ra=mat_newnew(3,mm)*dr*(1-dc);%���ϽǼ�Ȩ
                    mat01=[mat01 [weightMag_lb;mat_newnew(5,mm)]];
                    mat11=[mat11 [weightMag_rb;mat_newnew(5,mm)]];
                    mat02=[mat02 [weightMag_la;mat_newnew(5,mm)]];
                    mat12=[mat12 [weightMag_ra;mat_newnew(5,mm)]];
                elseif ceil(xx)==3&&ceil(yy)==3
                    weightMag_lb=mat_newnew(3,mm)*(1-dr)*dc;%���½Ǽ�Ȩ
                    weightMag_rb=mat_newnew(3,mm)*(1-dr)*(1-dc);%���½Ǽ�Ȩ
                    weightMag_la=mat_newnew(3,mm)*dr*dc;%���ϽǼ�Ȩ
                    weightMag_ra=mat_newnew(3,mm)*dr*(1-dc);%���ϽǼ�Ȩ
                    mat11=[mat11 [weightMag_lb;mat_newnew(5,mm)]];
                    mat21=[mat21 [weightMag_rb;mat_newnew(5,mm)]];
                    mat12=[mat12 [weightMag_la;mat_newnew(5,mm)]];
                    mat22=[mat22 [weightMag_ra;mat_newnew(5,mm)]];
                elseif ceil(xx)==4&&ceil(yy)==3
                    weightMag_lb=mat_newnew(3,mm)*(1-dr)*dc;%���½Ǽ�Ȩ
                    weightMag_rb=mat_newnew(3,mm)*(1-dr)*(1-dc);%���½Ǽ�Ȩ
                    weightMag_la=mat_newnew(3,mm)*dr*dc;%���ϽǼ�Ȩ
                    weightMag_ra=mat_newnew(3,mm)*dr*(1-dc);%���ϽǼ�Ȩ
                    mat21=[mat21 [weightMag_lb;mat_newnew(5,mm)]];
                    mat31=[mat31 [weightMag_rb;mat_newnew(5,mm)]];
                    mat22=[mat22 [weightMag_la;mat_newnew(5,mm)]];
                    mat32=[mat32 [weightMag_ra;mat_newnew(5,mm)]];
                elseif ceil(xx)==2&&ceil(yy)==4
                    weightMag_lb=mat_newnew(3,mm)*(1-dr)*dc;%���½Ǽ�Ȩ
                    weightMag_rb=mat_newnew(3,mm)*(1-dr)*(1-dc);%���½Ǽ�Ȩ
                    weightMag_la=mat_newnew(3,mm)*dr*dc;%���ϽǼ�Ȩ
                    weightMag_ra=mat_newnew(3,mm)*dr*(1-dc);%���ϽǼ�Ȩ
                    mat02=[mat02 [weightMag_lb;mat_newnew(5,mm)]];
                    mat12=[mat12 [weightMag_rb;mat_newnew(5,mm)]];
                    mat03=[mat03 [weightMag_la;mat_newnew(5,mm)]];
                    mat13=[mat13 [weightMag_ra;mat_newnew(5,mm)]];
                elseif ceil(xx)==3&&ceil(yy)==4
                    weightMag_lb=mat_newnew(3,mm)*(1-dr)*dc;%���½Ǽ�Ȩ
                    weightMag_rb=mat_newnew(3,mm)*(1-dr)*(1-dc);%���½Ǽ�Ȩ
                    weightMag_la=mat_newnew(3,mm)*dr*dc;%���ϽǼ�Ȩ
                    weightMag_ra=mat_newnew(3,mm)*dr*(1-dc);%���ϽǼ�Ȩ
                    mat12=[mat12 [weightMag_lb;mat_newnew(5,mm)]];
                    mat22=[mat22 [weightMag_rb;mat_newnew(5,mm)]];
                    mat13=[mat13 [weightMag_la;mat_newnew(5,mm)]];
                    mat23=[mat23 [weightMag_ra;mat_newnew(5,mm)]];
                elseif ceil(xx)==4&&ceil(yy)==4
                    weightMag_lb=mat_newnew(3,mm)*(1-dr)*dc;%���½Ǽ�Ȩ
                    weightMag_rb=mat_newnew(3,mm)*(1-dr)*(1-dc);%���½Ǽ�Ȩ
                    weightMag_la=mat_newnew(3,mm)*dr*dc;%���ϽǼ�Ȩ
                    weightMag_ra=mat_newnew(3,mm)*dr*(1-dc);%���ϽǼ�Ȩ
                    mat22=[mat22 [weightMag_lb;mat_newnew(5,mm)]];
                    mat32=[mat32 [weightMag_rb;mat_newnew(5,mm)]];
                    mat23=[mat23 [weightMag_la;mat_newnew(5,mm)]];
                    mat33=[mat33 [weightMag_ra;mat_newnew(5,mm)]];
                elseif ceil(xx)==2&&ceil(yy)==1
                    weightMag_la=mat_newnew(3,mm)*dr*dc;%���ϽǼ�Ȩ
                    weightMag_ra=mat_newnew(3,mm)*dr*(1-dc);%���ϽǼ�Ȩ
                    mat00=[mat00 [weightMag_la;mat_newnew(5,mm)]];
                    mat10=[mat10 [weightMag_ra;mat_newnew(5,mm)]];
                elseif ceil(xx)==3&&ceil(yy)==1
                    weightMag_la=mat_newnew(3,mm)*dr*dc;%���ϽǼ�Ȩ
                    weightMag_ra=mat_newnew(3,mm)*dr*(1-dc);%���ϽǼ�Ȩ
                    mat10=[mat10 [weightMag_la;mat_newnew(5,mm)]];
                    mat20=[mat20 [weightMag_ra;mat_newnew(5,mm)]];
                elseif ceil(xx)==4&&ceil(yy)==1
                    weightMag_la=mat_newnew(3,mm)*dr*dc;%���ϽǼ�Ȩ
                    weightMag_ra=mat_newnew(3,mm)*dr*(1-dc);%���ϽǼ�Ȩ
                    mat20=[mat20 [weightMag_la;mat_newnew(5,mm)]];
                    mat30=[mat30 [weightMag_ra;mat_newnew(5,mm)]];
                elseif ceil(xx)==1&&ceil(yy)==2                
                    weightMag_rb=mat_newnew(3,mm)*(1-dr)*(1-dc);%���½Ǽ�Ȩ
                    weightMag_ra=mat_newnew(3,mm)*dr*(1-dc);%���ϽǼ�Ȩ
                    mat00=[mat00 [weightMag_rb;mat_newnew(5,mm)]];
                    mat01=[mat01 [weightMag_ra;mat_newnew(5,mm)]];
                elseif ceil(xx)==1&&ceil(yy)==3                
                    weightMag_rb=mat_newnew(3,mm)*(1-dr)*(1-dc);%���½Ǽ�Ȩ
                    weightMag_ra=mat_newnew(3,mm)*dr*(1-dc);%���ϽǼ�Ȩ
                    mat01=[mat01 [weightMag_rb;mat_newnew(5,mm)]];
                    mat02=[mat02 [weightMag_ra;mat_newnew(5,mm)]];
                elseif ceil(xx)==1&&ceil(yy)==4                
                    weightMag_rb=mat_newnew(3,mm)*(1-dr)*(1-dc);%���½Ǽ�Ȩ
                    weightMag_ra=mat_newnew(3,mm)*dr*(1-dc);%���ϽǼ�Ȩ
                    mat02=[mat02 [weightMag_rb;mat_newnew(5,mm)]];
                    mat03=[mat03 [weightMag_ra;mat_newnew(5,mm)]];
                elseif ceil(xx)==2&&ceil(yy)==5  
                    weightMag_lb=mat_newnew(3,mm)*(1-dr)*dc;%���½Ǽ�Ȩ
                    weightMag_rb=mat_newnew(3,mm)*(1-dr)*(1-dc);%���½Ǽ�Ȩ
                    mat03=[mat03 [weightMag_lb;mat_newnew(5,mm)]];
                    mat13=[mat13 [weightMag_rb;mat_newnew(5,mm)]];
                elseif ceil(xx)==3&&ceil(yy)==5  
                    weightMag_lb=mat_newnew(3,mm)*(1-dr)*dc;%���½Ǽ�Ȩ
                    weightMag_rb=mat_newnew(3,mm)*(1-dr)*(1-dc);%���½Ǽ�Ȩ
                    mat13=[mat13 [weightMag_lb;mat_newnew(5,mm)]];
                    mat23=[mat23 [weightMag_rb;mat_newnew(5,mm)]];
                elseif ceil(xx)==4&&ceil(yy)==5  
                    weightMag_lb=mat_newnew(3,mm)*(1-dr)*dc;%���½Ǽ�Ȩ
                    weightMag_rb=mat_newnew(3,mm)*(1-dr)*(1-dc);%���½Ǽ�Ȩ
                    mat23=[mat23 [weightMag_lb;mat_newnew(5,mm)]];
                    mat33=[mat33 [weightMag_rb;mat_newnew(5,mm)]];
                elseif ceil(xx)==5&&ceil(yy)==2
                    weightMag_lb=mat_newnew(3,mm)*(1-dr)*dc;%���½Ǽ�Ȩ
                    weightMag_la=mat_newnew(3,mm)*dr*dc;%���ϽǼ�Ȩ
                    mat30=[mat30 [weightMag_lb;mat_newnew(5,mm)]];
                    mat31=[mat31 [weightMag_la;mat_newnew(5,mm)]];
                elseif ceil(xx)==5&&ceil(yy)==3
                    weightMag_lb=mat_newnew(3,mm)*(1-dr)*dc;%���½Ǽ�Ȩ
                    weightMag_la=mat_newnew(3,mm)*dr*dc;%���ϽǼ�Ȩ
                    mat31=[mat31 [weightMag_lb;mat_newnew(5,mm)]];
                    mat32=[mat32 [weightMag_la;mat_newnew(5,mm)]];
                elseif ceil(xx)==5&&ceil(yy)==3
                    weightMag_lb=mat_newnew(3,mm)*(1-dr)*dc;%���½Ǽ�Ȩ
                    weightMag_la=mat_newnew(3,mm)*dr*dc;%���ϽǼ�Ȩ
                    mat32=[mat32 [weightMag_lb;mat_newnew(5,mm)]];
                    mat33=[mat33 [weightMag_la;mat_newnew(5,mm)]];
                elseif ceil(xx)==1&&ceil(yy)==1
                    weightMag_ra=mat_newnew(3,mm)*dr*(1-dc);%���ϽǼ�Ȩ
                    mat00=[mat00 [weightMag_ra;mat_newnew(5,mm)]];
                elseif ceil(xx)==1&&ceil(yy)==5  
                    weightMag_rb=mat_newnew(3,mm)*(1-dr)*(1-dc);%���½Ǽ�Ȩ
                    mat03=[mat03 [weightMag_rb;mat_newnew(5,mm)]];
                elseif ceil(xx)==5&&ceil(yy)==1  
                    weightMag_la=mat_newnew(3,mm)*dr*dc;%���ϽǼ�Ȩ
                    mat30=[mat30 [weightMag_la;mat_newnew(5,mm)]];
                elseif ceil(xx)==5&&ceil(yy)==5  
                    weightMag_lb=mat_newnew(3,mm)*(1-dr)*dc;%���½Ǽ�Ȩ
                    mat33=[mat22 [weightMag_lb;mat_newnew(5,mm)]];
                end
        end
        may_dic128=zeros(1,128);
        mat_dic8=zeros(1,8);
        for mm=1:size(mat00,2)
            dic8=mat00(2,mm);
            if dic8==0||dic8==8
                mat_dic8(1,8)=mat_dic8(1,8)+mat00(1,mm);
            elseif dic==1
                mat_dic8(1,1)=mat_dic8(1,1)+mat00(1,mm);
            elseif dic==2
                mat_dic8(1,2)=mat_dic8(1,2)+mat00(1,mm);
            elseif dic==3
                mat_dic8(1,3)=mat_dic8(1,3)+mat00(1,mm);
            elseif dic==4
                mat_dic8(1,4)=mat_dic8(1,4)+mat00(1,mm);
            elseif dic==5
                mat_dic8(1,5)=mat_dic8(1,5)+mat00(1,mm);
            elseif dic==6
                mat_dic8(1,6)=mat_dic8(1,6)+mat00(1,mm);
            elseif dic==7
                mat_dic8(1,7)=mat_dic8(1,7)+mat00(1,mm);
            end
        end
    end       
end
                    
                    
                    
                    
   