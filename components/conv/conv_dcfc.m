classdef conv_dcfc < comp_blueprint
    properties
        nvars = 3;
        flow_names = {'C IN','DC OUT','WASTE'};        
        capex = 0;
        opex = 0;   
        response_time = 15*60*60;
        class = 'conv';
    end
    
    methods
        function obj = conv_dcfc(comp,CF,timesteps)
            obj.CF = CF;
            obj.component = comp;
            obj.timesteps = timesteps;
            
            obj.rows = obj.timesteps;
            obj.cols = obj.timesteps*obj.nvars + 1;
            
            obj.in = [obj.C;];
            obj.out = [obj.dc;obj.W];
            
            obj.ratio_in = [1];
            obj.ratio_out = [0.8;0.2];
            obj.response_factor = obj.responseFactor();
        end
    end
end