function [vacc_people] = already_vacc_2doses
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

% 2nd dose vaccinations by age until March 2
% Source: Covid-19 Opendata Vaccini
% https://github.com/italia/covid19-opendata-vaccini
%
% 1509    16-19
% 151367	20-29
% 222676	30-39
% 277852	40-49
% 371578	50-59
% 232043	60-69
% 56038     70-79
% 88806	80-89
% 62805	90+

% 2nd dose vaccinations by age until March 4
% Source: Covid-19 Opendata Vaccini
% https://github.com/italia/covid19-opendata-vaccini
%
% 1641    16-19
% 162620	20-29
% 234367	30-39
% 291199	40-49
% 388106	50-59
% 243529	60-69
% 60795     70-79
% 103357	80-89
% 67339	90+

vaccinated=[1641
162620
234367
291199
388106
243529
60795
103357
67339];

tot_vacc=sum(vaccinated);

vacc_people=zeros(size(age));

vacc_people=interp1(age,vaccinated,[16:100]','linear','extrap');

vacc_people=max([zeros(16,1);vacc_people],0);

vacc_people=vacc_people*tot_vacc/sum(vacc_people);

end

