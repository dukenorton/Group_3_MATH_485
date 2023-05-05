# MATLAB Code for epidemic simulations with the SIDARTHE-V model in the work
This folder includes the following Matlab scripts that can be used to reproduce the results in the article.[^1] Each file produces a number of figures when ran, but our team only focuses on figures 1 and 2 from each run for the files. Figures for the different amended code files from this project are kept in the "[Outputs](modified_SIDARTHEcode_withvaccines/Outputs)" folder.

This is amended code from [^1] by Andrew Olson, Carl Ingebretsen, Duke Norton, John Quillopo to include reinfection and different occurences of vaccination.

Date of last commit: 05/05/23

## Sidarthe_Simulation.m
"Matlab script to simulate the evolution of the SIDARTHE epidemic model, also compared to real data,
in the presence of containment/mitigation strategies (social distancing, lockdown, contact tracing and testing) that possibly vary over time.
The script contains the data and parameters to simulate the case study of COVID-19 epidemic in Italy, considered in the article,
but the parameters and the times at which they change can be adapted to suit any other case study."[^1]

In this file we have added the 'V' compartment to the model through simple variable definitions and changes to the system of equations represented in a matrix which is evolved by multiplying by a state vector. The original matrix is like this: 
```
    B=[-alfa*x(2)-beta*x(3)-gamma*x(4)-delta*x(5) 0 0 0 0 0 0 0 0 0;
        alfa*x(2)+beta*x(3)+gamma*x(4)+delta*x(5) -(epsilon+zeta+lambda) 0 0 0 0 0 0 0 0;
        0 epsilon  -(eta+rho) 0 0 0 0 0 0 0;
        0 zeta 0 -(theta+mu+kappa) 0 0 0 0 0 0;
        0 0 eta theta -(nu+xi) 0 0 0 0 0;
        0 0 0 mu nu  -(sigma+tau) 0 0 0 0;
        0 lambda rho kappa xi sigma 0 0 0 0;
        0 0 0 0 0 tau 0 0 0 0;
        0 0 rho 0 xi sigma 0 0 0 0;
        alfa*x(2)+beta*x(3)+gamma*x(4)+delta*x(5) 0 0 0 0 0 0 0 0 0];
```
Adding the 'V' compartment:

First redefine the state vector earlier in the code as, 
```
x=[S(1);I(1);D(1);A(1);R(1);T(1);H(1);E(1);V(1);H_diagnosticati(1);Infetti_reali(1)];
```
then
```
    B=[-alfa*x(2)-beta*x(3)-gamma*x(4)-delta*x(5)-phi*x(1) 0 0 0 0 0 0 0 0 0 0;
        alfa*x(2)+beta*x(3)+gamma*x(4)+delta*x(5) -(epsilon+zeta+lambda) 0 0 0 0 0 0 0 0 0;
        0 epsilon  -(eta+rho) 0 0 0 0 0 0 0 0;
        0 zeta 0 -(theta+mu+kappa) 0 0 0 0 0 0 0;
        0 0 eta theta -(nu+xi) 0 0 0 0 0 0;
        0 0 0 mu nu  -(sigma+tau) 0 0 0 0 0;
        0 lambda rho kappa xi sigma 0 0 0 0 0;
        0 0 0 0 0 tau 0 0 0 0 0;
        phi*x(1) 0 0 0 0 0 0 0 0 0 0;
        0 0 rho 0 xi sigma 0 0 0 0 0;
        alfa*x(2)+beta*x(3)+gamma*x(4)+delta*x(5) 0 0 0 0 0 0 0 0 0 0];
    x=x+B*x*step;
```
Phi (proportional to vaccination) is just a constant rate in this file, which we use as our control for the other files in this folder. One can adjust Phi in parameter definitions as whatever they choose.

## Sidarthe_Simulation_piecewise.m

This is like Simulation.m, adding the 'V' compartment; however, we have added Phi, for vaccination, to if-else code blocks so that it is updated piecewise-constant for appointed time-steps.

For example, from the file:
```
for i=2:length(t)
    
    if (i>4/step) % Basic social distancing (awareness, schools closed)
        alfa=0.4218;
        gamma=0.285;
        beta = 0.0057;
        delta=0.0057;
        phi=0.000001;
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
        phi=0.00001;
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
 ```
So phi is different for different indeces.

## Sidarthe_Simulation_piecewise_2.m

This is the same as Sidarthe_Simulation_piecewise.m but it ramps up a lot faster with vaccination. We have also created a separate if-else block inside the for loop rather than adding to the if-else like we did in the previous file, purely for convenience:

```
if (i>5/step)
        phi=0.00001;
        %rein=0.000001;
        %rein_vacc=0.000001;
    elseif (i>50/step)
        phi=0.00005;
        %phi=0.001;
        %rein=0.0001;
        %rein_vacc=0.0001;
    elseif (i>100/step)
        phi=0.0001;
        %rein=0.01;
        %rein_vacc=0.001;
    elseif (i>200/step)
        phi=0.005;
    end
 ```
 
 ## Sidarthe_Simulation_reinfection.m
 
 This is the same as Sidarthe_Simulation.m with the 'V' component added, but also adding reinfection parameters. We assume that persons who are vaccinated are less prone to reinfection than unvaccinated person. This is the reason for two new parameters 'rein' and 'rein_vacc'. We define these parameters and phi at constant rates begginning day 100 of the pandemic by updating them at the appointed index. Here is that index definition and the change the system matrix:
 
 ```
     if (i>200/step)
        phi=0.005;
        rein = 0.05;
        rein_vacc = 0.015;
    end
    
    % Compute the system evolution
    %ADDED new terms in the first, seventh and ninth equations to represent
    %reinfections
    B=[-alfa*x(2)-beta*x(3)-gamma*x(4)-delta*x(5)-phi*x(1) 0 0 0 0 0 rein 0 rein_vacc 0 0;
        alfa*x(2)+beta*x(3)+gamma*x(4)+delta*x(5) -(epsilon+zeta+lambda) 0 0 0 0 0 0 0 0 0;
        0 epsilon  -(eta+rho) 0 0 0 0 0 0 0 0;
        0 zeta 0 -(theta+mu+kappa) 0 0 0 0 0 0 0;
        0 0 eta theta -(nu+xi) 0 0 0 0 0 0;
        0 0 0 mu nu  -(sigma+tau) 0 0 0 0 0;
        0 lambda rho kappa xi sigma -rein 0 0 0 0;
        0 0 0 0 0 tau 0 0 0 0 0;
        phi*x(1) 0 0 0 0 0 0 0 -rein_vacc 0 0;
        0 0 rho 0 xi sigma 0 0 0 0 0;
        alfa*x(2)+beta*x(3)+gamma*x(4)+delta*x(5) 0 0 0 0 0 0 0 0 0 0];
    x=x+B*x*step;
  ```
 ## Sidarthe_Simulation_reinfection_piecwise.m
 
 This is the same as Sidarthe_Simulation_reinfection.m, except vaccination occurs piecewise-constant by updating the parameters at appointed indeces in the if-else block shown above in Sidarthe_Simulation_piecewise_2.m. One can adjust reinfection to occur piecewise-constant by uncommenting the reinfection parameter definitions inside that code block, but we assume that this is constant and leave it commented for the figures referenced for this file.
 
 ## Unfinished Files
 ### Sidarthe_Simulation_reinfection_Special.m
 This file was created in hopes to achieve what we do with Sidarthe_Simulation_reinfection_piecwise.m where vaccination occurs piecewise constant, but updating phi according to a gausian function which produces the correct value for phi at appointed time steps. This work is left unfinished and not included in the scope of our project, but we leave this for anyone and/or ourselves to return to if they choose.
 ### Sidarthe_Simulation_reinfection_2varients.m
 This file was created in hopes to investigate the effects of a new variant on the epidemic evolution. Essentially we would need to create another 'S' compartment for the model by appending an additional matrix to the one representing the system of equations and use parameters to move persons in compartments between model compartments. This work is left unfinished and not included in the scope of our project, but we leave this for anyone and/or ourselves to return to if they choose.
 
[^1]: https://www.nature.com/articles/s41591-020-0883-7
