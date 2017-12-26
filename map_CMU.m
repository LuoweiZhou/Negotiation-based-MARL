function [map,size,start,goal,N_max,step_max] = map_CMU()
    %仓储地图构建。map表示地图，size表示尺寸
    %start表示各agent起点，每个agent一行
    %goal表示各agent终点，每个agent一行
    %最佳为12步
    
    MazeLength = 34;
    MazeWidth = 7;
    MazeState = 4;

    x_begin1 = 7;%A起始节点
    y_begin1 = 4;
    x_end1 = 7;%A终止节点
    y_end1 = 33;
    
    x_begin2 = 7;%B起始节点
    y_begin2 = 33;
    x_end2 = 7;%B终止节点
    y_end2 = 4;
    
    maze = [1,1,1,0,1,0,1,0,1,0,1,0,1,0,1,1,1,1,1,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1;
            1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
            1,1,1,1,1,0,1,0,1,0,1,0,1,0,1,0,1,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1;
            1,1,1,1,0,0,1,1,1,1,1,1,1,1,1,0,1,1,0,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1;
            1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,0,0,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1;
            0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
            1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1];
        
    maze(x_begin1,y_begin1) = 0;
    maze(x_begin2,y_begin2) = 0;
    maze(x_end1,y_end1) = 0;
    maze(x_end2,y_end2) = 0;
    map = maze(:,:);
    size = [MazeLength,MazeWidth,MazeState];
    start = [x_begin1,y_begin1;x_begin2,y_begin2];
    goal = [x_end1,y_end1;x_end2,y_end2];
    N_max = 4000;
    step_max = 2000;