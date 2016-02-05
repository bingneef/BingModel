function c = fitness(x,components,component_names)
    c = 0;
    
    for i = 1:length(component_names)
        obj = components.(char(component_names(i)));
        c = c + obj.costs(x);        
    end
    
    %obj = components.('MARKET');
    %W = obj.costs(x);
    
    obj = components.('SINK');
    W = obj.costs(x);
    
    c = c - W;