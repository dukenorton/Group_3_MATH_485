%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Definition of 4 vaccination roadmaps. 
% Source of fast one: Ministero della Salute
% Document: "Vaccinazione anti-SARS-CoV-2/COVID-19 PIANO STRATEGICO" (12.12.2020)
% https://www.trovanorme.salute.gov.it/norme/renderNormsanPdf?anno=2021&codLeg=78657&parte=1%20&serie=null
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% length of vaccination campaign
vacc_days=365; 

% time axis
t=[1:vacc_days]';

% In our "fast" schedule, each of the 4 phases T1, T2, T3, T4 of 
% the Strategic Plan of the Ministry of Health is completed
% within one quarter.
vacc_times=[0 90 180 270 365]';

% At the end of each phase the percentage of vaccinated people
% is equal to the target, see Fig.1 at page 7 of PIANO STRATEGICO
perc_vacc=[0 5 15 50 90]';

% fast roadmap: scale_factor = 1
% medium roadmap: scale_factor = 1.2
% slow roadmap: scale_factor = 1.4
scale_factor=[1 1.2 1.4];

daily_percent_vacc=zeros(vacc_days,3);

titolo={'FAST','MEDIUM','SLOW'};

for i=1:3

    % cumulative vaccination is obtained by linear interpolation of
    % the targets of the 4 quarters
    percent_vacc=interp1(scale_factor(i)*vacc_times,perc_vacc,t,'linear',90);
    
    % daily vaccination rate is obtained by differentiation
    daily_percent_vacc(:,i)=diff([0;percent_vacc]);

    % percentage of vaccinated people at the end of considered vaccination period
    tot_vacc=sum(daily_percent_vacc(:,i));

%     subplot(1,3,i)
% 
%     plot(t,daily_percent_vacc(:,i))
% 
%     title(titolo{i})

end

vacc_fast=daily_percent_vacc(:,1);

vacc_medium=daily_percent_vacc(:,2);

vacc_slow=daily_percent_vacc(:,3);

% zero vaccination roadmap
vacc_zero=zeros(size(daily_percent_vacc(:,1)));

% save file with daily vaccination rates for the three roadmaps
% save('perc_vacc_rates', 'vacc_fast','vacc_medium','vacc_slow');