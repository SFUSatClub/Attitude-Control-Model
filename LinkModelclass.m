% RF Link Model Class
% Includes constructor and calculating function for Eb No margin and signal
% to noise margin

% sample :  x = LinkModelclass(4.7, 4800, 2.2, 2, 261, 18.5, 3.6, 10, 14.4, 170.4, 5000, 14.4)
classdef LinkModelclass
    properties
        %%physical constants
        boltzman_const = -228.6;    %dBW/K/Hz
        %link
        data_rate;                  %bps
        total_uplink_loss;          %dB
        Eb_No_link;                 %dB
        req_SN;                     %dB
        SN_margin_link;             %dB
        %spacecraft
        total_inline_loss;          %dB
        ff_pattern;                 %dBi
        Sat_rx_noise_pwr;           %dBm??
        %   reciveing
        sys_noise_temp;             %K
        sat_receiver_bandwidth;     %Hz
        %   transmitting
        %ground
        gnd_ant_gain;               %dBi
        ant_total_line_loss;        %dB - function reqantenna_pt_loss;
        antenna_pt_loss;            %dB of sat
        %   recieving
        Eb_No_threshold;            %dB
        %   transmitting
        transmitter_pwr;            %W
        
        
        %intermidiate
        Sat_Isot_signal_lvl;
        
        % = gnd stn antenna pointing loss + gnd-to-s/c ant polarization
        % losses + path loss + atomspheric losses + ionospheric losses +
        % rain losses
        
        
    end

    methods

        function data = LinkModelclass(antenna_pt_loss, data_rate, ...
            total_inline_loss, sys_noise_temp, ...
            gnd_ant_gain, ant_total_line_loss, transmitter_pwr, ...
            Eb_No_threshold, total_uplink_loss, sat_receiver_bandwidth, req_SN, ff_file)
            %class initializer
            
            data.antenna_pt_loss = antenna_pt_loss; %SATELLITE
            data.data_rate = 10*log10(data_rate);                                
            data.total_inline_loss = total_inline_loss;          
            data.sys_noise_temp = sys_noise_temp;             
            data.gnd_ant_gain = gnd_ant_gain;               
            data.ant_total_line_loss = ant_total_line_loss;          
            data.transmitter_pwr = transmitter_pwr;    % GND STN        
            data.Eb_No_threshold = Eb_No_threshold;
            data.sat_receiver_bandwidth = sat_receiver_bandwidth;
            data.total_uplink_loss = total_uplink_loss;
            data.req_SN = req_SN;

            data.Sat_Isot_signal_lvl = 10*log10(data.transmitter_pwr) - data.ant_total_line_loss ...
             + data.gnd_ant_gain - data.total_uplink_loss;
         
            data.Sat_rx_noise_pwr = data.boltzman_const + 10*log10(data.sys_noise_temp) ...
                + 10*log10(data.sat_receiver_bandwidth);
         
            data.ff_pattern = load_ff_pattern(ff_file);
        end
        
        function data = Eb_No_calc(data, e_Angl)
            sat_sig_of_merrit = sat_ant_gain(e_Angl) - data.total_inline_loss ...
            - 10*log10(data.sys_noise_temp); %uptimate measure of receiver's perf

            SC_SNR_Pwr_Den = data.Sat_Isot_signal_lvl - data.antenna_pt_loss ...
            - data.boltzman_const + sat_sig_of_merrit;
            
            cmd_Eb_No = SC_SNR_Pwr_Den - data.data_rate;
            
            data.Eb_No_link = cmd_Eb_No - data.Eb_No_threshold;

        end
        
        function data = SN_margin_calc(data, e_Angle)
            Sig_Pwr_Sat_LNA_input = data.Sat_Isot_signal_lvl - data.antenna_pt_loss ...
                + sat_ant_gain(e_Angle) - data.total_inline_loss;
            
            SN_Pwr_Ratio_Gnd = Sig_Pwr_Sat_LNA_input - data.Sat_rx_noise_pwr;
            
            data.SN_margin_link = SN_Pwr_Ratio_Gnd - data.req_SN;
            
        end
        
        %compute the gain of spacecraft antenna as a function of 2 euler
        %angles w/ inertial reference to spacecraft.
        function data = sat_ant_gain(e_Angle)
            gain  = 1:length(e_Angle);
            %repeats for each column
            t_index = 0;
            for r = e_Ange
                [row, col] = data.ff_pattern(1).find(round(r(1))); %or something like that
                gain(t_index) = data.ff_pattern(row,:).find(round(r(2)));
            end
            data = gain;
        end
        
        function pattern3n = load_ff_pattern(file)
            %load ff pattern and return as 3 x n matrix
        end
    end 

end