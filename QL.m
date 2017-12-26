%% Q-learning %%
function y = QL(x_begin1,y_begin1,x_end1,y_end1,map_size,maze,N_max,step_max)

MazeLength = map_size(1);
MazeWidth = map_size(2);
MazeState = map_size(3);

%��������
elpha_index = 1;
steps=zeros(1,N_max);%ÿ��ѧϰ�ﵽ�յ����ò���
stop_flag=0;%�������50�β��������ѭ��
discount=0.9;%�ۿ�����
%***

%��ʼ��Qֵ��
statevalue1=zeros(MazeWidth,MazeLength,MazeState);%���е��״̬��ֵ
%***

for n=1:N_max
    reward=-1;
    i1=x_begin1;j1=y_begin1;
    goal1=0;
    for s=1:step_max
        elpha=elpha_index/(0.1*s + 1);
        action1=randaction( statevalue1,i1,j1,n,N_max );
        switch(action1) %12345�ֱ��ʾ��������ͣ
            case 1 %up
                if ((i1>1)&&(i1<MazeWidth+1)&&(j1>=1)&&(j1<MazeLength+1) && (maze(i1-1,j1)==0)) 
                    if ((i1-1)==x_end1 && j1==y_end1) 
                        goal1 = 1;
                        reward = 100;
                        statevalue1(i1,j1,1) = elpha*(reward + discount*max(statevalue1(i1-1,j1,:))) + (1 - elpha)*statevalue1(i1,j1,1);
                        i1=i1-1;
                        break;
                    else
                        reward = -1;
                        statevalue1(i1,j1,1) = elpha*(reward + discount*max(statevalue1(i1-1,j1,:))) + (1 - elpha)*statevalue1(i1,j1,1);
                        i1=i1-1;
                    end
                else
                    reward = -10;
                    statevalue1(i1,j1,1) = elpha*(reward + discount*max(statevalue1(i1,j1,:))) + (1 - elpha)*statevalue1(i1,j1,1);
                end

            case 2 %down
                if (((i1>=1)&&(i1+1)<MazeWidth+1)&&(j1>=1)&&(j1<MazeLength+1) && (maze(i1+1,j1)==0)) 
                    if ((i1+1)==x_end1 && j1==y_end1) 
                        goal1 = 1;
                        reward = 100;
                        statevalue1(i1,j1,2) = elpha*(reward + discount*max(statevalue1(i1+1,j1,:))) + (1 - elpha)*statevalue1(i1,j1,2);
                        i1=i1+1;
                        break;
                    else
                        reward = -1;
                        statevalue1(i1,j1,2) = elpha*(reward + discount*max(statevalue1(i1+1,j1,:))) + (1 - elpha)*statevalue1(i1,j1,2);
                        i1=i1+1;
                    end
                else
                    reward = -10;
                    statevalue1(i1,j1,2) = elpha*(reward + discount*max(statevalue1(i1,j1,:))) + (1 - elpha)*statevalue1(i1,j1,2);
                end
                
              case 3 %left
                if ((i1>=1)&&(i1<MazeWidth+1) &&(j1>1)&&(j1<MazeLength+1)&& (maze(i1,j1-1)==0))  
                    if (i1==x_end1 && (j1-1)==y_end1) 
                        goal1 = 1;
                        reward = 100;
                        statevalue1(i1,j1,3) = elpha*(reward + discount*max(statevalue1(i1,j1-1,:))) + (1 - elpha)*statevalue1(i1,j1,3);
                        j1=j1-1;
                        break;
                    else
                        reward = -1;
                        statevalue1(i1,j1,3) = elpha*(reward + discount*max(statevalue1(i1,j1-1,:))) + (1 - elpha)*statevalue1(i1,j1,3);
                        j1=j1-1;
                    end
                else
                    reward = -10;
                    statevalue1(i1,j1,3) = elpha*(reward + discount*max(statevalue1(i1,j1,:))) + (1 - elpha)*statevalue1(i1,j1,3);
                end          

           case 4 %right
                if ((i1>=1)&&(i1<MazeWidth+1) &&(j1>=1)&&(j1+1)<MazeLength+1 && (maze(i1,j1+1)==0))
                    if (i1==x_end1 && (j1+1)==y_end1) 
                        goal1 = 1;
                        reward = 100;
                        statevalue1(i1,j1,4) = elpha*(reward + discount*max(statevalue1(i1,j1+1,:))) + (1 - elpha)*statevalue1(i1,j1,4);
                        j1=j1+1;
                        break;
                    else
                        reward = -1;
                        statevalue1(i1,j1,4) = elpha*(reward + discount*max(statevalue1(i1,j1+1,:))) + (1 - elpha)*statevalue1(i1,j1,4);
                        j1=j1+1;
                    end
                else
                    reward = -10;
                    statevalue1(i1,j1,4) = elpha*(reward + discount*max(statevalue1(i1,j1,:))) + (1 - elpha)*statevalue1(i1,j1,4);
                end
        end  
    end 
    steps(n)=s;
    if n>50
        stop_flag=1;
        for stop_step=1:50;
            if steps(n)~=steps(n-stop_step)
                stop_flag=0;
            end
        end
    end
    if stop_flag==1
        break
    end
end
y=statevalue1;





