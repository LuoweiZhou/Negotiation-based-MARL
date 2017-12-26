%% MARL: CQ + NegoQ transfer %%
%function y=MARL_CQandMaxVarianceNegoQTransfer()
clc;clear;
for iterations=1:10
    iterations
%输入地图
%地图值，地图大小，起点，终点，最大episode，最大步长
[maze,map_size,map_start,map_goal,N_max,step_max] = map_PENTAGON();
MazeLength = map_size(1);MazeWidth = map_size(2);MazeState = map_size(3);
x_begin1 = map_start(1,1);
y_begin1 = map_start(1,2);
x_begin2 = map_start(2,1);
y_begin2 = map_start(2,2);
x_end1 = map_goal(1,1);
y_end1 = map_goal(1,2);
x_end2 = map_goal(2,1);
y_end2 = map_goal(2,2);
%***

%参数
steps=zeros(1,N_max);%每次学习达到终点所用步数
steps1=0;
steps2=0;
RewardPerStep1=zeros(1,N_max);
RewardPerStep2=zeros(1,N_max);
stop_flag=0;%如果步数50次不变就跳出循环
discount=0.9;%折扣因子
elpha_index = 0.1;
Coordinate_max = 1000;
%***

%初始化
statevalue1=zeros(MazeWidth,MazeLength,MazeState);%所有点的状态数值
statevalue2=zeros(MazeWidth,MazeLength,MazeState);%所有点的状态数值
statevalue1=QL(x_begin1,y_begin1,x_end1,y_end1,map_size,maze,N_max,step_max);%用Single QL初始化
statevalue2=QL(x_begin2,y_begin2,x_end2,y_end2,map_size,maze,N_max,step_max);

JointStateActionMark1 = zeros(Coordinate_max,6);%标记coordination的联合状态动作对:位置对，动作对
JointLocation = 0;%记录当前JointState的位置

QJointValue1 = zeros(Coordinate_max,MazeState,MazeState);%记录agent1拓展的状态动作空间Q值。用CoordinationTransfer初始化
QJointValue2 = zeros(Coordinate_max,MazeState,MazeState);%记录agent2拓展的状态动作空间Q值。用CoordinationTransfer初始化

avereward1=zeros(1,N_max);
avereward2=zeros(1,N_max);
%***

for n=1:N_max
    reward=-1;
    i1=x_begin1;j1=y_begin1;
    i2=x_begin2;j2=y_begin2;    
    goal1=0;
    goal2=0;
    steps1 = step_max;%如果没有到终点各自都是step_max
    steps2 = step_max;
    for s=1:step_max
        %elpha=elpha_index/(0.01*s + 1);
        elpha = 0.1;
        %各种情况下选择策略
        %先选策略，当发生冲突时再协调
        action1=randaction( statevalue1,i1,j1,n,N_max );
        action2=randaction( statevalue2,i2,j2,n,N_max );
        
        %ismember判断一个向量是否属于一个矩阵
        [tf,loc] = ismember([i1,j1,i2,j2,action1,action2],JointStateActionMark1,'rows');
        
        if StateActionClassifier(i1,j1,i2,j2,action1,action2) & ~tf
            JointLocation = JointLocation + 1;
            JointStateActionMark1(JointLocation,:) = [i1,j1,i2,j2,action1,action2];%将该状态标记
            %如何初始化？
            [TransferQValue1,TransferQValue2] = CoordinationTransfer(i1,j1,i2,j2);
            AddQValue = zeros(4,4);
            AddQValue(1,:) = statevalue1(i1,j1,1) * ones(1,4);
            AddQValue(2,:) = statevalue1(i1,j1,2) * ones(1,4);
            AddQValue(3,:) = statevalue1(i1,j1,3) * ones(1,4);
            AddQValue(4,:) = statevalue1(i1,j1,4) * ones(1,4);
            QJointValue1(JointLocation,:,:) = TransferQValue1 + AddQValue;%初始化joint state Q value
            AddQValue(:,1) = statevalue2(i2,j2,1) * ones(4,1);
            AddQValue(:,2) = statevalue2(i2,j2,2) * ones(4,1);
            AddQValue(:,3) = statevalue2(i2,j2,3) * ones(4,1);
            AddQValue(:,4) = statevalue2(i2,j2,4) * ones(4,1);
            QJointValue2(JointLocation,:,:) = TransferQValue2 + AddQValue;   
            
            tf = 1;%此时联合状态动作加入Coordination中
            loc = JointLocation;
            [action1,action2] = nashequilibrium_selectaction(QJointValue1(JointLocation,:,:),QJointValue2(JointLocation,:,:));            
        elseif tf
            [action1,action2] = nashequilibrium_selectaction(QJointValue1(loc,:,:),QJointValue2(loc,:,:));       
        %2. 不需要coordination时
        end
        
        action = [action1,action2];%联合动作向量
        state1 = [i1,j1];
        state2 = [i2,j2];
        
        %Reward是联合奖励，NextState是下一时刻联合状态
        [reward,NextState1,NextState2] = TransitionF(state1,state2,action,maze,map_size,map_goal,[goal1,goal2]);          
        %更新Q值
        %记录奖励值
        %更新状态
        if ~goal1
            statevalue1(i1,j1,action1) = elpha * (reward(1) + discount * max(statevalue1(NextState1(1),NextState1(2),:))) + (1 - elpha) * statevalue1(i1,j1,action1);
            if tf
                QJointValue1(loc,action1,action2) = elpha*(reward(1) + discount*max(statevalue1(NextState1(1),NextState1(2),:))) + (1 - elpha)*QJointValue1(loc,action1,action2); 
            end
            avereward1(n) = avereward1(n) + reward(1); 
            i1 = NextState1(1);j1 = NextState1(2);
        end
        
        if ~goal2
            statevalue2(i2,j2,action2) = elpha * (reward(2) + discount * max(statevalue2(NextState2(1),NextState2(2),:))) + (1 - elpha) * statevalue2(i2,j2,action2);
            if tf
                QJointValue2(loc,action1,action2) = elpha*(reward(2) + discount*max(statevalue2(NextState2(1),NextState2(2),:))) + (1 - elpha)*QJointValue2(loc,action1,action2);
            end
            avereward2(n) = avereward2(n) + reward(2);
            i2 = NextState2(1);j2 = NextState2(2);
        end
        
        if reward(1) == 100
            goal1 = 1;
            steps1 = s;
        end
        if reward(2) == 100
            goal2 = 1;
            steps2 = s;
        end
        
        if goal1*goal2 % if they all have arrived at their goals, jump out
            break;
        end    
    end 
%     if ~(n/100 - ceil(n/100))
%         [n s]
%     end
    steps(n)=s;
    RewardPerStep1(n)=avereward1(n)/steps1;
    RewardPerStep2(n)=avereward2(n)/steps2;
end
    y = steps(n);
%      axis([0,N_max,0,step_max]);
%      subplot(2,1,1)
%      plot(1:n,avereward1(1:n));
%      xlabel('episodes');
%      ylabel('rewards for each episode')
%      axis([0,N_max,0,100]);
%      subplot(2,1,2)
%      plot(1:n,avereward2(1:n));
%      xlabel('episodes');
%      ylabel('rewards for each episode')
%      axis([0,N_max,0,100]);
%      
%      figure(2)   
%      plot(1:n,steps(1:n));
%      xlabel('episodes');
%      ylabel('steps to goal');
%      %axis([0,N_max,0,step_max]);

% 统计作图
     y1(iterations,:)=avereward1;
     y2(iterations,:)=avereward2;
     y3(iterations,:)=steps;
     y4(iterations,:)=RewardPerStep1;
     y5(iterations,:)=RewardPerStep2;     
end

 % 求横向纵向平均值
%      for i=1:20
%        for j=1:20
%         temp1(j,:)=y4(j,100*(i-1)+1:100*i);
%         temp2(j,:)=y5(j,100*(i-1)+1:100*i);
%         temp3(j,:)=y3(j,100*(i-1)+1:100*i);
%         result1(i)=mean(temp1(:));
%         result2(i)=mean(temp2(:));
%         result3(i)=mean(temp3(:));
%       end
%      end
%      
%      figure(1) 
%      plot(1:20,result1,'r');
%      xlabel('episodes(×100)');
%      ylabel('average reward')
%      hold on;
%      plot(1:20,result2,'g');
%      xlabel('episodes(×100)');
%      ylabel('average reward')
%     
%      
%      figure(2)   
%      plot(1:20,result3);
%      xlabel('episodes(×100)');
%      ylabel('average step');
%      axis([0,N_max,0,step_max]);