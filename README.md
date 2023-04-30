This repository contains the program files which make up the work involved the results of the Group 3 team concerning their project from the Univerity of Arizona's "Introduction to Mathematical Modeling" course.

The repository contains original and amended code from authors (1) Giulia Giordano, Marta Colaneri, Alessandro Di Filippo, Franco Blanchini, Paolo Bolzern, Giuseppe De Nicolao, Paolo Sacchi, Patrizio Colaneri & Raffaele Bruno which was downloaded from their research at https://www.nature.com/articles/s41591-021-01334-5#Sec2 and code from (2) Giulia Giordano, Franco Blanchini, Raffaele Bruno, Patrizio Colaneri, Alessandro Di Filippo, Angela Di Matteo & Marta Colaneri at https://www.nature.com/articles/s41591-020-0883-7 .

There are three folders in this single branch project. The first folder, “Health_Cost_and_SIDARTHEV_model”, contains the original code downloaded from (1) with the exception of line 39 in file “covid_ita_csv_new.m”, which was changed by the collaborators of this repository to access the csv file from the contents of the folder when it had originally tried to access this file from some Google Drive folder. 

The second folder, “SIDARTHE_code”, is the original code downloaded from (2). 

The third folder, “modified_SIDARTHEcode_with_vaccination”, is the amended code from (2), extended so that the SIDARTHE considers the effects of vaccination and is termed SIDARTHE-V, along with copies of this amended code and continued amendments so that the model accounts for our team’s assumption that recovered individuals may be reinfected, unlike the researchers referenced in this readme, by incorporating a reinfection parameter which returns recovered populace to susceptible at varying rates. There is a new file for each new expression of how recovered persons return to the susceptible population. As example, we can say that people are removed and placed into the susceptible population at a constant rate, and this example pertains to one file which is a derivative of our SIDARTHE-V model simulation; similarly, we can say that a piecewise-constant function describes the rate at which people are moved from the recovered to susceptible population and this situation corresponds to another file.

Specific information to the files inside folders is found in the README files of each folder.
