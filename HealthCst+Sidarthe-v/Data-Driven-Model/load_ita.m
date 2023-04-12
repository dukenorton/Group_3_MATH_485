% Caricamento dati Italia e definizione vettori

covid_ita_csv_new

reglab='Italia';
nday=size(itanaz);
day0=datenum(2020,02,23);
x=day0 + [1:nday]';

morti = itanaz{:,'deceduti'};
daily_dead=diff([0;morti]);
terapia_intensiva=itanaz{:,'terapia_intensiva'};
d_terapia_intensiva=diff([0;terapia_intensiva]);
ricoverati_con_sintomi=itanaz{:,'ricoverati_con_sintomi'};
d_ricoverati_con_sintomi=diff([0;ricoverati_con_sintomi]);
hospital=terapia_intensiva+ricoverati_con_sintomi;
d_hospital=diff([0;hospital]);
dimessi_guariti=itanaz{:,'dimessi_guariti'};
totale_casi=itanaz{:,'totale_casi'};
totale_positivi=itanaz{:,'totale_positivi'};
isolamento_domiciliare=itanaz{:,'isolamento_domiciliare'};
tamponi=itanaz{:,'tamponi'};
nuovi_positivi=itanaz{:,'nuovi_positivi'};
tamponinew=[diff([0;tamponi])];
tot=morti+dimessi_guariti+totale_positivi;
casi_da_sospetto_diagnostico=itanaz{:,'casi_da_sospetto_diagnostico'};
nuovi_casi_da_sospetto_diagnostico=[NaN;diff(casi_da_sospetto_diagnostico)];
casi_da_screening=itanaz{:,'casi_da_screening'};
nuovi_casi_da_screening=[NaN;diff(casi_da_screening)];
casi_testati=itanaz{:,'casi_testati'};
nuovi_casi_testati=[NaN;diff(casi_testati)];
ingressi_terapia_intensiva=itanaz{:,'ingressi_terapia_intensiva'};
