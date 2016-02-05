classdef conv_methane < comp_blueprint
    properties
        nvars = 5;
        flow_names = {'CH4 IN','HEAT_800 IN','H2 OUT','C OUT','WASTE'};        
        capex = 0;
        opex = 0;   
        response_time = 0;
        class = 'conv';
    end
    
    methods
        function obj = conv_methane(comp,CF,timesteps)
            obj.CF = CF;
            obj.component = comp;
            obj.timesteps = timesteps;
            
            obj.rows = obj.timesteps;
            obj.cols = obj.timesteps*obj.nvars + 1;
            
            obj.in = [obj.ch4;obj.heat_800];
            obj.out = [obj.h2;obj.C;obj.W];
            
            obj.ratio_in = [20005;4461];
            obj.ratio_out = [9125;6730;8611];
            obj.response_factor = obj.responseFactor();
        end
    end
end