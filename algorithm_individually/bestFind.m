% function y = bestFind(I,keyI)
warning('off')
keyI_smooth_All=key1;
keyFinalAll=[];%所有经删减的关键点
for smooth_layer=1:3
    smoothed_pic=img_p{smooth_layer};%取不同平滑层
    [m1,n1]=size(smoothed_pic);%各个平滑曾图片大小
    keyI=[];
    for i=1:size(keyI_smooth_All,2)
        if keyI_smooth_All(3,i)==smooth_layer+1%第二、三、四层平滑层
            keyI=[keyI,keyI_smooth_All(:,i)];
        end
    end
    [m2,n2]=size(keyI);%各个平滑层对应关键点信息
    for j=1:n2 %一共有n2个关键点信息
        window_now=smoothed_pic((keyI(1,j)-1):(keyI(1,j)+1),(keyI(2,j)-1):(keyI(2,j)+1));
        key_x=keyI(1,j);
        key_y=keyI(2,j);
        [issuccessful_within5,circle_time,key_rx,key_ry]=circulation_within5(smoothed_pic,m1,n1,window_now,key_x,key_y);
        if issuccessful_within5==1%判断五步循环是否能合理的生成新关键点
            keyI(1,j)=key_rx;
            keyI(2,j)=key_ry;
        else%不能合理的生成新关键点
            keyI(4,j)=1;%标签为1，后续删除改列
            continue
        end
    end
    %删除重合的关键点
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
    %剔除被过滤的关键点
    for i=1:size(keyI,2)
        if keyI(4,i)~=1
            keyFinalAll=[keyFinalAll keyI(:,i)];
        end
    end
    size(keyFinalAll,2)%三层关键点数量
end