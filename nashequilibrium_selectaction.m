function [a1,a2] = nashequilibrium(A1,B1,n,N_max)
%给定两个agent的报酬矩阵，求解纳什均衡

epsilon = 0.01;

for i = 1:4
    for j = 1:4
        A (i,j) = A1(1,i,j);
        B (i,j) = B1(1,i,j);
    end
end

%如果都是0就随机选择，否则求解PNE
if (sum(sum(A == zeros(4,4))) == 16) && (sum(sum(B == zeros(4,4))) == 16)
    a1 = ceil(rand(1)*4);
    a2 = ceil(rand(1)*4);
else
%求解PNE和EDSP
    flag1 = zeros(size(A));
    flag2 = zeros(size(B));
    y = zeros(1,4);
    for i = 1:4
        flag1(:,i) = (A(:,i) == max(A(:,i)));
        flag2(i,:) = (B(i,:) == max(B(i,:)));
    end
    flag = flag1 + flag2;
    %纯策略纳什均衡
    [PNE1 PNE2] = find(flag == 2);

    if ~isempty(PNE1)   
        %存在PNE则进一步求出non-strict EDSP
        flagminA = 1000000;
        flagminB = 1000000;
        for i = 1:length(PNE1)
            if A(PNE1(i),PNE2(i)) < flagminA
                flagminA = A(PNE1(i),PNE2(i));
            end
            if B(PNE1(i),PNE2(i)) < flagminB
                flagminB = B(PNE1(i),PNE2(i));
            end      
        end
                
        %求得non-strict EDSP + PNE的集合
        [NS_EDSP1 NS_EDSP2] = ind2sub(size(A),find(A >= flagminA & B >= flagminB));     
        
        %1. 设定和的阈值：所有解的平均值；2. 选取方差最小的解
        NS_EDSP = zeros(2,length(NS_EDSP1));
        for i = 1: length(NS_EDSP1)
            NS_EDSP(1,i) = A(NS_EDSP1(i),NS_EDSP2(i));
            NS_EDSP(2,i) = B(NS_EDSP1(i),NS_EDSP2(i));
        end
        MeanSum = mean(mean(NS_EDSP)) * 2;
        %初始化均衡点
        NE_Point = [NS_EDSP1(1),NS_EDSP2(1)];
        flagmax = 1000;
        for i = 1: length(NS_EDSP1)
            Ra = A(NS_EDSP1(i),NS_EDSP2(i));
            Rb = B(NS_EDSP1(i),NS_EDSP2(i));
            if (Ra + Rb) >= MeanSum
                if abs(Ra - Rb) < flagmax
                    flagmax = abs(Ra - Rb);
                    NE_Point = [NS_EDSP1(i),NS_EDSP2(i)];
                end
            end
        end
        %****************************** 
       
    else
        %没有纯纳什均衡时求解Meta均衡
        [MetaA,MetaB] = MetaEquilibrium(A,B);
        [MetaQ1,MetaQ2] = ind2sub(size(A),find(A >= MetaA & B >= MetaB));

        %1. 设定和的阈值：所有解的平均值；2. 选取方差最小的解
        Meta = zeros(2,length(MetaQ1));
        for i = 1: length(MetaQ1)
            Meta(1,i) = A(MetaQ1(i),MetaQ2(i));
            Meta(2,i) = B(MetaQ1(i),MetaQ2(i));
        end
        MeanSum = mean(mean(Meta)) * 2;
        %初始化均衡点
        NE_Point = [MetaQ1(1),MetaQ2(1)];
        flagmax = 1000;
        for i = 1: length(MetaQ1)
            Ra = A(MetaQ1(i),MetaQ2(i));
            Rb = B(MetaQ1(i),MetaQ2(i));
            if (Ra + Rb) >= MeanSum
                if abs(Ra - Rb) < flagmax
                    flagmax = abs(Ra - Rb);
                    NE_Point = [MetaQ1(i),MetaQ2(i)];
                end
            end
        end
        %****************************** 
    end

%E-Greedy选择策略。转赌盘方法
x = ones(4);
x = x * epsilon/16;
x (NE_Point(1),NE_Point(2)) = (1 - epsilon) + x (NE_Point(1),NE_Point(2));

xselect = zeros(1,16);
xselect(1) = x(1,1);
for i = 1:4
    for j = 1:4
        if (i-1)*4+j ~= 1
            xselect((i-1)*4+j) = xselect((i-1)*4+j-1)+x(i,j);
        end
    end
end
random = xselect(16)*rand(1);
for k = 1:16
    if (random <= xselect(k))
        a1 = floor((k-1)/4)+1;
        a2 = k - (a1 - 1) * 4;
        break;
    end
end
end    
end