classdef conv_elec_beta < comp_blueprint
    properties
        nvars = 3;
        flow_names = {'AC_BETA IN','H2_BETA OUT','WASTE_BETA'};        
        capex = 5000;
        opex = 0;   
        response_time = 0;
        class = 'conv';
    end
    
    methods
        function obj = conv_elec_beta(comp,CF,timesteps)
            obj.CF = CF;
            obj.component = comp;
            obj.timesteps = timesteps;
            
            obj.lifetime = 20;
            obj.rows = obj.timesteps;
            obj.cols = obj.timesteps*obj.nvars + 1;
            
            obj.in = [obj.ac_beta];
            obj.out = [obj.h2_beta,obj.W_beta];
            
            obj.ratio_in = [1];
            obj.ratio_out = [0.70;0.30];
            obj.response_factor = obj.responseFactor();
        end
    end
end