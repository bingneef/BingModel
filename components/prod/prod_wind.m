classdef prod_wind < comp_blueprint
    properties
        nvars = 1;
        flow_names = {'AC OUT'};        
        capex = 5600;
        opex = 25;   
        response_time = 0;
        class = 'prod';
    end
    
    methods
        function obj = prod_wind(comp,CF,timesteps)
            obj.CF = CF;
            obj.component = comp;
            obj.timesteps = timesteps;
            
            obj.lifetime = 20;
            %obj.IC = 80;
            
            obj.rows = obj.timesteps;
            obj.cols = obj.timesteps + 1;
            
            obj.in = [];
            obj.out = obj.ac;
            obj.response_factor = obj.responseFactor();
        end
    end
end