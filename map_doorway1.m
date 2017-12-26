function [map,size,start,goal,N_max,step_max] = map_doorway1()
    %仓储地图构建。map表示地图，size表示尺寸
    %start表示各agent起点，每个agent一行
    %goal表示各agent终点，每个agent一行
    %最佳为12步
    
    MazeLength = 5;
    MazeWidth = 5;
    MazeState = 4;

    x_begin1 = 1;%A起始节点
    y_begin1 = 1;
    x_end1 = 5;%A终止节点
    y_end1 = 5;
    
    x_begin2 = 1;%B起始节点
    y_begin2 = 5;
    x_end2 = 5;%B终止节点
    y_end2 = 1;
    
    maze = zeros (MazeWidth,MazeLength);
    maze(1,3) = 1;
    maze(2,3) = 1;
    maze(4,3) = 1;
    maze(5,3) = 1;
    maze(x_begin1,y_begin1) = 0;
    maze(x_begin2,y_begin2) = 0;
    maze(x_end1,y_end1) = 0;
    maze(x_end2,y_end2) = 0;
    map = maze(:,:);
    size = [MazeLength,MazeWidth,MazeState];
    start = [x_begin1,y_begin1;x_begin2,y_begin2];
    goal = [x_end1,y_end1;x_end2,y_end2];
    N_max = 2000;
    step_max = 5000;