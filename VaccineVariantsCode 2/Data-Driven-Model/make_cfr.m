function [cfr_var,tvgain_var,cum_vacc,vacc_speed] = make_cfr(vacc_speed,cfr_2nd_wave_perc,days_without_vacc,days_with_vacc)
%function [cfr_var,tvgain_var,cum_vacc_var] = make_cfr(vacc_speed,cfr_2nd_wave,days_before)
% computes time-varying CFR during vaccination (cfr_var) and since epidemic start
% (tvgain_var), and cumulative vaccination curve (cum_vacc_var)
%
% Inputs:
% vacc_speed: future vaccination rates
% cfr_2nd_wave_perc: percentage CFR during 2nd wave
% days_without_vacc: days before vaccination start
% days_with_vacc: days since vaccination and before forecast
%
% Outputs:
% cfr_var: future time-varying CFR
% tvgain_var: time-varying CFR since Covid-19 outbreak
% cum_vacc_var: cumulative vacccination (%)

cfr_2nd_wave=cfr_2nd_wave_perc/100;

% time varying CFR during forecast window
% vacc speed is doubled because it refers to 2nd dose and 1 dose is
% sufficient to protect from hospitalization and death
cfr_var2=tvcfr(2*vacc_speed,cfr_2nd_wave_perc);

% time varying CFR from vaccination start to forecast start is obtained by linear interpolation
cfr_var1=linspace(cfr_2nd_wave,cfr_var2(1),days_with_vacc)';

% constant CFR before vaccination
cfr_var0=cfr_2nd_wave*ones(days_without_vacc,1);

% time varying CFR since vaccination start is obtained by concatenation
cfr_var=[cfr_var1;cfr_var2];

% time-varying CFR since Covid-19 outbreak is obtained by concatenation
tvgain_var=[cfr_var0;cfr_var1;cfr_var2];

% percentage of already vaccinated
already_vacc_2doses_perc=100*sum(already_vacc_2doses)/sum(italianpop);

%cumulative vaccination from vaccination start to forecast start is obtained by linear interpolation
cum_vacc0=linspace(0,already_vacc_2doses_perc,days_with_vacc)';

%cumulative vacccination (%) since forecast start
cum_vacc1=already_vacc_2doses_perc+cumsum(vacc_speed);

%cumulative vacccination (%) since vaccination start is obtained by concatenation
cum_vacc=[cum_vacc0; cum_vacc1];

% vaccination speed (%) since vaccination start
vacc_speed=diff([0;cum_vacc]);

end

