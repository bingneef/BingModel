classdef prod_coal < comp_blueprint
    properties
        nvars = 2;
        flow_names = {'AC OUT','HEAT25 OUT'};        
        capex = 5;
        opex = 1;   
        response_time = 1;
        class = 'prod';
    end
    
    methods
        function obj = prod_coal(comp,CF,timesteps)
            obj.CF = CF;
            obj.component = comp;
            obj.timesteps = timesteps;
            
            obj.rows = obj.timesteps;
            obj.cols = obj.timesteps*obj.nvars + 1;
            
            obj.in = [];
            obj.out = [obj.ac, obj.heat_25];
            
            obj.ratio_in = [];
            obj.ratio_out = [1,2];
            obj.response_factor = obj.responseFactor();
        end
    end
end