classdef conv_heater < comp_blueprint
    properties
        nvars = 2;
        flow_names = {'AC IN','HEAT25 OUT','WASTE'};        
        capex = 1;
        opex = 0;   
        response_time = 0;
        class = 'conv';
    end
    
    methods
        function obj = conv_heater(comp,CF,timesteps)
            obj.CF = CF;
            obj.component = comp;
            obj.timesteps = timesteps;
            
            obj.rows = obj.timesteps;
            obj.cols = obj.timesteps*obj.nvars + 1;
            
            obj.in = [obj.ac];
            obj.out = [obj.heat_25;obj.W];
            
            obj.ratio_in = [1];
            obj.ratio_out = [0.99;0.01];
            obj.response_factor = obj.responseFactor();
        end
    end
end