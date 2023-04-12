function [cfr_t,age,percent_pop_pdf,percent_pop_cdf,cfr_age,percent_unvacc_t] = tvcfr(vacc_sched,cfr_2nd_wave)
% cfr_t = tvcfr(vacc_sched,cfr_2nd_wave)
% Computation of time-varying CFR given vaccination roadmap 
% assuming that vaccination is administered by decreasing ages
%
% Inputs:
% vacc_sched: vaccination roadmap (% daily vaccinated)
% cfr_2nd_wave: overall % Case Fatality Rate during 2nd wave
%
% Output:
% cfr_t: time series of case fatality rates


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Population data%
% Italian population by age at Jan 1 2021 (source: ISTAT)
% ISTAT-Istituto Nazionale di Statistica, Resident population on 1st January 2021 by age,
% http://dati.istat.it/Index.aspx
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[pop,age] = italianpop;

% total population
pop_tot=sum(pop);

% probability density function discretized by year
pop_pdf=pop/pop_tot;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Age-dependent CFR
% Source: Task force COVID-19 del Dipartimento Malattie Infettive 
% e Servizio di Informatica, Istituto Superiore di Sanità. 
% Epidemia COVID-19, Aggiornamento nazionale: 13 gennaio 2021,
% https://www.epicentro.iss.it/coronavirus/bollettino/Bollettino-sorveglianza-integrata-COVID-19_13-gennaio-2021.pdf
%
% IMPORTANT: lethality includes both 1st and 2nd wave
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ages: center of bins for which letality is available
agemort=[0 5 15 25 35 45 55 65 75 85 95]';

% age-dependent lethality (%)
percent_mortality=[0 0 0 0 0.1 0.2 0.6 2.9 10 19.6 24.9]';

% age-dependent lethality
mortality=percent_mortality/100;

% age-dependent CFR is obtained by interpolation on a 1-year sampled grid
cfr_age=interp1(agemort,mortality,age,'spline',mortality(end));
cfr_age=cfr_age.*(cfr_age>0);

% overall CFR is obtained by weighted average on age distribution
overall_mortality=cfr_age'*pop_pdf; % includes both 1st and 2nd wave

% 2nd wave overall CFR
wave2_mortality=cfr_2nd_wave/100;

% age-dependent CFR consistent with overall 2nd wave CFR
cfr_age=cfr_age*wave2_mortality/overall_mortality;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% age distribution of susceptible population after first vaccination period
% "vaccinated" means "successfully vaccinated" and refers to cumulative #
% of subjects that were administered 1st dose 3 weeks ago
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pop=pop-already_vacc;

% probability density function discretized by year
pop_pdf=pop/sum(pop);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FREQUENT RESAMPLING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% more frequent age grid
age2=[0:0.1:100]';

% age dependend CFR is interpolated on new age grid
cfr_age=interp1(age,cfr_age,age2);

% also age distribution is interpolated on new age grid
pop_pdf=interp1(age,pop_pdf,age2);

% cumulative distribution function of age on new age grid
pop_cdf=0.1*cumsum(pop_pdf);
percent_pop_cdf=100*pop_cdf;
percent_pop_pdf=100*pop_pdf;

% more frequent grid is used as default grid
age=age2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cumulative vaccination roadmap
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% cumulative profile of vaccinated (as % of total population)
percent_vacc=min(100,cumsum(vacc_sched));

% subjects still left unvaccinated (as % of total population)
percent_unvacc_t=100-percent_vacc;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DERIVATION OF TIME-VARYING CFR
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% initialize vector
cfr_t=zeros(size(percent_unvacc_t));

% cycle on future days of vaccination campaign
for i=1:length(percent_unvacc_t)
    
    % find maximum age of subjects that are still susceptible
    susc_age=max(0,interp1(percent_pop_cdf,age,percent_unvacc_t(i),'linear','extrap'));
    
    % initialize
    vacc_pop_pdf=pop_pdf;
    
    % age distribution of susceptible subjects if all people above susc_age have
    % been immunized by vaccination
    vacc_pop_pdf=vacc_pop_pdf.*(age<=susc_age);
    vacc_pop_pdf=vacc_pop_pdf/sum(vacc_pop_pdf);
    
    % CFR at i-th vaccination day is obtained by weighted average 
    % on age distribution of subjects that are still susceptible
    %cfr_t(i)=vacc_pop_pdf'*cfr_age;
    cfr_t(i)=vacc_pop_pdf'*cfr_age;
    
end

end

