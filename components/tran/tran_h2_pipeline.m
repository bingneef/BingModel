classdef tran_h2_pipeline < comp_blueprint
    properties
        nvars = 3;
        flow_names = {'H2_BETA IN','H2 OUT','WASTE'};        
        capex = 1;
        opex = 0;   
        
        response_time = 0;
        
        class = 'conv';
    end
    
    methods
        function obj = tran_h2_pipeline(comp,CF,timesteps)
            obj.CF = CF;
            obj.component = comp;
            obj.timesteps = timesteps;
            
            obj.rows = obj.timesteps;
            obj.cols = obj.timesteps*obj.nvars + 1;
            
            obj.in = [obj.h2_beta];
            obj.out = [obj.h2,obj.W_beta];
            
            obj.ratio_in = [1];
            obj.ratio_out = [0.30;0.70];
            
            obj.response_factor = obj.responseFactor();
        end
    end
end