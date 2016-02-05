classdef prod_solar_beta < comp_blueprint
    properties
        nvars = 1;
        flow_names = {'DC_BETA OUT'};        
        capex = 3000;
        opex = 5;   
        response_time = 0;
        class = 'prod';
    end
    
    methods
        function obj = prod_solar_beta(comp,CF,timesteps)
            obj.CF = CF;
            obj.component = comp;
            obj.timesteps = timesteps;
            
            obj.IC = 5000;
            
            obj.rows = obj.timesteps;
            obj.cols = obj.timesteps + 1;
            
            obj.in = [];
            obj.out = obj.dc_beta;
            obj.response_factor = obj.responseFactor();
        end
    end
end