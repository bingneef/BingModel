classdef prod_solar < comp_blueprint
    properties
        nvars = 1;
        flow_names = {'DC OUT'};        
        capex = 95.04;
        opex = 0;   
        response_time = 0;
        class = 'prod';
    end
    
    methods
        function obj = prod_solar(comp,CF,timesteps)
            obj.CF = CF;
            obj.component = comp;
            obj.timesteps = timesteps;
            
            %obj.IC = 300;
            
            obj.rows = obj.timesteps;
            obj.cols = obj.timesteps + 1;
            
            obj.in = [];
            obj.out = obj.dc;
            obj.response_factor = obj.responseFactor();
        end
    end
end