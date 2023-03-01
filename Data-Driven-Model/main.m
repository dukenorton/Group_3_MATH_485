%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Life and healthcare system costs: MAIN SCRIPT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear

% path to input data from Sidarthe
data_path='./data/';

figura=input('# figura=');
% input 0 to analyze all scenarios and plot summmary figures
% input 2,3,4 to plot figures 2,3,4
% input 12,13,16, 17 to plot extended-data-figures E2,E3,E6,E7
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Remark added on March 27: in the final version Figs. 2-3 have been 
% merged in Fig. 2, so that entering:
% "2" yields upper part of new Fig. 2
% "3" yields lower part of new Fig. 2
% "4" yields new Fig. 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%

% CFR estimated during 2nd wave
cfr_2nd_wave_perc=2.65;
cfr_2nd_wave=cfr_2nd_wave_perc/100;

% load models of death and healthcare system costs
load('transf_ita0702.mat')

% denominator and numerator of new positive-to-deaths model
Fd=sys_p2d.F;
Bd=sys_p2d.B;

% denominator and numerator of new positive-to-ICU occupancy model
Fi=sys_p2i.F;
Bi=sys_p2i.B;

% denominator and numerator of new positive-to-hospital occupancy model
Fh=sys_p2h.F;
Bh=sys_p2h.B;

% gains of the three models
d_gain=sum(Bd)/sum(Fd);
i_gain=sum(Bi)/sum(Fi);
h_gain=sum(Bh)/sum(Fh);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LOADS SIDARTHE FORECASTS OF NEW POSITIVE UNTIL 30.01.2022
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%percorso='/Users/giuseppe/Google Drive/-DENI-/Varie/Salute/Coronavirus/coronavirus m_files/Nuovi positivi per Giuseppe/Giuseppe/';
percorso='./outputs/';

nomi={'dailynewcasesFASTRtCO'
    'dailynewcasesFASTRtOC'
    'dailynewcasesFASTRtunoedue'
    'dailynewcasesFASTRtunopuntouno'
    'dailynewcasesFASTRtzeronove'
    'dailynewcasesMEDIUMRtCO'
    'dailynewcasesMEDIUMRtOC'
    'dailynewcasesMEDIUMRtunoedue'
    'dailynewcasesMEDIUMRtunopuntouno'
    'dailynewcasesMEDIUMRtzeronove'
    'dailynewcasesSLOWRtCO'
    'dailynewcasesSLOWRtOC'
    'dailynewcasesSLOWRtunoedue'
    'dailynewcasesSLOWRtunopuntouno'
    'dailynewcasesSLOWRtzeronove'
    'dailynewcasessenzavaccinoCO'
    'dailynewcasessenzavaccinoOC'
    'dailynewcasessenzavaccinounoedue'
    'dailynewcasessenzavaccinounopuntouno'
    'dailynewcasessenzavaccinozeronove'
    'dailynewcasesadattativaFASTRtCO'
    'dailynewcasesadattativaFASTRtOC'
    'dailynewcasesadattativaFASTRtunoedue'
    'dailynewcasesadattativaFASTRtunopuntouno'
    'dailynewcasesadattativaFASTRtzeronove'
    'dailynewcasesadattativaMEDIUMRtCO'
    'dailynewcasesadattativaMEDIUMRtOC'
    'dailynewcasesadattativaMEDIUMRtunoedue'
    'dailynewcasesadattativaMEDIUMRtunopuntouno'
    'dailynewcasesadattativaMEDIUMRtzeronove'
    'dailynewcasesadattativaSLOWRtCO'
    'dailynewcasesadattativaSLOWRtOC'
    'dailynewcasesadattativaSLOWRtunoedue'
    'dailynewcasesadattativaSLOWRtunopuntouno'
    'dailynewcasesadattativaSLOWRtzeronove'};

scenari={'FASTRtCO'
    'FASTRtOC'
    'FASTRtunoedue'
    'FASTRtunopuntouno'
    'FASTRtzeronove'
    'MEDIUMRtCO'
    'MEDIUMRtOC'
    'MEDIUMRtunoedue'
    'MEDIUMRtunopuntouno'
    'MEDIUMRtzeronove'
    'SLOWRtCO'
    'SLOWRtOC'
    'SLOWRtunoedue'
    'SLOWRtunopuntouno'
    'SLOWRtzeronove'
    'senzavaccinoCO'
    'senzavaccinoOC'
    'senzavaccinounoedue'
    'senzavaccinounopuntouno'
    'senzavaccinozeronove'
    'adattativaFASTRtCO'
    'adattativaFASTRtOC'
    'adattativaFASTRtunoedue'
    'adattativaFASTRtunopuntouno'
    'adattativaFASTRtzeronove'
    'adattativaMEDIUMRtCO'
    'adattativaMEDIUMRtOC'
    'adattativaMEDIUMRtunoedue'
    'adattativaMEDIUMRtunopuntouno'
    'adattativaMEDIUMRtzeronove'
    'adattativaSLOWRtCO'
    'adattativaSLOWRtOC'
    'adattativaSLOWRtunoedue'
    'adattativaSLOWRtunopuntouno'
    'adattativaSLOWRtzeronove'};

scenari2={'FASTRtCO'
    'FASTRtOC'
    'FASTRtunoedue'
    'FASTRtunopuntouno'
    'FASTRtzeronove'
    'MEDIUMRtCO'
    'MEDIUMRtOC'
    'MEDIUMRtunoedue'
    'MEDIUMRtunopuntouno'
    'MEDIUMRtzeronove'
    'SLOWRtCO'
    'SLOWRtOC'
    'SLOWRtunoedue'
    'SLOWRtunopuntouno'
    'SLOWRtzeronove'
    'senzavaccinoCO'
    'senzavaccinoOC'
    'senzavaccinounoedue'
    'senzavaccinounopuntouno'
    'senzavaccinozeronove'
    'FASTadattativaRtCO'
    'FASTadattativaRtOC'
    'FASTadattativaRtunoedue'
    'FASTadattativaRtunopuntouno'
    'FASTadattativaRtzeronove'
    'MEDIUMadattativaRtCO'
    'MEDIUMadattativaRtOC'
    'MEDIUMadattativaRtunoedue'
    'MEDIUMadattativaRtunopuntouno'
    'MEDIUMadattativaRtzeronove'
    'SLOWadattativaRtCO'
    'SLOWadattativaRtOC'
    'SLOWadattativaRtunoedue'
    'SLOWadattativaRtunopuntouno'
    'SLOWadattativaRtzeronove'};

% Flags for vaccination roadmaps of the scenarios
% flag = 1: FAST
% flag = 2: MEDIUM
% flag = 3: SLOW
% flag = 4: ZERO
% flag = 5: FAST adaptive
% flag = 6: MEDIUM adaptive
% flag = 7: SLOW adaptive
vacc_flag=[1 1 1 1 1 2 2 2 2 2 3 3 3 3 3 4 4 4 4 4 7 7 7 7 7 6 6 6 6 6 5 5 5 5 5];
% for all plots, data range from 1 (24 Feb 2020) to 707 (30 Jan 2022)
% included

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Important dates
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% start of Covid-19 pandemic
feb24_20=datenum(2020,02,24);

% start of Italian vaccination campaign
dic27_20=datenum(2020,12,27);

% end of simulation
gen30_22=datenum(2022,01,30);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Computation of fast, medium and slow vaccination schedules
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% compute tree 365-day vaccination roadmaps: FAST, SLOW, MEDIUM
vaccrate;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% load Italian data
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load_ita;

% define colors
define_colors

%%%%% line thickness
spess1=3;
spess2=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Computation of time varying cfr
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% end of vaccination campaign
dataf=datenum(2022,01,30);

% forecast starts on march 27, 2021
data0=datenum(2021,03,27);

% length of prediction window
pred_wind_length=dataf-data0;

% Indexes of prediction window are:
% (end-pred_wind_length+1:end)
vacc_fast=vacc_fast(end-pred_wind_length:end);
vacc_medium=vacc_medium(end-pred_wind_length:end);
vacc_slow=vacc_slow(end-pred_wind_length:end);
vacc_zero=vacc_zero(end-pred_wind_length:end);

% days_before vacccination start
days_before=dic27_20-feb24_20;

% days since vacccination start
days_with_vacc=data0-dic27_20;

% time axis during vaccination campaign
t_vacc=[dic27_20:gen30_22]';

% n. of days within forecast window
days_forecast=sum(t_vacc>x(end));

% time axis
t=[feb24_20 : dataf]';

% compute time varying CFR for all 4 vaccination roadmaps
[cfr_fast,tvgain_fast,cum_vacc_fast,vacc_fast] = make_cfr(vacc_fast,cfr_2nd_wave_perc,days_before,days_with_vacc);
[cfr_medium,tvgain_medium,cum_vacc_medium,vacc_medium] = make_cfr(vacc_medium,cfr_2nd_wave_perc,days_before,days_with_vacc);
[cfr_slow,tvgain_slow,cum_vacc_slow,vacc_slow] = make_cfr(vacc_slow,cfr_2nd_wave_perc,days_before,days_with_vacc);

% case without vaccination
cfr_zero=cfr_2nd_wave*ones(size(cfr_slow));
tvgain_zero=cfr_2nd_wave*ones(size(tvgain_slow));
cum_vacc_zero=zeros(size(cum_vacc_slow));
vacc_slow_zero=zeros(size(vacc_slow));

tot_already_vacc=sum(already_vacc);

% 4 vaccination speeds measured as final % of vaccinated
xvacc=zeros(4,1);
x_vacc(1)=cum_vacc_zero(end);
x_vacc(2)=cum_vacc_slow(end);
x_vacc(3)=cum_vacc_medium(end);
x_vacc(4)=cum_vacc_fast(end);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Vaccine roadmaps and time varying CFR: figures
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(100)
set(gcf,'position',[10,10,1400,800])

subplot(331)

plot(t_vacc,vacc_fast,'Linewidth',spess1), grid
title('daily vaccination rate (% population) - FAST')
datetick('x','mmmyy')
ylim([0 0.5])
uleft('A');

subplot(334)

plot(t_vacc,vacc_medium,'Linewidth',spess1), grid
title('daily vaccination rate (% population) - MEDIUM')
ylim([0 0.5])
datetick('x','mmmyy')
uleft('D');

subplot(337)

plot(t_vacc,vacc_slow,'Linewidth',spess1), grid
title('daily vaccination rate (% population) - SLOW')
ylim([0 0.5])
datetick('x','mmmyy')
uleft('G');

subplot(332)

plot(t_vacc,cum_vacc_fast,'Linewidth',spess1), grid
title('cumulative % vaccinated - FAST')
ylim([0 100])
datetick('x','mmmyy')
uleft('B');

subplot(335)

plot(t_vacc,cum_vacc_medium,'Linewidth',spess1), grid
title('cumulative % vaccinated - MEDIUM')
ylim([0 100])
datetick('x','mmmyy')
uleft('E');

subplot(338)

plot(t_vacc,cum_vacc_slow,'Linewidth',spess1), grid
title('cumulative % vaccinated - SLOW')
ylim([0 100])
datetick('x','mmmyy')
uleft('H');

subplot(333)

plot(t(end-length(cfr_fast)+1:end),cfr_fast,'Linewidth',spess1), grid
title('time varying CFR - FAST')
datetick('x','mmmyy')
uleft('C');

subplot(336)

plot(t(end-length(cfr_medium)+1:end),cfr_medium,'Linewidth',spess1), grid
title('time varying CFR - MEDIUM')
datetick('x','mmmyy')
uleft('F');

subplot(339)

plot(t(end-length(cfr_slow)+1:end),cfr_slow,'Linewidth',spess1), grid
title('time varying CFR - SLOW')
datetick('x','mmmyy')
uleft('I');

savefig(strcat(percorso,'FigE4'))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MAIN CYCLE
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig_num=1;


if figura==2
    
    j_0=8;
    j_fin=8;
    
elseif figura==3
       
    j_0=7;
    j_fin=7;
    
elseif figura==4
    
    j_0=12;
    j_fin=12;
    
elseif figura==12

    j_0=18;
    j_fin=18;
   
elseif figura==13
    
    j_0=17;
    j_fin=17; 
    
elseif figura==16
    
    j_0=28;
    j_fin=28;
    
elseif figura==17
    
    j_0=27;
    j_fin=27;
   
else
    
    j_0=1;
    j_fin=35;
     
end   


for j = j_0:j_fin
    
    
    load(strcat(data_path,'dailynewcases',scenari{j}))
    
    load(strcat(data_path,'currentcases',scenari{j}))
    
    NPP=NPP(:);
    POSSTIMATI=POSSTIMATI(:);

    
    s=mod(j,5);
    if s==0, s=5; end

% times range from 1 (February 24, 2020) to 707 (January 30, 2022).

if vacc_flag(j)==1
    
    tvgain=tvgain_fast;
    cum_vacc=cum_vacc_fast;
    v=4;
    
    %vacc=1
    
elseif vacc_flag(j)==2
    
    tvgain=tvgain_medium;
    cum_vacc=cum_vacc_medium;
    v=3;
    
elseif vacc_flag(j)==3
    
    tvgain=tvgain_slow;
    cum_vacc=cum_vacc_slow;
    v=2;
    
elseif vacc_flag(j)==4
    
    tvgain=tvgain_zero;
    cum_vacc=cum_vacc_zero;
    v=1;
    
else
    
    load(strcat(data_path,'vacc',scenari2{j}))
    vacc=100*vacc(:);
    vacc=vacc(end-pred_wind_length:end);
    [cfr_ada,tvgain,cum_vacc] = make_cfr(vacc,cfr_2nd_wave_perc,days_before,days_with_vacc);
    v=vacc_flag(j);
    
end

% forecast death toll
daily_deaths = tvdead2(Bd,Fd,tvgain(end-days_forecast+1:end),NPP,daily_dead(end));
tot_deaths(v,s)=sum(daily_deaths);
daily_deaths=[daily_dead; daily_deaths];

% forecast ICU occupancy
ICU_occup = tvdead2(Bi,Fi,tvgain(end-days_forecast+1:end),NPP*i_gain/d_gain,terapia_intensiva(end));
tot_ICU(v,s)=sum(ICU_occup);
ICU_occup=[terapia_intensiva; ICU_occup];

% forecast hospital occupancy
hosp_occup = tvdead2(Bh,Fh,tvgain(end-days_forecast+1:end),NPP*h_gain/d_gain,hospital(end));
tot_hosp(v,s)=sum(hosp_occup);
hosp_occup=[hospital; hosp_occup];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Plot figures
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(200+fig_num)
set(gcf,'position',[10,10,1400,700]);

%t2=[x(end)+1:t(end)]';
t2=t(t>x(end));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Active cases panel
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2,3,3)

plot(x,totale_positivi,'Color',black,'Linewidth',spess1); hold on
f1(1)=plot([x(end);t2],[totale_positivi(end);POSSTIMATI(t>x(end))],'-','Color',scenario_color(s),'Linewidth',spess1);

noscientnotationy(f1);
datetick('x','mmmyy')

grid
title({'active cases'})


if figura==3
    uleft('I');
else
    uleft('C');
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% New positive panel
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


subplot(2,3,2)

aux=movmean(nuovi_positivi,7);
plot(x,aux,'Color',black,'Linewidth',spess1); hold on
f2(1)=plot([x(end);t2],[aux(end);NPP(t>x(end))],'-','Color',scenario_color(s),'Linewidth',spess1);

noscientnotationy(f2(1));
datetick('x','mmmyy')

grid
title({scenari{j},'daily new cases'})



if figura==3
    uleft('H');
else
    uleft('B');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hospital occup. panel
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


subplot(2,3,4)


plot(x,hospital,'Color',black,'Linewidth',spess1); hold on
f3(1)=plot([x(end);t2],[hospital(end);hosp_occup(t>x(end))],'-','Color',scenario_color(s),'Linewidth',spess1);

noscientnotationy(f3(1));
datetick('x','mmmyy')

grid
title('hospital occupancy')


if figura==3
    uleft('J');
else
    uleft('D');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ICU occup. panel
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


subplot(2,3,5)


plot(x,terapia_intensiva,'Color',black,'Linewidth',spess1); hold on
f4(1)=plot([x(end);t2],[terapia_intensiva(end);ICU_occup(t>x(end))],'-','Color',scenario_color(s),'Linewidth',spess1);

noscientnotationy(f4(1));
datetick('x','mmmyy')

grid
title('ICU occupancy')



if figura==3
    uleft('K');
else
    uleft('E');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daily deaths panel
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(2,3,6)

aux=movmean(daily_dead,7);
plot(x,aux,'Color',black,'Linewidth',spess1); hold on
f5(1)=plot([x(end);t2],[aux(end);daily_deaths(t>x(end))],'-','Color',scenario_color(s),'Linewidth',spess1);
%f5(1)=plot(t2(end-days_forecast+1:end),daily_deaths(end-days_forecast+1:end),'--','Color',black,'Linewidth',spess2);

noscientnotationy(f5(1));
datetick('x','mmmyy')

grid
title('daily deaths')


if figura==3
    uleft('L');
else
    uleft('F');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Immunized panel
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if figura==0
    
    subplot(2,3,1)
    
elseif figura==2 | figura==12 | figura==16

    subplot(6,3,1) 
     
else
    
    subplot(4,3,1)       
    
end

newcolors = [black; yellow; olive; gray];

immuni_area_plot(x,t,days_before,daily_dead,daily_deaths,nuovi_positivi,NPP,cum_vacc,newcolors);


if figura==0
    
    datetick('x','mmmyy','keepticks')
    legend('% dead','% infected and recovered','% vaccinated','% susceptibles','Location','NorthWest')
    
else
    
    set(gca,'XTickLabel',[]);
        
end


if figura==3
    uleft('G');
else
    uleft('A');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% save figure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% savefig(strcat(percorso,nomi{j}))

fig_num=fig_num+1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% saving data to file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%save(strcat(percorso,nomi{j},'_rev2'),'NPP,'daily_deaths', 'ICU_occup','hosp_occup')

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Paper Figures
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% collect time-varying CFRs and cumulative vaccinations in matrix form
tv_gain_mat=[tvgain_fast tvgain_medium tvgain_slow tvgain_zero];
cum_vacc_mat=[cum_vacc_fast cum_vacc_medium cum_vacc_slow cum_vacc_zero];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Figura 2 - medium vax Rt=0.9, 1.1, 1.27
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if figura==2

figure(201)

hold on

tot_lines=3;

s=4;
j=9;line_num=2;
simulate_scenario

s=5;
j=10;line_num=3;
simulate_scenario

subplot(6,3,1)
title('R_0=1.27')

subplot(6,3,4)
title('R_0=1.1')

subplot(6,3,7)
title('R_0=0.9')
legend('% dead','% infected and recovered','% vaccinated','% susceptibles','Location','NorthWest')

subplot(233)
legend(f1,'R_0=1.27','R_0=1.1','R_0=0.9','Location','NorthEast')

subplot(232)
legend(f2,'R_0=1.27','R_0=1.1','R_0=0.9','Location','NorthEast')
title({'VACCINATION: MEDIUM SPEED','daily new cases'})

subplot(234)
legend(f3,'R_0=1.27','R_0=1.1','R_0=0.9','Location','NorthEast')

subplot(235)
legend(f4,'R_0=1.27','R_0=1.1','R_0=0.9','Location','NorthEast')

subplot(236)
legend(f5,'R_0=1.27','R_0=1.1','R_0=0.9','Location','NorthEast')

savefig(strcat(percorso,'Fig2'))

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Figura 3 - OC vs CO under Medium vacc
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if figura==3
    
    figure(201)

hold on

tot_lines=2;

s=1;
j=6;line_num=2;
simulate_scenario

subplot(4,3,1)
title('Open-Close')

subplot(4,3,4)
title('Close-Open')
legend('% dead','% infected and recovered','% vaccinated','% susceptibles','Location','NorthWest')

subplot(2,3,3)
legend(f1,'Open-Close','Close-Open','Location','NorthEast')

subplot(2,3,2)
legend(f2,'Open-Close','Close-Open','Location','NorthEast')
%title({'VACCINATION: MEDIUM SPEED','daily new cases'})
title({'daily new cases'})

subplot(2,3,4)
legend(f3,'Open-Close','Close-Open','Location','NorthEast')

subplot(2,3,5)
legend(f4,'Open-Close','Close-Open','Location','NorthEast')

subplot(2,3,6)
legend(f5,'Open-Close','Close-Open','Location','NorthEast')

savefig(strcat(percorso,'Fig3'))

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Figura 4 - slow vs fast vacc
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if figura==4
    
    figure(201)

hold on

tot_lines=2;

s=6;
j=2;line_num=2;
simulate_scenario

subplot(4,3,4)
title('Fast vaccination')
legend('% dead','% infected and recovered','% vaccinated','% susceptibles','Location','NorthWest')

subplot(4,3,1)
title('Slow vaccination')
    
subplot(2,3,3)
legend(f1,'Slow vaccin.','Fast vaccin.','Location','NorthEast')

subplot(2,3,2)
legend(f2,'Slow vaccin.','Fast vaccin.','Location','NorthEast')
title({'SLOW vs FAST VACCIN. under OPEN-CLOSE','daily new cases'})

subplot(2,3,4)
legend(f3,'Slow vaccin.','Fast vaccin.','Location','NorthEast')

subplot(2,3,5)
legend(f4,'Slow vaccin.','Fast vaccin.','Location','NorthEast')

subplot(2,3,6)
legend(f5,'Slow vaccin.','Fast vaccin.','Location','NorthEast')

savefig(strcat(percorso,'Fig4'))

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Figura E2 - no vax Rt=0.9, 1.1, 1.27
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if figura==12

figure(201)

hold on

tot_lines=3;

s=4;
j=19;line_num=2;
simulate_scenario

s=5;
j=20;line_num=3;
simulate_scenario

subplot(6,3,1)
title('R_0=1.27')

subplot(6,3,4)
title('R_0=1.1')

subplot(6,3,7)
title('R_0=0.9')
legend('% dead','% infected and recovered','% vaccinated','% susceptibles','Location','NorthWest')

subplot(233)
legend(f1,'R_0=1.27','R_0=1.1','R_0=0.9','Location','NorthEast')

subplot(232)
legend(f2,'R_0=1.27','R_0=1.1','R_0=0.9','Location','NorthEast')
title({'VACCINATION: NONE','daily new cases'})

subplot(234)
legend(f3,'R_0=1.27','R_0=1.1','R_0=0.9','Location','NorthEast')

subplot(235)
legend(f4,'R_0=1.27','R_0=1.1','R_0=0.9','Location','NorthEast')

subplot(236)
legend(f5,'R_0=1.27','R_0=1.1','R_0=0.9','Location','NorthEast')

savefig(strcat(percorso,'FigE2'))

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Figura E3 - no vax OC vs CO
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if figura==13
    
    figure(201)

hold on

tot_lines=2;

s=1;
j=16;line_num=2;
simulate_scenario

subplot(4,3,1)
title('Open-Close')

subplot(4,3,4)
title('Close-Open')
legend('% dead','% infected and recovered','% vaccinated','% susceptibles','Location','NorthWest')

subplot(2,3,3)
legend(f1,'Open-Close','Close-Open','Location','NorthEast')

subplot(2,3,2)
legend(f2,'Open-Close','Close-Open','Location','NorthEast')
title({'VACCINATION: NONE','daily new cases'})

subplot(2,3,4)
legend(f3,'Open-Close','Close-Open','Location','NorthEast')

subplot(2,3,5)
legend(f4,'Open-Close','Close-Open','Location','NorthEast')

subplot(2,3,6)
legend(f5,'Open-Close','Close-Open','Location','NorthEast')

savefig(strcat(percorso,'FigE3'))

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Figura E6 - adaptive vax Rt=0.9, 1.1, 1.27
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if figura==16

figure(201)

hold on

tot_lines=3;

s=4;
j=29;line_num=2;
simulate_scenario

s=5;
j=30;line_num=3;
simulate_scenario

subplot(6,3,1)
title('R_0=1.27')

subplot(6,3,4)
title('R_0=1.1')

subplot(6,3,7)
title('R_0=0.9')
legend('% dead','% infected and recovered','% vaccinated','% susceptibles','Location','NorthWest')

subplot(233)
legend(f1,'R_0=1.27','R_0=1.1','R_0=0.9','Location','NorthEast')

subplot(232)
legend(f2,'R_0=1.27','R_0=1.1','R_0=0.9','Location','NorthEast')
title({'ADAPTIVE VACCINATION: MEDIUM','daily new cases'})

subplot(234)
legend(f3,'R_0=1.27','R_0=1.1','R_0=0.9','Location','NorthEast')

subplot(235)
legend(f4,'R_0=1.27','R_0=1.1','R_0=0.9','Location','NorthEast')

subplot(236)
legend(f5,'R_0=1.27','R_0=1.1','R_0=0.9','Location','NorthEast')

savefig(strcat(percorso,'FigE6'))

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Figura E7 - adaptive vax OC vs CO
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if figura==17
    
    figure(201)

hold on

tot_lines=2;

s=1;
j=26;line_num=2;
simulate_scenario

subplot(4,3,1)
title('Open-Close')

subplot(4,3,4)
title('Close-Open')
legend('% dead','% infected and recovered','% vaccinated','% susceptibles','Location','NorthWest')

subplot(2,3,3)
legend(f1,'Open-Close','Close-Open','Location','NorthEast')

subplot(2,3,2)
legend(f2,'Open-Close','Close-Open','Location','NorthEast')
title({'ADAPTIVE VACCINATION: MEDIUM','daily new cases'})

subplot(2,3,4)
legend(f3,'Open-Close','Close-Open','Location','NorthEast')

subplot(2,3,5)
legend(f4,'Open-Close','Close-Open','Location','NorthEast')

subplot(2,3,6)
legend(f5,'Open-Close','Close-Open','Location','NorthEast')

savefig(strcat(percorso,'FigE7'))

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% deaths and healthcare sys. costs vs scenarios: figures
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if figura==0
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Deaths
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(600)

set(gcf,'position',[10,10,500,400])

% permutation matrix to rearrange order of variables
permat=[0 0 1 0 0
    0 1 0 0 0
    0 0 0 1 0
    1 0 0 0 0
    0 0 0 0 1];
    
h=plot(x_vacc',tot_deaths(1:4,3)/1000,'*-','color',purple,'Linewidth',3);hold on
plot(x_vacc',tot_deaths(1:4,2)/1000,'*-','color',red,'Linewidth',3)
plot(x_vacc',tot_deaths(1:4,4)/1000,'*-','color',orange,'Linewidth',3)
plot(x_vacc',tot_deaths(1:4,1)/1000,'*-','color',olive,'Linewidth',3)
plot(x_vacc',tot_deaths(1:4,5)/1000,'*-','color',blue,'Linewidth',3)
noscientnotationy(h(1));
grid on
title('predicted total deaths Apr 2021 - Jan 2022')
xlabel('vaccination speed (% population vaccinated within Jan 2022)')
ylabel('thousand')
legend('R_0 = 1.27','periodic Open-Close','R_0 = 1.1','periodic Close-Open','R_0 = 0.9')

savefig(strcat(percorso,'Fig1'))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ICU and hospital occup.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(601)
set(gcf,'position',[10,10,1000,400])

subplot(121)

h=plot(x_vacc',tot_ICU(1:4,3)/1000,'*-','color',purple,'Linewidth',3);hold on
plot(x_vacc',tot_ICU(1:4,2)/1000,'*-','color',red,'Linewidth',3)
plot(x_vacc',tot_ICU(1:4,4)/1000,'*-','color',orange,'Linewidth',3)
plot(x_vacc',tot_ICU(1:4,1)/1000,'*-','color',olive,'Linewidth',3)
plot(x_vacc',tot_ICU(1:4,5)/1000,'*-','color',blue,'Linewidth',3)
noscientnotationy(h(1));
grid
title('total ICU occupancy Apr 2021 - Jan 2022')
xlabel('vaccination speed (% population vaccinated within Jan 2022)')
ylabel('thousand days')
legend('R_0 = 1.27','periodic Open-Close','R_0 = 1.1','periodic Close-Open','R_0 = 0.9')
text(10,1700,'A','FontWeight','bold');

subplot(122)

h=plot(x_vacc',tot_hosp(1:4,3)/1000000,'*-','color',purple,'Linewidth',3);hold on
plot(x_vacc',tot_hosp(1:4,2)/1000000,'*-','color',red,'Linewidth',3)
plot(x_vacc',tot_hosp(1:4,4)/1000000,'*-','color',orange,'Linewidth',3)
plot(x_vacc',tot_hosp(1:4,1)/1000000,'*-','color',olive,'Linewidth',3)
plot(x_vacc',tot_hosp(1:4,5)/1000000,'*-','color',blue,'Linewidth',3)
noscientnotationy(h(1));
grid
title('total hospital occupancy Apr 2021 - Jan 2022')
xlabel('vaccination speed (% population vaccinated within Jan 2022)')
ylabel('million days')
legend('R_0 = 1.27','periodic Open-Close','R_0 = 1.1','periodic Close-Open','R_0 = 0.9')
text(10,17,'B','FontWeight','bold');

savefig(strcat(percorso,'FigE8'))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% death costs: tables
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

D_table=(tot_deaths*permat'/1000)';

% Table with life costs of nonadaptive vaccination

Zero=D_table(:,1);
Slow=D_table(:,2);
Medium=D_table(:,3);
Fast=D_table(:,4);

Strategy={'1.27','Open-Close','1.1','Close-Open','0.9'}';
T_deaths = table(Strategy,Zero,Slow,Medium,Fast)
writetable(T_deaths,strcat(percorso,'Table_deaths.xlsx'))

% Table with life costs of adaptive vaccination

Slow=D_table(:,5);
Medium=D_table(:,6);
Fast=D_table(:,7);

Strategy_ada=Strategy;
T_ada = table(Strategy_ada,Slow,Medium,Fast)
writetable(T_ada,strcat(percorso,'Table_deaths_ada.xlsx'))

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plots a 4-panel figure that illustrates the derivation of time-varying 
% CFR (Case Fatality Rate) due to vaccination
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
CFR2


