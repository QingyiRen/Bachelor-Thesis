function [issuccessful_within5,circle,key_x,key_y]=circulation_within5(smoothed_pic,m1,n1,window_now,key_x,key_y)
      circle=0;
      while circle<=5 %不超过五不
          dz=diffxy(window_now);
          if isnan(dz(1,1))||isnan(dz(2,1))%判断矩阵奇异
              circle=1000;%%错误代码1000，矩阵奇异
%               disp("Hesian矩阵奇异，结束迭代，删除关键点")
              break
          end

          [M,p]=max(abs(dz));
          if M<=0.5 %不移动
              core=window_now(2,2);
%               disp(strcat(strcat("经过",num2str(circle-1)),"次迭代"))
%               disp([strcat(strcat("第",num2str(j)),"个关键点坐标及像素值为"),...
%                   num2str(keyI(1:2,j)'),num2str(core)])
              break
          elseif p==1 %xy位置为1，x方向移动
                  if dz(1,1)>0 %大于零x正方向
                      if (key_x+2)<=m1 %不超出x方向右边界
                          key_x=key_x+1;
                          window_now=smoothed_pic((key_x-1):(key_x+1),(key_y-1):(key_y+1));
                      else
                          circle=100;%错误代码101，超出边界
                      end
                 
                  else %小于零x负方向
                      if (key_x-2)>=1 %不超出x方向左边界
                          key_x=key_x-1;           
                          window_now=smoothed_pic((key_x-1):(key_x+1),(key_y-1):(key_y+1));
                      else
                          circle=100;
                      end
                  end
          elseif p==2 %位置为2，y方向移动
                  if dz(2,1)>0  %大于零y正方向
                      if (key_y+2)<=n1 %不超出y方向上边界
                          key_y=key_y+1;
                          window_now=smoothed_pic((key_x-1):(key_x+1),(key_y-1):(key_y+1));
                      else
                          circle=100;
                      end
                  else %小于零y负方向
                      if (key_y-2)>=1 %不超出y方向右下边界
                          key_y=key_y-1;    
                          window_now=smoothed_pic((key_x-1):(key_x+1),(key_y-1):(key_y+1));
                      else
                          circle=100;
                      end
                  end
          end
          circle=circle+1;
      end
      
if circle>=0&&circle<=5%五步以内迭代有结果，成功代码【2-4】
    issuccessful_within5=1;
else
    issuccessful_within5=0;
    key_x=0;key_y=0;
end
