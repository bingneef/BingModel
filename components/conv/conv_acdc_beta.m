classdef conv_acdc_beta < comp_blueprint
    properties
        nvars = 3;
        flow_names = {'AC_BETA IN','DC_BETA OUT','WASTE_BETA'};        
        capex = 1;
        opex = 0;   
        
        response_time = 0;
        
        class = 'conv';
    end
    
    methods
        function obj = conv_acdc_beta(comp,CF,timesteps)
            obj.CF = CF;
            obj.component = comp;
            obj.timesteps = timesteps;
            
            obj.rows = obj.timesteps;
            obj.cols = obj.timesteps*obj.nvars + 1;
            
            obj.in = [obj.ac_beta];
            obj.out = [obj.dc_beta,obj.W_beta];
            
            obj.ratio_in = [1];
            obj.ratio_out = [0.99;0.01];
            
            obj.response_factor = obj.responseFactor();
        end
    end
end