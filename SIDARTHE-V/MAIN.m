
%%%%%%%%% LOAD DATA %%%%%%%

load_data

%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% LOAD SCENARIO

INDICE=1;
load_scenario

%%%%%% list of scenarios  %%%%%%
% INDICE=1 Open-close, slow vaccination
% INDICE=2 Open-close, medium  vaccination
% INDICE=3 Open-close, fast vaccination
% 
% INDICE=4 Open-close, adaptive  slow vaccination
% INDICE=5 Open-close, adaptive medium  vaccination
% INDICE=6 Open-close, adaptive fast vaccination
% 
% INDICE=7 Close-open,  slow vaccination
% INDICE=8 Close-open,  medium  vaccination
% INDICE=9 Close-open,  fast vaccination
% 
% INDICE=10 Close-open, adaptive slow vaccination
% INDICE=11 Close-open, adaptive medium  vaccination
% INDICE=12 Close-open, adaptive fast vaccination
% 
% INDICE=13 R0=0.9,  slow vaccination
% INDICE=14 R0=0.9,  medium  vaccination
% INDICE=15 R0=0.9,  fast vaccination
% 
% INDICE=16 R0=0.9, adaptiv  slow vaccination
% INDICE=17 R0=0.9, adaptive medium  vaccination
% INDICE=18 R0=0.9, adaptive fast vaccination
% 
% INDICE=19 R0=1.1,  slow vaccination
% INDICE=20 R0=1.1,  medium  vaccination
% INDICE=21 R0=1.1,  fast vaccination
% 
% INDICE=22 R0=1.1, adaptiv  slow vaccination
% INDICE=23 R0=1.1, adaptive medium  vaccination
% INDICE=24 R0=1.1, adaptive fast vaccination
% 
% INDICE=25 R0=1.27,  slow vaccination
% INDICE=26 R0=1.27,  medium  vaccination
% INDICE=27 R0=1.27,  fast vaccination
% 
% INDICE=28 R0=1.27, adaptiv  slow vaccination
% INDICE=29 R0=1.27, adaptive medium  vaccination
% INDICE=30 R0=1.27, adaptive fast vaccination
% 
% INDICE=32 Open-close, no vaccine
% INDICE=33 Close-open, no vaccine
% INDICE=34 RT=1.1, no vaccine 
% INDICE==35 RT=1.27, no vaccine
% INDICE=36 RT=0.9, no vaccine
% 
% INDICE=37 Open-close, Vaccination fast constant 
% INDICE=38 Open-close, Vaccination medium constant 
% INDICE=39 Open-close, Vaccination slow constant 




%%%%%%%% LOAD VACCINATION 

load_vaccination


%%%%%%%% LOAD PARAMATERS %%%%

load_parameters






%%%%%%%% SIMULATION %%%%%

simulation

%%%%%%%%%%%%%%%%%%%%%%%%%