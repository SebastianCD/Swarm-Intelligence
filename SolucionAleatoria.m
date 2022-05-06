function sol = SolucionAleatoria(VarMin, VarMax)
    xmin = VarMin.x;
    xmax = VarMax.x;
     
    ymin = VarMin.y;
    ymax = VarMax.y;

    sol.x = unifrnd(xmin,xmax);
    sol.y = unifrnd(ymin,ymax);
end