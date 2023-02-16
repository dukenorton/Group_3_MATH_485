function [aux] = immuni_area_plot(x,t,days_before,daily_dead,daily_deaths,nuovi_positivi,NPP,cum_vacc,newcolors)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

pop_tot=59641488;

cum_perc_dead=100*cumsum([daily_dead; daily_deaths(t>x(end))])/pop_tot;

cum_perc_pos=100*cumsum([nuovi_positivi; NPP(t>x(end))])/pop_tot;

cum_perc_vacc= [zeros(days_before,1);cum_vacc];

aux=[cum_perc_dead cum_perc_pos-cum_perc_dead cum_perc_vacc 100-(cum_perc_dead+cum_perc_pos+cum_perc_vacc) ];

%aux=[cum_perc_pos 100-(cum_perc_pos) ];

%newcolors = [black; yellow; olive; gray];

colororder(newcolors)

area(t,aux)


%xlim([x(1) t(end)]);

datetick('x','mmyy','keepticks')




box off



%legend('% dead','% infected and recovered','% vaccinated','% susceptibles','Location','NorthWest')


end

