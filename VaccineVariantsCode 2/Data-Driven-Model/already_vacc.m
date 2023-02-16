function [vacc_people] = already_vacc
% conversion of vaccinated people from 9 age classes to 1-year age grid

age=[17.5
24.5
34.5
44.5
54.5
64.5
74.5
84.5
94.5];

% 1st dose vaccinations by age until February 19
% Source: Covid-19 Opendata Vaccini
% https://github.com/italia/covid19-opendata-vaccini
%
% 2373     16-19
% 214679	20-29
% 300050	30-39
% 375891	40-49
% 472060	50-59
% 284994	60-69
% 81307     70-79
% 250768	80-89
% 106301	90+

% vaccinated=[2373
% 214679
% 300050
% 375891
% 472060
% 284994
% 81307
% 250768
% 106301];

% 1st dose vaccinations by age until March 2
% Source: Covid-19 Opendata Vaccini
% https://github.com/italia/covid19-opendata-vaccini
%
% 3167     16-19
% 265451	20-29
% 383293	30-39
% 511704	40-49
% 636184	50-59
% 357209	60-69
% 98267     70-79
% 720539	80-89
% 213218	90+

% 1st dose vaccinations by age until March 4
% Source: Covid-19 Opendata Vaccini
% https://github.com/italia/covid19-opendata-vaccini
%
% 3339    16-19
% 276259	20-29
% 402569	30-39
% 544087	40-49
% 684115	50-59
% 385862	60-69
% 105242     70-79
% 829600	80-89
% 247663	90+

vaccinated=[3339
276259
402569
544087
684115
385862
105242
829600
247663];

tot_vacc=sum(vaccinated);

vacc_people=zeros(size(age));

vacc_people=interp1(age,vaccinated,[16:100]','linear','extrap');

vacc_people=max([zeros(16,1);vacc_people],0);

vacc_people=vacc_people*tot_vacc/sum(vacc_people);

end

