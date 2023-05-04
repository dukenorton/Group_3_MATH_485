This repository contains the program files which make up the work involved the results of the Group 3 team concerning their project from the Univerity of Arizona's "Introduction to Mathematical Modeling" course.

The repository contains original and amended code from authors [^1] Giulia Giordano, Marta Colaneri, Alessandro Di Filippo, Franco Blanchini, Paolo Bolzern, Giuseppe De Nicolao, Paolo Sacchi, Patrizio Colaneri & Raffaele Bruno which was downloaded from their research and code from [^2] Giulia Giordano, Franco Blanchini, Raffaele Bruno, Patrizio Colaneri, Alessandro Di Filippo, Angela Di Matteo & Marta Colaneri.

# There are three folders in this single branch project:

## The first folder: “[Health_Cost_and_SIDARTHEV_model](https://github.com/dukenorton/Group_3_MATH_485/tree/main/Health_Cost_and%20SIDARTHEV_model)” 
This folder contains the original code downloaded from [^1] with the exception of line 39 in file “covid_ita_csv_new.m”, which was changed by the collaborators of this repository to access the csv file from the contents of the folder when it had originally tried to access this file from some Google Drive folder. 

## The second folder: “[SIDARTHE_code](https://github.com/dukenorton/Group_3_MATH_485/tree/main/SIDARTHE__code)”
This is the original code downloaded from [^2]. 

## The third folder: “[modified_SIDARTHEcode_with_vaccination](https://github.com/dukenorton/Group_3_MATH_485/tree/main/modified_SIDARTHEcode_withvaccines)”
This folder is the amended code from [^2], extended so that the SIDARTHE model considers the effects of vaccination and is termed SIDARTHE-V, along with copies of this file for SIDARTHE and [the changed file to get SIDARTHE-V](modified_SIDARTHEcode_withvaccines/Sidarthe_Simulation.m), with additional changes to those copies introducing reinfection parameters and different scenarios in which people become vaccinated. In total, there are 5 files that our team has produced: There is a copy of SIDARTHE as a control for comparison, the altered [SIDARTHE code before adding reinfection](modified_SIDARTHEcode_withvaccines/Sidarthe_Simulation.m) (simply the SIDARTHE-V code with constant vaccination), [SIDARTHE-V with vaccination occuring piecewise-constant](modified_SIDARTHEcode_withvaccines/Sidarthe_Simulation_piecewise.m) before introducing reinfection, [SIDARTHE-V with piecewise-constant vaccination, ramping up](modified_SIDARTHEcode_withvaccines/Sidarthe_Simulation_piecewise_2.m) faster than the other file and before introducing reinfection, then [SIDARTHE-V with reinfection and constant vaccination beggining day 100](modified_SIDARTHEcode_withvaccines/Sidarthe_Simulation_reinfection.m), and finally, [SIDARTHE-V with reinfection and piecewise-constant vaccination](modified_SIDARTHEcode_withvaccines/Sidarthe_Simulation_reinfection_piecwise.m).

Specific information regarding coding is contained within the README files of respective folders.

[^1]: https://www.nature.com/articles/s41591-021-01334-5#Sec2
[^2]: https://www.nature.com/articles/s41591-020-0883-7
