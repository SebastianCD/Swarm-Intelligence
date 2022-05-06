function model=CreaarModelo(x,y)

    % Source
    robotX = x;
    robotY = y;
    
    % Target (Destination)
    goalX = 10;
    goalY = 10;
    
    obstaculoX = [3 7];
    obstaculoY = [3 7];
    obstaculoR = [1 1.8];
    
    model.robotX = robotX;
    model.robotY = robotY;
    model.goalX = goalX;
    model.goalY = goalY;
    model.obstaculoX = obstaculoX;
    model.obstaculoY = obstaculoY;
    model.obstaculoR = obstaculoR;
end