function Figuras(modelo)
    hold on;
    grid on;
    ObstaculosX = modelo.obstaculoX;
    ObstaculosY = modelo.obstaculoY;
    ObstaculosR = modelo.obstaculoR;

    theta=linspace(0,2*pi,100);

    n = numel(ObstaculosX);

    % Target (Destination)
    goalx = modelo.goalX;
    goaly = modelo.goalY;
    robotX = modelo.robotX;
    robotY = modelo.robotY;
    
    axis([0, 10, 0, 10]) 

    plot(goalx,goaly,'r*','MarkerSize',15);
    plot(robotX,robotY,'b*','MarkerSize',3);

    for i = 1: n
        plot(ObstaculosX(i)+ObstaculosR(i)*cos(theta),ObstaculosY(i)+ObstaculosR(i)*sin(theta));
    end
end