classdef req_market_ch4 < comp_blueprint
    properties
        nvars = 1;
        flow_names = {'CH4 OUT'};        
        capex = 0;
        opex = 5;   
        response_time = 0;
        class = 'market';
    end
    
    methods
        function obj = req_market_ch4(comp,CF,timesteps)
            obj.CF = CF;
            obj.component = comp;
            
            obj.timesteps = timesteps;
            
            obj.rows = obj.timesteps;
            obj.cols = obj.nvars * obj.timesteps + 1;
            
            obj.in = [];
            obj.out = [obj.ch4];
            obj.response_factor = obj.responseFactor();
        end
    end
end