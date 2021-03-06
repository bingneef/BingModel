classdef conv_acdc < comp_blueprint
    properties
        nvars = 3;
        flow_names = {'AC IN','DC OUT','WASTE'};        
        capex = 3.56;
        opex = 0;   
        
        response_time = 0;
        
        class = 'conv';
    end
    
    methods
        function obj = conv_acdc(comp,CF,timesteps)
            obj.CF = CF;
            obj.component = comp;
            obj.timesteps = timesteps;
            obj.lifetime = 10;
            
            obj.rows = obj.timesteps;
            obj.cols = obj.timesteps*obj.nvars + 1;
            
            obj.in = [obj.ac];
            obj.out = [obj.dc,obj.W];
            
            obj.ratio_in = [1];
            obj.ratio_out = [0.99;0.01];
            
            obj.response_factor = obj.responseFactor();
        end
    end
end