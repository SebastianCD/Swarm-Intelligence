function [x,y] = MiPSO(model,obs)
    CostFunction = @(x, obs) fun(x, obs, model);
    
    nVar = 1;
     
    VarMin.x = model.robotX + 0.1;
    VarMax.x = model.robotX + 0.3;
    VarMin.y = model.robotY - 0.2;
    VarMax.y = model.robotY + 0.2;
    
    MaxIt = 10;
    numeroParticulas = 100;
    w = 1;
    c1 = 1;
    c2 = 1;
    w2= 0.99;
   
    alpha = 1;
    VelMax.x = alpha*(VarMax.x-VarMin.x);
    VelMin.x = -VelMax.x;                    
    VelMax.y = alpha*(VarMax.y-VarMin.y);    
    VelMin.y = -VelMax.y;                   
    
    plantillaParticulas.posicion = [];
    plantillaParticulas.velocidad = [];
    plantillaParticulas.costo = [];
    plantillaParticulas.mejor.posicion = [];
    plantillaParticulas.mejor.costo = [];

    particula = repmat(plantillaParticulas,numeroParticulas,1);

    GlobalBest.costo = inf;

    for i = 1: numeroParticulas
        
        particula(i).posicion = SolucionAleatoria(VarMin,VarMax);

        particula(i).velocidad.x = zeros(nVar);
        particula(i).velocidad.y = zeros(nVar);
        
        particula(i).costo = CostFunction(particula(i).posicion, obs);
        
        particula(i).mejor.posicion = particula(i).posicion;
        particula(i).mejor.costo = particula(i).costo;
        
        if particula(i).mejor.costo < GlobalBest.costo
           GlobalBest = particula(i).mejor;
        end
        
    end 

    BestCost = zeros(MaxIt,1);

    for it = 1: MaxIt
        
        for i = 1: numeroParticulas
            
            r1 = rand(1);
            r2 = rand(1);
            
            velocidadCognitiva = c1 * r1.*(particula(i).mejor.posicion.x - particula(i).posicion.x); 
            velocidadSocial =  c2 * r2.*(GlobalBest.posicion.x - particula(i).posicion.x);
            particula(i).velocidad.x = w * particula(i).velocidad.x + velocidadCognitiva + velocidadSocial;
            
            particula(i).velocidad.x = max(particula(i).velocidad.x, VelMin.x);
            particula(i).velocidad.x = min(particula(i).velocidad.x, VelMax.x);
            
            particula(i).posicion.x = particula(i).posicion.x + particula(i).velocidad.x;
            
            fueraRango = (particula(i).posicion.x < VarMin.x | particula(i).posicion.x > VarMax.x);
            particula(i).velocidad.x(fueraRango) = -particula(i).velocidad.x(fueraRango);
            
            particula(i).posicion.x = max(particula(i).posicion.x, VarMin.x);
            particula(i).posicion.x = min(particula(i).posicion.x, VarMax.x);
            
            r1 = rand(1);
            r2 = rand(1);
            
            velocidadCognitiva = c1 * r1.*(particula(i).mejor.posicion.y - particula(i).posicion.y); 
            velocidadSocial =  c2 * r2.*(GlobalBest.posicion.y - particula(i).posicion.y);
            particula(i).velocidad.y = w * particula(i).velocidad.y + velocidadCognitiva + velocidadSocial;
            
            particula(i).velocidad.y = max(particula(i).velocidad.y, VelMin.y);
            particula(i).velocidad.y = min(particula(i).velocidad.y, VelMax.y);
            
            particula(i).posicion.y = particula(i).posicion.y + particula(i).velocidad.y;
            
            fueraRango = (particula(i).posicion.y < VarMin.y | particula(i).posicion.y > VarMax.y);
            particula(i).velocidad.y(fueraRango) = -particula(i).velocidad.y(fueraRango);
            
            particula(i).posicion.y = max(particula(i).posicion.y, VarMin.y);
            particula(i).posicion.y = min(particula(i).posicion.y, VarMax.y);
            
            particula(i).costo =  CostFunction(particula(i).posicion, obs);

            if particula(i).costo < particula(i).mejor.costo
                particula(i).mejor.posicion = particula(i).posicion;
                particula(i).mejor.costo = particula(i).costo;
                if particula(i).mejor.costo < GlobalBest.costo
                    GlobalBest = particula(i).mejor;
                end
            end
        end
        BestCost(it) = GlobalBest.costo;
        w = w * w2;
    end 
    x = GlobalBest.posicion.x;
    y = GlobalBest.posicion.y;
end