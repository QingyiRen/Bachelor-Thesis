
for i=1:size(keyI,2)
    key11=keyI;
    key11(:,i)=[];
    [~,px_keyI,~]=intersect(key11(1,:),keyI(1,i));
    [~,py_keyI,~]=intersect(key11(2,:),keyI(2,i));
    [isnull,~,~]=intersect(px_keyI,py_keyI);
    if isempty(isnull)==1
    else
        display(i)
        display([px_keyI,py_keyI])
    end
end

    
