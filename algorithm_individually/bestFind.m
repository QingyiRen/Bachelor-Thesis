% function y = bestFind(I,keyI)
warning('off')
keyI_smooth_All=key1;
keyFinalAll=[];%���о�ɾ���Ĺؼ���
for smooth_layer=1:3
    smoothed_pic=img_p{smooth_layer};%ȡ��ͬƽ����
    [m1,n1]=size(smoothed_pic);%����ƽ����ͼƬ��С
    keyI=[];
    for i=1:size(keyI_smooth_All,2)
        if keyI_smooth_All(3,i)==smooth_layer+1%�ڶ��������Ĳ�ƽ����
            keyI=[keyI,keyI_smooth_All(:,i)];
        end
    end
    [m2,n2]=size(keyI);%����ƽ�����Ӧ�ؼ�����Ϣ
    for j=1:n2 %һ����n2���ؼ�����Ϣ
        window_now=smoothed_pic((keyI(1,j)-1):(keyI(1,j)+1),(keyI(2,j)-1):(keyI(2,j)+1));
        key_x=keyI(1,j);
        key_y=keyI(2,j);
        [issuccessful_within5,circle_time,key_rx,key_ry]=circulation_within5(smoothed_pic,m1,n1,window_now,key_x,key_y);
        if issuccessful_within5==1%�ж��岽ѭ���Ƿ��ܺ���������¹ؼ���
            keyI(1,j)=key_rx;
            keyI(2,j)=key_ry;
        else%���ܺ���������¹ؼ���
            keyI(4,j)=1;%��ǩΪ1������ɾ������
            continue
        end
    end
    %ɾ���غϵĹؼ���
    rows=unique(keyI','rows');
    keyI=rows';

%     figure(smooth_layer)
%     imshow(smoothed_pic);
%     for i=1:size(keyI,2)
%         hold on
%         if keyI(4,i)~=1
%             t = 0:2*pi/20:2*pi;
%             x = keyI(2,i) + 2*sin(t);
%             y = keyI(1,i) + 2*cos(t);
%             plot(x,y);
%         end
%     end
    %�޳������˵Ĺؼ���
    for i=1:size(keyI,2)
        if keyI(4,i)~=1
            keyFinalAll=[keyFinalAll keyI(:,i)];
        end
    end
    size(keyFinalAll,2)%����ؼ�������
end