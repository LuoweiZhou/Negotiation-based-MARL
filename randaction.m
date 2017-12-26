function action = randaction( p_actions,i,j,n,N_max )
%此函数用一定的概率分布决定某state的下一个行进方向
flag=-10000000;

epsilon = 0.01;

for k=1:4
    if p_actions(i,j,k)>flag
        flag=p_actions(i,j,k);
        flag_k=k;% maximum element
    end
end
x=zeros(1,4);
for k=1:4
    x(k)=epsilon/4;
    if k==flag_k
        x(k)=x(k)+1-epsilon;
    end
end

y=zeros(1,4);
y(1)=x(1);
for k=2:4
    y(k)=y(k-1)+x(k);
end
random=y(4)*rand(1);
for k=1:4
    if (random<=y(k))
        action=k;
        break;
    end
end
    
end