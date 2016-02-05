classdef prod_methane < comp_blueprint
    properties
        nvars = 1;
        flow_names = {'CH4 OUT'};        
        capex = 4400;
        opex = 25;   
        response_time = 0;
        class = 'prod';
    end
    
    methods
        function obj = prod_methane(comp,CF,timesteps)
            obj.CF = CF;
            obj.component = comp;
            obj.timesteps = timesteps;
            
            obj.lifetime = 20;
            %obj.IC = 150;
            
            obj.rows = obj.timesteps;
            obj.cols = obj.timesteps + 1;
            
            obj.in = [];
            obj.out = obj.ch4;
            obj.response_factor = obj.responseFactor();
        end
    end
end