classdef stor_c < comp_blueprint
    properties
        nvars = 3;
        flow_names = {'C IN','C OUT','WASTE'};        
        capex = 0;
        opex = 0;   
        response_time = 0;
        class = 'stor';
        capacity_ex = 0;
    end
    
    methods
        function obj = stor_c(comp,CF,timesteps)
            
            obj.CF = CF;
            obj.component = comp;
            
            obj.timesteps = timesteps;
            
            obj.rows = obj.timesteps;
            obj.cols = obj.nvars * obj.timesteps + 2;
            
            obj.in = obj.C;
            obj.out = [obj.C;obj.W];
            
            obj.ratio_in = [1];
            obj.ratio_out = [0.95;0.05];
            obj.response_factor = obj.responseFactor();
        end
    end
end