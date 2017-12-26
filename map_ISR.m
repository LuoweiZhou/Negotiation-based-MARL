function [map,size,start,goal,N_max,step_max] = map_ISR()
    %�ִ���ͼ������map��ʾ��ͼ��size��ʾ�ߴ�
    %start��ʾ��agent��㣬ÿ��agentһ��
    %goal��ʾ��agent�յ㣬ÿ��agentһ��
    %���Ϊ12��
    
    MazeLength = 9;
    MazeWidth = 10;
    MazeState = 4;

    x_begin1 = 8;%A��ʼ�ڵ�
    y_begin1 = 1;
    x_end1 = 7;%A��ֹ�ڵ�
    y_end1 = 4;
    
    x_begin2 = 7;%B��ʼ�ڵ�
    y_begin2 = 4;
    x_end2 = 8;%B��ֹ�ڵ�
    y_end2 = 1;
    
    maze = [1,0,1,0,1,0,1,0,1;
            0,0,0,0,0,0,0,0,0;
            1,0,1,1,1,1,1,0,1;
            0,0,1,1,1,1,1,0,0;
            1,0,1,1,1,1,1,0,1;
            0,0,1,1,1,1,1,0,0;
            1,0,1,0,1,1,1,0,1;
            0,0,0,0,0,0,0,0,0;
            1,1,0,0,1,0,1,0,1;
            1,1,0,0,1,1,1,1,1];
        
    maze(x_begin1,y_begin1) = 0;
    maze(x_begin2,y_begin2) = 0;
    maze(x_end1,y_end1) = 0;
    maze(x_end2,y_end2) = 0;
    map = maze(:,:);
    size = [MazeLength,MazeWidth,MazeState];
    start = [x_begin1,y_begin1;x_begin2,y_begin2];
    goal = [x_end1,y_end1;x_end2,y_end2];
    N_max = 2000;
    step_max = 2000;