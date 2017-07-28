% RF Link Model Class
% Includes constructor and calculating function for Eb No margin and signal
% to noise margin

% sample :  x = LinkModelclass(4.7, 4800, 2.2, 2, 261, 18.5, 3.6, 10, 14.4, 170.4, 5000, 14.4)
classdef LinkModelclass
    properties
        boltzman_const = -228.6;    %dBW/K/Hz
        antenna_pt_loss;            %dB of sat
        data_rate;                  %bps
        sat_ant_gain;               %dBi
        total_inline_loss;          %dB
        sys_noise_temp;             %K
        gnd_ant_gain;               %dBi
        ant_total_line_loss;        %dB - function req
        transmitter_pwr;            %W
        Eb_No_threshold;            %dB
        total_uplink_loss;          %dB
        % = gnd stn antenna pointing loss + gnd-to-s/c ant polarization
        % losses + path loss + atomspheric losses + ionospheric losses +
        % rain losses
        
        Eb_No_link;                 %dB
        
        sat_receiver_bandwidth;     %Hz
        req_SN;                     %dB
        
        SN_margin_link;             %dB
    end

    methods

        function data = LinkModelclass(antenna_pt_loss, data_rate, ...
            sat_ant_gain, total_inline_loss, sys_noise_temp, ...
            gnd_ant_gain, ant_total_line_loss, transmitter_pwr, ...
            Eb_No_threshold, total_uplink_loss, sat_receiver_bandwidth, req_SN)
            %class initializer
            
            data.antenna_pt_loss = antenna_pt_loss; %SATELLITE
            data.data_rate = data_rate;                  
            data.sat_ant_gain = sat_ant_gain;               
            data.total_inline_loss = total_inline_loss;          
            data.sys_noise_temp = sys_noise_temp;             
            data.gnd_ant_gain = gnd_ant_gain;               
            data.ant_total_line_loss = ant_total_line_loss;          
            data.transmitter_pwr = transmitter_pwr;    % GND STN        
            data.Eb_No_threshold = Eb_No_threshold;
            data.sat_receiver_bandwidth = sat_receiver_bandwidth;
            data.total_uplink_loss = total_uplink_loss;
            data.req_SN = req_SN;
        end    
        function data = Eb_No_calc(data)
            Gnd_stn_eirp = 10*log10(data.transmitter_pwr) - data.ant_total_line_loss ...
             + data.gnd_ant_gain;
            
            
            Sat_Isot_signal_lvl = Gnd_stn_eirp - data.total_uplink_loss;
            
            sat_sig_of_merrit = data.sat_ant_gain - data.total_inline_loss ...
            - 10*log10(data.sys_noise_temp); %uptimate measure of receiver's perf
        
            
            
            SC_SNR_Pwr_Den = Sat_Isot_signal_lvl - data.antenna_pt_loss ...
            - data.boltzman_const + sat_sig_of_merrit;
        
            desired_data_rate = 10*log10(data.data_rate);
            
            cmd_Eb_No = SC_SNR_Pwr_Den - desired_data_rate;
            
            data.Eb_No_link = cmd_Eb_No - data.Eb_No_threshold;

        end
        
        function data = SN_margin_calc(data)
            Gnd_stn_eirp = 10*log10(data.transmitter_pwr) - data.ant_total_line_loss ...
             + data.gnd_ant_gain;
         
            Sat_Isot_signal_lvl = Gnd_stn_eirp - data.total_uplink_loss;
            
            Sig_Pwr_Sat_LNA_input = Sat_Isot_signal_lvl - data.antenna_pt_loss ...
                + data.sat_ant_gain - data.total_inline_loss;
            
            Sat_rx_noise_pwr = data.boltzman_const + 10*log10(data.sys_noise_temp) ...
                + 10*log10(data.sat_receiver_bandwidth);
            
            SN_Pwr_Ratio_Gnd = Sig_Pwr_Sat_LNA_input - Sat_rx_noise_pwr;
            
            data.SN_margin_link = SN_Pwr_Ratio_Gnd - data.req_SN;
            
        end
    end 

end