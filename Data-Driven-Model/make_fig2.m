function [f1,f2,f3,f4,f5] = make_fig2(daily_deaths,ICU_occup,hosp_occup,scenario,x,t,t2,days_before,days_forecast,nuovi_positivi,totale_positivi,hospital,terapia_intensiva,daily_dead,tvgain,cum_vacc,tipo,spess2,line_num,tot_lines,f1,f2,f3,f4,f5,newcolors)
% creates a 3-panel figure

data_path='./data/';

blue=[0, 0.4470, 0.7410];
brown=[0.8500, 0.3250, 0.0980];
purple=[.5 0 .5];
olive=[.3 .4 .2];
light_olive=olive*0.8;
orange = [1 0.5 0];
red =[1 0.2 0.2];
cyan =[0.2 0.8 0.8];
black=[0 0 0];
gray=[17 17 17]/25;
magenta=[1 0 1];
blue2=[0 0 1];
yellow=[1 1 0];
green=[0 1 0];
    
load(strcat(data_path,'dailynewcases',scenario))
load(strcat(data_path,'currentcases',scenario))

NPP=NPP(:);
POSSTIMATI=POSSTIMATI(:);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(233)
f1(line_num)=plot([x(end);t2],[totale_positivi(end);POSSTIMATI(t>x(end))],'Color',tipo,'Linewidth',spess2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(232)
aux=movmean(nuovi_positivi,7);
f2(line_num)=plot([x(end);t2],[aux(end);NPP(t>x(end))],'Color',tipo,'Linewidth',spess2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(234)
f3(line_num)=plot([x(end);t2],[hospital(end);hosp_occup(t>x(end))],'Color',tipo,'Linewidth',spess2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(235)
f4(line_num)=plot([x(end);t2],[terapia_intensiva(end);ICU_occup(t>x(end))],'Color',tipo,'Linewidth',spess2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(236)
aux=movmean(daily_dead,7);
f5(line_num)=plot([x(end);t2],[aux(end);daily_deaths(t>x(end))],'Color',tipo,'Linewidth',spess2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2*tot_lines,3,3*(line_num-1)+1)
immuni_area_plot(x,t,days_before,daily_dead,daily_deaths,nuovi_positivi,NPP,cum_vacc,newcolors);
set(gca,'XTickLabel',[]);



%title('R_0=0.9')


end

