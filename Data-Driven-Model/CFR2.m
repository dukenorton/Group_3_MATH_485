%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plots a 4-panel figure that illustrates the derivation of time-varying 
% CFR (Case Fatality Rate) due to vaccination
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


define_colors;


% 2nd wave CFR
cfr_2nd_wave=2.65; 

% load vaccination roadmaps (2nd dose)
vaccrate

% choose fast vaccination (2nd dose)
vacc_sched= vacc_fast;

% end of vaccination campaign
dataf=datenum(2022,01,31);
dataf=datenum(2022,01,30);

% CFR prediction starts on march 12, 2021
data0=datenum(2021,03,11);
data0=datenum(2021,03,27);

% length of prediction window
pred_wind_length=dataf-data0;

% time axis
t=[datenum(2021,03,12):dataf]';
t=[datenum(2021,03,27):dataf]';

% vaccination roadmap during prediction window 
%vacc_sched = vacc_sched(end-pred_wind_length+1:end);
vacc_sched = vacc_sched(end-pred_wind_length:end);

% compute time varying CFR during vaccination period
% vacc speed is doubled because it refers to 2nd dose and 1 dose is
% sufficient to protect from hospitalization and death
[cfr_t,age,percent_pop_pdf,percent_pop_cdf,cfr_age,percent_unvacc_t] = tvcfr(2*vacc_sched,cfr_2nd_wave);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIGURES
% 4-panel figure illustrating derivation of
% time-varying CFR
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(1) 

datax=datenum(2021,04,01);
datax=datenum(2021,06,01);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PANEL A: vaccination roadmap
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(2,2,1) 
plot(t,percent_unvacc_t,'color',olive,'LineWidth',2), hold on

plot([datax dataf],[1 1]*percent_unvacc_t(datax-data0),'k--')

plot([datax datax],[0 percent_unvacc_t(datax-data0)],'k--')

ylim([0 100])
grid
title('vaccination roadmap (1st dose)')
ylabel('% not vaccinated')
datetick('x','mmmyy')

limy=ylim;
uleft('A');

hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PANEL B: population cdf
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(2,2,2) 

plot(age,percent_pop_cdf,'color',blue,'LineWidth',2), hold on

agex=interp1(percent_pop_cdf,age,percent_unvacc_t(datax-data0));

plot([0 agex],[1 1]*percent_unvacc_t(datax-data0),'k--')

plot([agex agex],[0 percent_unvacc_t(datax-data0)],'k--')


grid
title('cumulative population vs age')
ylabel('%')
xlabel('age')

limy=ylim;
uleft('B');

hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PANEL C: population pdf and age-dependent CFR
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(2,2,4) 

fagex=10*round(agex,1);

plot(age,percent_pop_pdf,'color',red,'LineWidth',1), hold on

plot(age,100*cfr_age,'color',purple,'LineWidth',1)

plot(age(1:fagex+1),percent_pop_pdf(1:fagex+1),'color',red,'LineWidth',4)

plot(age(1:fagex+1),100*cfr_age(1:fagex+1),'color',purple,'LineWidth',4)

plot(agex*[1 1],ylim,'k--')

grid
legend('population (%)','CFR (%)','Location','west')
title('population and CFR vs age')
ylabel('%')
xlabel('age')
limy=ylim;
uleft('C');

hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PANEL D: time-varying CFR
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(2,2,3)

plot(t,100*cfr_t,'color',purple,'LineWidth',2), hold on

limy=ylim;

plot([datax datax], [100*cfr_t(datax-data0) limy(2)],'k--')

title('overall CFR vs time')
grid
ylabel('%')
datetick('x','mmmyy')

uleft('D');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

percorso='./outputs/';
savefig(strcat(percorso,'FigE5'));


