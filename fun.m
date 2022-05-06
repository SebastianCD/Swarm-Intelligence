function sol = fun(posicion, i, model)
    i = i
    w1 = 0.55;
    w2 = 750;
    dRO = abs(sqrt((posicion.x - model.obstaculoX(i)).^2 + (posicion.y - model.obstaculoY(i)).^2 - model.obstaculoR(i)));
    dRG = sqrt((posicion.x - model.goalX).^2 + (posicion.y - model.goalY).^2);
    sol = w1 * dRG + w2 * (1/dRO);
end