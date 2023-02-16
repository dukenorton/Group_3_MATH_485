tipo=scenario_color(s);
scenario=scenari{j};

load(strcat(data_path,'dailynewcases',scenario))
load(strcat(data_path,'currentcases',scenario))

NPP=NPP(:);
POSSTIMATI=POSSTIMATI(:);

if vacc_flag(j)<5
    
    tv_gain=tv_gain_mat(:,vacc_flag(j));
    cum_vacc=cum_vacc_mat(:,vacc_flag(j));

else %adaptive vaccination
    
    load(strcat(data_path,'vacc',scenari2{j}))
    vacc=100*vacc(:);
    vacc=vacc(end-pred_wind_length:end);
    [cfr_ada,tvgain,cum_vacc] = make_cfr(vacc,cfr_2nd_wave_perc,days_before,days_with_vacc);
    v=vacc_flag(j);
    
end

% forecast death toll
daily_deaths = tvdead2(Bd,Fd,tvgain(end-days_forecast+1:end),NPP,daily_dead(end));
daily_deaths=[daily_dead; daily_deaths];

% forecast ICU occupancy
ICU_occup = tvdead2(Bi,Fi,tvgain(end-days_forecast+1:end),NPP*i_gain/d_gain,terapia_intensiva(end));
ICU_occup=[terapia_intensiva; ICU_occup];

% forecast hospital occupancy
hosp_occup = tvdead2(Bh,Fh,tvgain(end-days_forecast+1:end),NPP*h_gain/d_gain,hospital(end));
hosp_occup=[hospital; hosp_occup];

[f1,f2,f3,f4,f5] = make_fig2(daily_deaths,ICU_occup,hosp_occup,scenario,x,t,t2,days_before,days_forecast,nuovi_positivi,totale_positivi,hospital,terapia_intensiva,daily_dead,tvgain,cum_vacc,tipo,spess1,line_num,tot_lines,f1,f2,f3,f4,f5,newcolors);
