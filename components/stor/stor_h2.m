classdef stor_h2 < comp_blueprint
    properties
        nvars = 3;
        flow_names = {'H2 IN','H2 OUT','WASTE'};        
        capex = 0;
        opex = 0.01;   
        response_time = 0;
        capacity_ex = 1.14
        class = 'stor';
    end
    
    methods
        function obj = stor_h2(comp,CF,timesteps)
            
            obj.CF = CF;
            obj.component = comp;
            
            obj.timesteps = timesteps;
            
            obj.rows = obj.timesteps;
            obj.cols = obj.nvars * obj.timesteps + 2;
            
            obj.in = obj.h2_beta;
            obj.out = [obj.h2,obj.W];
            
            obj.ratio_in = [1];
            obj.ratio_out = [0.999;0.001];
            obj.response_factor = obj.responseFactor();
        end
    end
end