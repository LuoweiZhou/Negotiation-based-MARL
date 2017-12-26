%% Transition function, return reward and next state �հ׻��������յ㣬�޳��磬ֻ����ײ���и��ͷ�%%
function reward = TransitionF_noGoal(state1,state2,action)       

%���жϳ�����ײ�����ж��Ƿ��յ㣬���Ϊһ�����
i1 = state1(1);
j1 = state1(2);
i2 = state2(1);
j2 = state2(2);

P_i1 = state1(1);
P_j1 = state1(2);
P_i2 = state2(1);
P_j2 = state2(2);

action1 = action(1);
action2 = action(2);

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
    reward(1) = -10;
elseif (i1 == P_i2 && j1 == P_j2 && i2 == P_i1 && j2 == P_j1)
    reward(1) = -10;
else
    reward(1) = 0;   
end

if (i2 == i1) && (j2 == j1)
    reward(2) = -10;
elseif (i2 == P_i1 && j2 == P_j1 && i1 == P_i2 && j1 == P_j2)
    reward(2) = -10;
else
    reward(2) = 0;
end

end