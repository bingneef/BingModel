classdef conv_dung_gasifier < comp_blueprint
    properties
        nvars = 3;
        flow_names = {'DUNG IN','CH4 OUT','WASTE'};        
        capex = 2.59;
        opex = 0;   
        response_time = 0;
        class = 'conv';
    end
    
    methods
        function obj = conv_dung_gasifier(comp,CF,timesteps)
            obj.CF = CF;
            obj.component = comp;
            obj.timesteps = timesteps;
            obj.lifetime = 20;
            
            obj.rows = obj.timesteps;
            obj.cols = obj.timesteps*obj.nvars + 1;
            
            obj.in = [obj.dung];
            obj.out = [obj.ch4,obj.W];
            
            obj.ratio_in = [1];
            obj.ratio_out = [0.75;0.25];
            obj.response_factor = obj.responseFactor();
        end
    end
end