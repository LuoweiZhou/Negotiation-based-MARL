%% Transition function, return reward and next state%%
function [reward,NextState1,NextState2] = TransitionF(state1,state2,action,maze,map_size,map_goal,GoalFlag)       

%���жϳ�����ײ�����ж��Ƿ��յ㣬���Ϊһ�����
%���һ��agent���磬ֻ�����agent����ԭ�����ͷ����϶���״̬��ȫ��ͬ
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

MazeLength = map_size(1);MazeWidth = map_size(2);MazeState = map_size(3);
x_end1 = map_goal(1,1);
y_end1 = map_goal(1,2);
x_end2 = map_goal(2,1);
y_end2 = map_goal(2,2);

if ~GoalFlag(1)
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
end

if ~GoalFlag(2)
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
end

if GoalFlag(1)
    reward(1) = 0;
    NextState1(1) = P_i1;NextState1(2) = P_j1;
elseif (i1 < 1) || (i1 > MazeWidth) || (j1 < 1) || (j1 > MazeLength) || (maze(i1,j1) == 1)
    reward(1) = -10;
    NextState1(1) = P_i1;NextState1(2) = P_j1;
elseif (i1 == i2) && (j1 == j2)
    reward(1) = -10;
    NextState1(1) = P_i1;NextState1(2) = P_j1;
elseif (i1 == P_i2 && j1 == P_j2 && i2 == P_i1 && j2 == P_j1)
    reward(1) = -10;
    NextState1(1) = P_i1;NextState1(2) = P_j1;   
elseif (i1 == x_end1) && (j1 == y_end1)
    reward(1) = 100;
    NextState1(1) = i1;NextState1(2) = j1; 
else
    reward(1) = -1;
    NextState1(1) = i1;NextState1(2) = j1;     
end

if GoalFlag(2)
    reward(2) = 0;
    NextState2(1) = P_i2;NextState2(2) = P_j2;
elseif (i2 < 1) || (i2 > MazeWidth) || (j2 < 1) || (j2 > MazeLength) || (maze(i2,j2) == 1)
    reward(2) = -10;
    NextState2(1) = P_i2;NextState2(2) = P_j2;
elseif (i2 == i1) && (j2 == j1)
    reward(2) = -10;
    NextState2(1) = P_i2;NextState2(2) = P_j2;
elseif (i2 == P_i1 && j2 == P_j1 && i1 == P_i2 && j1 == P_j2)
    reward(2) = -10;
    NextState2(1) = P_i2;NextState2(2) = P_j2;   
elseif (i2 == x_end2) && (j2 == y_end2)
    reward(2) = 100;
    NextState2(1) = i2;NextState2(2) = j2; 
else
    reward(2) = -1;
    NextState2(1) = i2;NextState2(2) = j2;     
end

%�����������������ײ
if NextState1(1) == NextState2(1) && NextState1(2) == NextState2(2)
    reward(1) = -10;
    reward(2) = -10;
    NextState1(1) = P_i1;
    NextState2(1) = P_i2;
    NextState1(2) = P_j1;
    NextState2(2) = P_j2;
end

end