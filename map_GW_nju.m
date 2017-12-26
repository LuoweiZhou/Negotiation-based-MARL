function [map,size,start,goal,N_max,step_max] = map_GW_nju()
    %�ִ���ͼ������map��ʾ��ͼ��size��ʾ�ߴ�
    %start��ʾ��agent��㣬ÿ��agentһ��
    %goal��ʾ��agent�յ㣬ÿ��agentһ��
    
    MazeLength = 10;
    MazeWidth = 3;
    MazeState = 4;

    x_begin1 = 2;%A��ʼ�ڵ�
    y_begin1 = 2;
    x_end1 = 2;%A��ֹ�ڵ�
    y_end1 = 10;
    
    x_begin2 = 2;%B��ʼ�ڵ�
    y_begin2 = 9;
    x_end2 = 2;%B��ֹ�ڵ�
    y_end2 = 1;
    
    maze = zeros (MazeWidth,MazeLength);
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