function Robot(x,y)
    plot(x,y,'g*','MarkerSize',15);
    modelo = CreaarModelo(x,y);

    cercania = 0.5;
    velocidad = 1;

    while modelo.robotX < modelo.goalX || modelo.robotY < modelo.goalY
        slope = (modelo.robotY - modelo.goalY)/(modelo.robotX - modelo.goalX);
        angulo = rad2deg(atan(slope));
        velocidadX = velocidad * cosd(angulo);
        velocidadY = velocidad * sind(angulo);
        modelo.robotX = modelo.robotX + velocidadX/5;
        modelo.robotY = modelo.robotY + velocidadY/5;
        for i = 1: 2
            d = abs(sqrt((modelo.robotX - modelo.obstaculoX(i)).^2+(modelo.robotY - modelo.obstaculoY(i)).^2) - modelo.obstaculoR(i));
            if d < cercania
                [modelo.robotX, modelo.robotY] = MiPSO(modelo, i);
            end
        end
        Figuras(modelo);
        pause(0.01);
    end
end