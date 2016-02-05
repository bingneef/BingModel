classdef conv_elec < comp_blueprint
    properties
        nvars = 3;
        flow_names = {'AC IN','H2 OUT','WASTE'};        
        capex = 3241.48*0.83;
        opex = 33.42*0.83;   
        response_time = 0;
        class = 'conv';
    end
    
    methods
        function obj = conv_elec(comp,CF,timesteps)
            obj.CF = CF;
            obj.component = comp;
            obj.timesteps = timesteps;
            
            obj.lifetime = 20;
            obj.rows = obj.timesteps;
            obj.cols = obj.timesteps*obj.nvars + 1;
            
            obj.in = [obj.ac];
            obj.out = [obj.h2,obj.W];
            
            obj.ratio_in = [1];
            obj.ratio_out = [0.83;0.17];
            obj.response_factor = obj.responseFactor();
        end
    end
end