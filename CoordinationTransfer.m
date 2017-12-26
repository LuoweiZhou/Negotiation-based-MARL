%% MARL: coordination transfer %%
function [Q1,Q2] = CoordinationTransfer(i1,j1,i2,j2)
%由于环境为空，采用相对位置法记录联合状态
%agent1 - agent2 + 长或宽
%agent2 - agent3 + 长或宽
%coordination transfer
Q1 = zeros(4,4);
Q2 = zeros(4,4);
for i = 1 : 4
    for j = 1 : 4
        reward = TransitionF_noGoal([i1,j1],[i2,j2],[i,j]);
        Q1(i,j) = reward(1);
        Q2(i,j) = reward(2);
    end
end
end