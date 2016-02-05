classdef prod_csp < comp_blueprint
    properties
        nvars = 1;
        flow_names = {'HEAT_800 OUT'};        
        capex = 5;
        opex = 1;   
        response_time = 0;
        class = 'prod';
    end
    
    methods
        function obj = prod_csp(comp,CF,timesteps)
            obj.CF = CF;
            obj.component = comp;
            obj.timesteps = timesteps;
            
            obj.rows = obj.timesteps;
            obj.cols = obj.timesteps + 1;
            obj.IC = 100;
            
            obj.in = [];
            obj.out = obj.heat_800;
            obj.response_factor = obj.responseFactor();
        end
    end
end