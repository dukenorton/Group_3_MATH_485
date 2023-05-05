This repository contains the matlab program files which make up the work for the results of Group 3 in Math 485, Introduction to Mathematical Modeling, at the University of Arizona, concerning their project "Modeling the Effect of Vaccines and Non-pharmaceutical Interventions on the Spread of COVID-19".
 
The repository contains original and amended code from authors [^1] Giulia Giordano, Marta Colaneri, Alessandro Di Filippo, Franco Blanchini, Paolo Bolzern, Giuseppe De Nicolao, Paolo Sacchi, Patrizio Colaneri & Raffaele Bruno which was downloaded from their research and code from [^2] Giulia Giordano, Franco Blanchini, Raffaele Bruno, Patrizio Colaneri, Alessandro Di Filippo, Angela Di Matteo & Marta Colaneri.

Project Colaborators: Andrew Olson, Carl Ingebretsen, Duke Norton, and John Quillopo

Last commit date: 05/05/23

# There are three folders in this single branch project:
## The first folder: “[Health_Cost_and_SIDARTHEV_model](https://github.com/dukenorton/Group_3_MATH_485/tree/main/Health_Cost_and%20SIDARTHEV_model)” 
This folder contains the original code downloaded from [^1] with the exception of line 39 in file [covid_ita_csv_new.m](https://github.com/dukenorton/Group_3_MATH_485/blob/main/Health_Cost_and%20SIDARTHEV_model/Data-Driven-Model/covid_ita_csv_new.m), which was changed by the collaborators of this repository to access the csv file from the contents of the folder when it had originally tried to access this file from some Google Drive folder. With this change to run the code successfully, our team uses this model to investigate and understand the results from the code authors which we hope to reproduce with our own model for SIDARTHE-V.
## The second folder: “[SIDARTHE_code](https://github.com/dukenorton/Group_3_MATH_485/tree/main/SIDARTHE__code)”
This is the original code downloaded from [^2] and used as a control for comparison to the work in the third folder.
## The third folder: “[modified_SIDARTHEcode_withvaccines](https://github.com/dukenorton/Group_3_MATH_485/tree/main/modified_SIDARTHEcode_withvaccines)”
This folder is the amended code from [^2], extended so that the SIDARTHE model considers the effects of vaccination and is termed SIDARTHE-V, along with copies of [the changed file to get SIDARTHE-V](modified_SIDARTHEcode_withvaccines/Sidarthe_Simulation.m) with additional changes to introduce reinfection parameters and different scenarios in which people become vaccinated. 

These files produce graphs of the predicted number of daily new cases for the COVID-19 pandemic.
### In total, there are 5 files that our team has produced our results from: 
There is the altered [SIDARTHE code before adding reinfection](modified_SIDARTHEcode_withvaccines/Sidarthe_Simulation_Constant_Vacc.m) and adds vaccination to the model so it is termed SIDARTHE-V (vaccination occurs at a constant rate here), [SIDARTHE-V with vaccination occuring piecewise-constant](modified_SIDARTHEcode_withvaccines/Sidarthe_Simulation_piecewise.m) before introducing reinfection, [SIDARTHE-V with piecewise-constant vaccination, ramping up](modified_SIDARTHEcode_withvaccines/Sidarthe_Simulation_piecewise_2.m) faster than the other file and before introducing reinfection, then [SIDARTHE-V with reinfection and constant vaccination beggining day 100](modified_SIDARTHEcode_withvaccines/Sidarthe_Simulation_reinfection.m), and finally, [SIDARTHE-V with reinfection and piecewise-constant vaccination](modified_SIDARTHEcode_withvaccines/Sidarthe_Simulation_reinfection_piecwise.m).

Specific information regarding coding is contained within the README files of respective folders.

[^1]: https://www.nature.com/articles/s41591-021-01334-5#Sec2
[^2]: https://www.nature.com/articles/s41591-020-0883-7
