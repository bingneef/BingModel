classdef stor_ch4 < comp_blueprint
    properties
        nvars = 3;
        flow_names = {'CH4 IN','CH4 OUT','WASTE'};        
        capex = 0;
        opex = 0;   
        response_time = 0;
        capacity_ex = 0.15;
        class = 'stor';
    end
    
    methods
        function obj = stor_ch4(comp,CF,timesteps)
            obj.lifetime = 15;
            
            obj.CF = CF;
            obj.component = comp;
            
            obj.timesteps = timesteps;
            
            obj.rows = obj.timesteps;
            obj.cols = obj.nvars * obj.timesteps + 2;
            
            obj.in = obj.ch4;
            obj.out = [obj.ch4;obj.W];
            
            obj.ratio_in = [1];
            obj.ratio_out = [0.90;0.10];
            obj.response_factor = obj.responseFactor();
        end
    end
end