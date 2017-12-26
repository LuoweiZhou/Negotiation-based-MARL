function y = StateActionClassifier(i1,j1,i2,j2,action1,action2)
%对危险的状态进行标记。
%此处的联合状态包括所有agent的状态
P_i1 = i1;
P_j1 = j1;
P_i2 = i2;
P_j2 = j2;

switch(action1)
    case 1
        i1 = i1 - 1;
    case 2
        i1 = i1 + 1;
    case 3
        j1 = j1 - 1;
    case 4
        j1 = j1 + 1;
end

switch(action2)
    case 1
        i2 = i2 - 1;
    case 2
        i2 = i2 + 1;
    case 3
        j2 = j2 - 1;
    case 4
        j2 = j2 + 1;
end


if (i1 == i2) && (j1 == j2)
    y = 1;
elseif (i1 == P_i2 && j1 == P_j2 && i2 == P_i1 && j2 == P_j1)
    y = 1;  
else
    y = 0;
end