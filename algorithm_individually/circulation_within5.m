function [issuccessful_within5,circle,key_x,key_y]=circulation_within5(smoothed_pic,m1,n1,window_now,key_x,key_y)
      circle=0;
      while circle<=5 %�������岻
          dz=diffxy(window_now);
          if isnan(dz(1,1))||isnan(dz(2,1))%�жϾ�������
              circle=1000;%%�������1000����������
%               disp("Hesian�������죬����������ɾ���ؼ���")
              break
          end

          [M,p]=max(abs(dz));
          if M<=0.5 %���ƶ�
              core=window_now(2,2);
%               disp(strcat(strcat("����",num2str(circle-1)),"�ε���"))
%               disp([strcat(strcat("��",num2str(j)),"���ؼ������꼰����ֵΪ"),...
%                   num2str(keyI(1:2,j)'),num2str(core)])
              break
          elseif p==1 %xyλ��Ϊ1��x�����ƶ�
                  if dz(1,1)>0 %������x������
                      if (key_x+2)<=m1 %������x�����ұ߽�
                          key_x=key_x+1;
                          window_now=smoothed_pic((key_x-1):(key_x+1),(key_y-1):(key_y+1));
                      else
                          circle=100;%�������101�������߽�
                      end
                 
                  else %С����x������
                      if (key_x-2)>=1 %������x������߽�
                          key_x=key_x-1;           
                          window_now=smoothed_pic((key_x-1):(key_x+1),(key_y-1):(key_y+1));
                      else
                          circle=100;
                      end
                  end
          elseif p==2 %λ��Ϊ2��y�����ƶ�
                  if dz(2,1)>0  %������y������
                      if (key_y+2)<=n1 %������y�����ϱ߽�
                          key_y=key_y+1;
                          window_now=smoothed_pic((key_x-1):(key_x+1),(key_y-1):(key_y+1));
                      else
                          circle=100;
                      end
                  else %С����y������
                      if (key_y-2)>=1 %������y�������±߽�
                          key_y=key_y-1;    
                          window_now=smoothed_pic((key_x-1):(key_x+1),(key_y-1):(key_y+1));
                      else
                          circle=100;
                      end
                  end
          end
          circle=circle+1;
      end
      
if circle>=0&&circle<=5%�岽���ڵ����н�����ɹ����롾2-4��
    issuccessful_within5=1;
else
    issuccessful_within5=0;
    key_x=0;key_y=0;
end
