classdef conv_pemfc < comp_blueprint
    properties
        nvars = 3;
        flow_names = {'H2 IN','DC OUT','WASTE'};        
        capex = 1120/2;
        opex = 22.40/2;   
        response_time = 0;
        class = 'conv';
    end
    
    methods
        function obj = conv_pemfc(comp,CF,timesteps)
            obj.CF = CF;
            obj.component = comp;
            obj.timesteps = timesteps;
            
            obj.lifetime = 5;
            %obj.IC = 100;
            
            obj.rows = obj.timesteps;
            obj.cols = obj.timesteps*obj.nvars + 1;
            
            obj.in = [obj.h2;];
            obj.out = [obj.dc;obj.W];
            
            obj.ratio_in = [1];
            obj.ratio_out = [0.50;0.50];
            
            obj.response_factor = obj.responseFactor();
        end
    end
end