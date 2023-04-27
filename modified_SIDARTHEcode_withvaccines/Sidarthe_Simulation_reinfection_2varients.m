%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MATLAB Code for epidemic simulations with the SIDARTHE model in the work
%
% Based on Modelling the COVID-19 epidemic and implementation of population-wide interventions in Italy
% by Giulia Giordano, Franco Blanchini, Raffaele Bruno, Patrizio Colaneri, Alessandro Di Filippo, Angela Di Matteo, Marta Colaneri
% 
%This code now implements vaccines and reinfection of healed and vaccinated
%people. These modifications were done by Carl Ingebretsen

%This code now includes a second variant
%This is done by running a second copy of SIDARTHE-V
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DATA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Italian population
popolazione=60e6;

% Data 20 February - 5 April (46 days):
% Total Cases
CasiTotali = [3 20 79 132 219 322 400 650 888 1128 1694 2036 2502 3089 3858 4636 5883 7375 9172 10149 12462 15113 17660 21157 24747 27980 31506 35713 41035 47021 53578 59138 63927 69176 74386 80539 86498 92472 97689 101739 105792 110574 115242 119827 124632 128948]/popolazione; % D+R+T+E+H_diagnosticati
% Deaths
Deceduti = [0 1 2 2 5 10 12 17 21 29 34 52 79 107 148 197 233 366 463 631 827 1016 1266 1441 1809 2158 2503 2978 3405 4032 4825 5476 6077 6820 7503 8165 9134 10023 10779 11591 12428 13155 13915 14681 15362 15887]/popolazione; % E
% Recovered
Guariti = [0 0 0 1 1 1 3 45 46 50 83 149 160 276 414 523 589 622 724 1004 1045 1258 1439 1966 2335 2749 2941 4025 4440 5129 6072 7024 7432 8326 9362 10361 10950 12384 13030 14620 15729 16847 18278 19758 20996 21815]/popolazione; % H_diagnosticati
% Currently Positive
Positivi = [3 19 77 129 213 311 385 588 821 1049 1577 1835 2263 2706 3296 3916 5061 6387 7985 8514 10590 12839 14955 17750 20603 23073 26062 28710 33190 37860 42681 46638 50418 54030 57521 62013 66414 70065 73880 75528 77635 80572 83049 85388 88274 91246]/popolazione; % D+R+T

% Data 23 February - 5 April (from day 4 to day 46)
% Currently positive: isolated at home
Isolamento_domiciliare = [49 91 162 221 284 412 543 798 927 1000 1065 1155 1060 1843 2180 2936 2599 3724 5036 6201 7860 9268 10197 11108 12090 14935 19185 22116 23783 26522 28697 30920 33648 36653 39533 42588 43752 45420 48134 50456 52579 55270 58320]/popolazione; %D
% Currently positive: hospitalised
Ricoverati_sintomi = [54 99 114 128 248 345 401 639 742 1034 1346 1790 2394 2651 3557 4316 5038 5838 6650 7426 8372 9663 11025 12894 14363 15757 16020 17708 19846 20692 21937 23112 24753 26029 26676 27386 27795 28192 28403 28540 28741 29010 28949]/popolazione; % R
% Currently positive: ICU
Terapia_intensiva = [26 23 35 36 56 64 105 140 166 229 295 351 462 567 650 733 877 1028 1153 1328 1518 1672 1851 2060 2257 2498 2655 2857 3009 3204 3396 3489 3612 3732 3856 3906 3981 4023 4035 4053 4068 3994 3977]/popolazione; %T


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PARAMETERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Simulation horizon: CAN BE MODIFIED AT ONE'S WILL PROVIDED THAT IT IS AT
% LEAST EQUAL TO THE NUMBER OF DAYS FOR WHICH DATA ARE AVAILABLE
Orizzonte = 350;

% Plot yes/no: SET TO 1 IF PDF FIGURES MUST BE GENERATED, 0 OTHERWISE
plotPDF = 0;

% Time-step for Euler discretisation of the continuous-time system
step=0.01;

% Transmission rate due to contacts with UNDETECTED asymptomatic infected
alfa=0.57;
% Transmission rate due to contacts with DETECTED asymptomatic infected
beta=0.0114;
% Transmission rate due to contacts with UNDETECTED symptomatic infected
gamma=0.456;
% Transmission rate due to contacts with DETECTED symptomatic infected
delta=0.0114;

% Detection rate for ASYMPTOMATIC
epsilon=0.171;
% Detection rate for SYMPTOMATIC
theta=0.3705;

% Worsening rate: UNDETECTED asymptomatic infected becomes symptomatic
zeta=0.1254;
% Worsening rate: DETECTED asymptomatic infected becomes symptomatic
eta=0.1254;

% Worsening rate: UNDETECTED symptomatic infected develop life-threatening
% symptoms
mu=0.0171;
% Worsening rate: DETECTED symptomatic infected develop life-threatening
% symptoms
nu=0.0274;

% Mortality rate for infected with life-threatening symptoms
tau=0.01;

% Recovery rate for undetected asymptomatic infected
lambda=0.0342;
% Recovery rate for detected asymptomatic infected
rho=0.0342;
% Recovery rate for undetected symptomatic infected
kappa=0.0171;
% Recovery rate for detected symptomatic infected
xi=0.0171;
% Recovery rate for life-threatened symptomatic infected
sigma=0.0171;

%to add the SIDARTHE-V version add a new constant phi
%phi=0.0001;
%phi=0.5;
%For starting at day 100
phi=0.0;

%Reinfection coefficients
%rein=0.005;
%rein_vacc = 0.005;
rein=0.000;
rein_vacc = 0.000;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DEFINITIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Parameters
r1=epsilon+zeta+lambda;
r2=eta+rho;
r3=theta+mu+kappa;
r4=nu+xi;
r5=sigma+tau;

% Initial R0
R0_iniziale=alfa/r1+beta*epsilon/(r1*r2)+gamma*zeta/(r1*r3)+delta*eta*epsilon/(r1*r2*r4)+delta*zeta*theta/(r1*r3*r4);

% Time horizon
t=1:step:Orizzonte;

% Vectors for time evolution of variables
S=zeros(1,length(t));
I=zeros(1,length(t));
D=zeros(1,length(t));
A=zeros(1,length(t));
R=zeros(1,length(t));
T=zeros(1,length(t));
H=zeros(1,length(t));
H_diagnosticati=zeros(1,length(t)); % DIAGNOSED recovered only!
E=zeros(1,length(t));
%For SIDARTHE-V add a V
V=zeros(1,length(t));

% Vectors for time evolution of actual/perceived Case Fatality Rate
M=zeros(1,length(t));
P=zeros(1,length(t));

% Vectors for time evolution of variables
S_2=zeros(1,length(t));
I_2=zeros(1,length(t));
D_2=zeros(1,length(t));
A_2=zeros(1,length(t));
R_2=zeros(1,length(t));
T_2=zeros(1,length(t));
H_2=zeros(1,length(t));
H_diagnosticati_2=zeros(1,length(t)); % DIAGNOSED recovered only!
E_2=zeros(1,length(t));
%For SIDARTHE-V add a V
V_2=zeros(1,length(t));

% Vectors for time evolution of actual/perceived Case Fatality Rate
M_2=zeros(1,length(t));
P_2=zeros(1,length(t));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INITIAL CONDITIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

I(1)=200/popolazione;
D(1)=20/popolazione;
A(1)=1/popolazione;
R(1)=2/popolazione;
T(1)=0.00;
H(1)=0.00;
E(1)=0.00;
V(1)=0.00;%For SIDARTHE-V
S(1)=1-I(1)-D(1)-A(1)-R(1)-T(1)-H(1)-E(1)-V(1);
I_2(1)=0;
D_2(1)=0;
A_2(1)=0;
R_2(1)=0;
T_2(1)=0.00;
H_2(1)=0.00;
E_2(1)=0.00;
V_2(1)=0.00;%For SIDARTHE-V
S_2(1)=0.0; %at first no susceptible to second variant

H_diagnosticati_2(1) = 0.00; % DIAGNOSED recovered only
Infetti_reali_2(1)=I_2(1)+D_2(1)+A_2(1)+R_2(1)+T_2(1); % Actual currently infected

M_2(1)=0;
P_2(1)=0;

% Whole state vector
%Added a V(1) at the end
x=[S(1);I(1);D(1);A(1);R(1);T(1);H(1);E(1);V(1);H_diagnosticati(1);Infetti_reali(1);S_2(1);I_2(1);D_2(1);A_2(1);R_2(1);T_2(1);H_2(1);E_2(1);V_2(1);H_diagnosticati_2(1);Infetti_reali_2(1)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SIMULATION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% "Control" binary variables to compute the new R0 every time a policy has
% changed the parameters
plottato = 0;
plottato1 = 0;
plottato_bis = 0;
plottato_tris = 0;
plottato_quat = 0;

for i=2:length(t)
    
    if (i>4/step) % Basic social distancing (awareness, schools closed)
        alfa=0.4218;
        gamma=0.285;
        beta = 0.0057;
        delta=0.0057;
        if plottato == 0 % Compute the new R0
            r1=epsilon+zeta+lambda;
            r2=eta+rho;
            r3=theta+mu+kappa;
            r4=nu+xi;
            r5=sigma+tau;
            R0_primemisure=alfa/r1+beta*epsilon/(r1*r2)+gamma*zeta/(r1*r3)+delta*eta*epsilon/(r1*r2*r4)+delta*zeta*theta/(r1*r3*r4)
            plottato = 1;
        end
    end
    
    if (i>12/step)
        % Screening limited to / focused on symptomatic subjects
        epsilon=0.1425;
        if plottato1 == 0
            r1=epsilon+zeta+lambda;
            r2=eta+rho;
            r3=theta+mu+kappa;
            r4=nu+xi;
            r5=sigma+tau;
            R0_primemisureeps=alfa/r1+beta*epsilon/(r1*r2)+gamma*zeta/(r1*r3)+delta*eta*epsilon/(r1*r2*r4)+delta*zeta*theta/(r1*r3*r4)
            plottato1 = 1;
        end
    end
    
    if (i>22/step) % Social distancing: lockdown, mild effect
        
        alfa=0.36;
        beta=0.005;
        gamma=0.2;
        delta=0.005;
        
        mu = 0.008;
        nu = 0.015;
        
        zeta=0.034;
        eta=0.034;
        
        lambda=0.08;
        rho=0.0171;
        kappa=0.0171;
        xi=0.0171;
        sigma=0.0171;
        
        if plottato_bis == 0 % Compute the new R0
            r1=epsilon+zeta+lambda;
            r2=eta+rho;
            r3=theta+mu+kappa;
            r4=nu+xi;
            r5=sigma+tau;
            R0_secondemisure=(alfa*r2*r3*r4+epsilon*beta*r3*r4+gamma*zeta*r2*r4+delta*eta*epsilon*r3+delta*zeta*theta*r2)/(r1*r2*r3*r4)
            plottato_bis = 1;
        end
    end
    
    if (i>28/step) % Social distancing: lockdown, strong effect
        
        alfa=0.21;
        gamma=0.11;
        
        if plottato_tris == 0 % Compute the new R0
            r1=epsilon+zeta+lambda;
            r2=eta+rho;
            r3=theta+mu+kappa;
            r4=nu+xi;
            r5=sigma+tau;
            R0_terzemisure=(alfa*r2*r3*r4+epsilon*beta*r3*r4+gamma*zeta*r2*r4+delta*eta*epsilon*r3+delta*zeta*theta*r2)/(r1*r2*r3*r4)
            plottato_tris = 1;
        end
    end
    
    if (i>38/step) % Broader diagnosis campaign
        
        epsilon = 0.2;
        rho=0.02;
        kappa=0.02;
        xi=0.02;
        sigma=0.01;
        
        zeta=0.025;
        eta=0.025;
        
        if plottato_quat == 0 % Compute the new R0
            r1=epsilon+zeta+lambda;
            r2=eta+rho;
            r3=theta+mu+kappa;
            r4=nu+xi;
            r5=sigma+tau;
            R0_quartemisure=(alfa*r2*r3*r4+epsilon*beta*r3*r4+gamma*zeta*r2*r4+delta*eta*epsilon*r3+delta*zeta*theta*r2)/(r1*r2*r3*r4);
            plottato_quat = 1;
        end
    end

    %To start vaccinations and reinefections at day 100
    if (i>100/step)
        phi=0.005;
        rein = 0.05;
        rein_vacc = 0.01;
    end
    
    % Compute the system evolution
    %ADDED A NEW zero to the end of each row and added a tenth row with 
    B=[-alfa*x(2)-beta*x(3)-gamma*x(4)-delta*x(5)-phi*x(9) 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
        alfa*x(2)+beta*x(3)+gamma*x(4)+delta*x(5) -(epsilon+zeta+lambda) 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
        0 epsilon  -(eta+rho) 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
        0 zeta 0 -(theta+mu+kappa) 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
        0 0 eta theta -(nu+xi) 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
        0 0 0 mu nu  -(sigma+tau) 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
        0 lambda rho kappa xi sigma 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
        0 0 0 0 0 tau 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
        phi*x(1) 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
        0 0 rho 0 xi sigma 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0 0 0 0 alfa_2*x(13)+beta_2*x(14)+gamma_2*x(15)+delta_2*x(16) 0 0 0 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0 0 0 0 -alfa_2*x(13)-beta_2*x(14)-gamma_2*x(15)-delta_2*x(16)-phi_2*x(20) 0 0 0 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0 0 0 0 alfa_2*x(13)+beta_2*x(14)+gamma_2*x(15)+delta_2*x(16) -(epsilon_2+zeta_2+lambda_2) 0 0 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0 0 0 0 0 epsilon_2  -(eta_2+rho_2) 0 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0 0 0 0 0 zeta_2 0 -(theta_2+mu_2+kappa_2) 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0 0 0 0 0 0 eta_2 theta_2 -(nu_2+xi_2) 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0 0 0 0 0 0 0 mu_2 nu_2  -(sigma_2+tau_2) 0 0 0 0 0;
        0 0 0 0 0 0 0 0 0 0 0 0 lambda_2 rho_2 kappa_2 xi_2 sigma_2 0 0 0 0 0;
        0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 tau_2 0 0 0 0 0;
        0 0 0 0 0 0 0 0 0 0 0 phi_2*x(12) 0 0 0 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0 0 0 0 0 0 rho_2 0 xi_2 sigma_2 0 0 0 0 0;
        0 0 0 0 0 0 0 0 0 0 0 alfa_2*x(13)+beta_2*x(14)+gamma_2*x(15)+delta_2*x(16) 0 0 0 0 0 0 0 0 0 0];
    x=x+B*x*step;
    
    % Update variables
    
    S(i)=x(1);
    I(i)=x(2);
    D(i)=x(3);
    A(i)=x(4);
    R(i)=x(5);
    T(i)=x(6);
    H(i)=x(7);
    E(i)=x(8);
    V(i)=x(9);%added V
    
    H_diagnosticati(i)=x(10);
    Infetti_reali(i)=x(11);
    
    % Update Case Fatality Rate
    
    M(i)=E(i)/(S(1)-S(i));
    P(i)=E(i)/((epsilon*r3+(theta+mu)*zeta)*(I(1)+S(1)-I(i)-S(i))/(r1*r3)+(theta+mu)*(A(1)-A(i))/r3);
    
    S_2(i)=x(12);
    I_2(i)=x(13);
    D_2(i)=x(14);
    A_2(i)=x(15);
    R_2(i)=x(16);
    T_2(i)=x(17);
    H_2(i)=x(18);
    E_2(i)=x(19);
    V_2(i)=x(20);%added V
    
    H_diagnosticati_2(i)=x(21);
    Infetti_reali_2(i)=x(22);
    
    % Update Case Fatality Rate
    
    M_2(i)=E_2(i)/(S_2(1)-S_2(i));
    P_2(i)=E_2(i)/((epsilon*r3+(theta+mu)*zeta)*(I_2(1)+S_2(1)-I_2(i)-S_2(i))/(r1*r3)+(theta+mu)*(A_2(1)-A_2(i))/r3);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FINAL VALUES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Variables
Sbar=S(length(t));
Ibar=I(length(t));
Dbar=D(length(t));
Abar=A(length(t));
Rbar=R(length(t));
Tbar=T(length(t));
Hbar=H(length(t));
Ebar=E(length(t));
Vbar=V(length(t));

% Case fatality rate
Mbar=M(length(t));
Pbar=P(length(t));

% Case fatality rate from formulas
Mbar1=Ebar/(S(1)-Sbar);
Pbar1=Ebar/((epsilon*r3+(theta+mu)*zeta)*(I(1)+S(1)-Sbar-Ibar)/(r1*r3)+(theta+mu)*(A(1)-Abar)/r3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIGURES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure
plot(t,Infetti_reali,'b',t,I+D+A+R+T,'r',t,H,'g',t,E,'k',t,V,'--black')%added V
hold on
plot(t,D+R+T+E+H_diagnosticati,'--b',t,D+R+T,'--r',t,H_diagnosticati,'--g')
xlim([t(1) t(end)])
ylim([0 0.015])
title('Actual vs. Diagnosed Epidemic Evolution with Reinfection')
xlabel('Time (days)')
ylabel('Cases (fraction of the population)')
legend({'Cumulative Infected','Current Total Infected', 'Recovered', 'Deaths','Vaccinated','Diagnosed Cumulative Infected','Diagnosed Current Total Infected', 'Diagnosed Recovered'},'Location','northwest')
grid

if plotPDF==1
    set(gcf, 'PaperUnits', 'centimeters');
    set(gcf, 'PaperPosition', [0 0 24 16]);
    set(gcf, 'PaperSize', [24 16]); % dimension on x axis and y axis resp.
    print(gcf,'-dpdf', ['PanoramicaEpidemiaRealevsPercepita.pdf'])
end
%

figure
plot(t,I,'b',t,D,'c',t,A,'g',t,R,'m',t,T,'r',t,V,'r')
xlim([t(1) t(end)])
%ylim([0 1.1e-3])
title('Infected, different stages, Diagnosed vs. Non Diagnosed with Reinfection')
xlabel('Time (days)')
ylabel('Cases (fraction of the population)')
legend({'Infected ND AS', 'Infected D AS', 'Infected ND S', 'Infected D S', 'Infected D IC','Vaccinated'},'Location','northeast')
grid

if plotPDF==1
    set(gcf, 'PaperUnits', 'centimeters');
    set(gcf, 'PaperPosition', [0 0 24 16]);
    set(gcf, 'PaperSize', [24 16]); % dimension on x axis and y axis resp.
    print(gcf,'-dpdf', ['SuddivisioneInfetti.pdf'])
end

%

figure
plot(t,D+R+T+E+H_diagnosticati)
hold on
stem(t(1:1/step:size(CasiTotali,2)/step),CasiTotali)
xlim([t(1) t(end)])
ylim([0 2.5e-3])
title('Cumulative Diagnosed Cases: Model vs. Data')
xlabel('Time (days)')
ylabel('Cases (fraction of the population)')
grid

if plotPDF==1
    set(gcf, 'PaperUnits', 'centimeters');
    set(gcf, 'PaperPosition', [0 0 16 10]);
    set(gcf, 'PaperSize', [16 10]); % dimension on x axis and y axis resp.
    print(gcf,'-dpdf', ['CasiTotali.pdf'])
end
%

figure
plot(t,H_diagnosticati)
hold on
stem(t(1:1/step:size(CasiTotali,2)/step),Guariti)
xlim([t(1) t(end)])
ylim([0 2.5e-3])
title('Recovered: Model vs. Data')
xlabel('Time (days)')
ylabel('Cases (fraction of the population)')
grid

if plotPDF==1
    set(gcf, 'PaperUnits', 'centimeters');
    set(gcf, 'PaperPosition', [0 0 16 10]);
    set(gcf, 'PaperSize', [16 10]); % dimension on x axis and y axis resp.
    print(gcf,'-dpdf', ['Guariti_diagnosticati.pdf'])
end
%

figure
plot(t,E)
hold on
stem(t(1:1/step:size(CasiTotali,2)/step),Deceduti)
xlim([t(1) t(end)])
ylim([0 2.5e-3])
title('Deaths: Model vs. Data - NOTE: EXCLUDED FROM FITTING')
xlabel('Time (days)')
ylabel('Cases (fraction of the population)')
grid

if plotPDF==1
    set(gcf, 'PaperUnits', 'centimeters');
    set(gcf, 'PaperPosition', [0 0 16 10]);
    set(gcf, 'PaperSize', [16 10]); % dimension on x axis and y axis resp.
    print(gcf,'-dpdf', ['Morti.pdf'])
end
%

figure
plot(t,D+R+T)
hold on
stem(t(1:1/step:size(CasiTotali,2)/step),Positivi)
xlim([t(1) t(end)])
ylim([0 2.5e-3])
title('Infected: Model vs. Data')
xlabel('Time (days)')
ylabel('Cases (fraction of the population)')
grid

if plotPDF==1
    set(gcf, 'PaperUnits', 'centimeters');
    set(gcf, 'PaperPosition', [0 0 16 10]);
    set(gcf, 'PaperSize', [16 10]); % dimension on x axis and y axis resp.
    print(gcf,'-dpdf', ['Positivi_diagnosticati.pdf'])
end
%

figure
plot(t,D)
hold on
stem(t(1+3/step:1/step:1+(size(Ricoverati_sintomi,2)+2)/step),Isolamento_domiciliare)
xlim([t(1) t(end)])
ylim([0 2.5e-3])
title('Infected, No Symptoms: Model vs. Data')
xlabel('Time (days)')
ylabel('Cases (fraction of the population)')
grid

if plotPDF==1
    set(gcf, 'PaperUnits', 'centimeters');
    set(gcf, 'PaperPosition', [0 0 16 10]);
    set(gcf, 'PaperSize', [16 10]); % dimension on x axis and y axis resp.
    print(gcf,'-dpdf', ['InfettiAsintomatici_diagnosticati.pdf'])
end
%

figure
plot(t,R)
hold on
stem(t(1+3/step:1/step:1+(size(Ricoverati_sintomi,2)+2)/step),Ricoverati_sintomi)
xlim([t(1) t(end)])
ylim([0 2.5e-3])
title('Infected, Symptoms: Model vs. Data')
xlabel('Time (days)')
ylabel('Cases (fraction of the population)')
grid

if plotPDF==1
    set(gcf, 'PaperUnits', 'centimeters');
    set(gcf, 'PaperPosition', [0 0 16 10]);
    set(gcf, 'PaperSize', [16 10]); % dimension on x axis and y axis resp.
    print(gcf,'-dpdf', ['InfettiSintomatici_diagnosticati_ricoverati.pdf'])
end
%

figure
plot(t,D+R)
hold on
stem(t(1+3/step:1/step:1+(size(Ricoverati_sintomi,2)+2)/step),Isolamento_domiciliare+Ricoverati_sintomi)
xlim([t(1) t(end)])
ylim([0 2.5e-3])
title('Infected, No or Mild Symptoms: Model vs. Data')
xlabel('Time (days)')
ylabel('Cases (fraction of the population)')
grid

if plotPDF==1
    set(gcf, 'PaperUnits', 'centimeters');
    set(gcf, 'PaperPosition', [0 0 16 10]);
    set(gcf, 'PaperSize', [16 10]); % dimension on x axis and y axis resp.
    print(gcf,'-dpdf', ['InfettiNonGravi_diagnosticati.pdf'])
end

%

figure
plot(t,T)
hold on
stem(t(1+3/step:1/step:1+(size(Ricoverati_sintomi,2)+2)/step),Terapia_intensiva)
xlim([t(1) t(end)])
ylim([0 2.5e-3])
title('Infected, Life-Threatening Symptoms: Model vs. Data')
xlabel('Time (days)')
ylabel('Cases (fraction of the population)')
grid

if plotPDF==1
    set(gcf, 'PaperUnits', 'centimeters');
    set(gcf, 'PaperPosition', [0 0 16 10]);
    set(gcf, 'PaperSize', [16 10]); % dimension on x axis and y axis resp.
    print(gcf,'-dpdf', ['InfettiSintomatici_diagnosticati_terapiaintensiva.pdf'])
end

%Plot the vaccinated
figure
plot(t,V)
hold on
%stem(t(1+3/step:1/step:1+(size(Ricoverati_sintomi,2)+2)/step),Terapia_intensiva)
xlim([t(1) t(end)])
ylim([0 2.5e-3])
title('Vaccinated: Model vs. Data')
xlabel('Time (days)')
ylabel('Vaccinated (fraction of the population)')
grid

%if plotPDF==1
    %set(gcf, 'PaperUnits', 'centimeters');
    %set(gcf, 'PaperPosition', [0 0 16 10]);
    %set(gcf, 'PaperSize', [16 10]); % dimension on x axis and y axis resp.
    %print(gcf,'-dpdf', ['InfettiSintomatici_diagnosticati_terapiaintensiva.pdf'])
%end
