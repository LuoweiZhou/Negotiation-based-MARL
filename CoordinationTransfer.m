%% MARL: coordination transfer %%
function [Q1,Q2] = CoordinationTransfer(i1,j1,i2,j2)
%���ڻ���Ϊ�գ��������λ�÷���¼����״̬
%agent1 - agent2 + �����
%agent2 - agent3 + �����
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