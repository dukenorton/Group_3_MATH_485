function colore = scenario_color(s)
% associates a color to each scenario


% s=1 (CO) olive
% s=2 (OC) red
% s=3 (1.2) purple
% s=4 (1.1) orange
% s=5 (0.9) blue
% s=6 (fast vacc with OC) blue2

cols=[.3 .4 .2
1 0.2 0.2
.5 0 .5
1 0.5 0
0 0.4470 0.7410
0 0 1];

colore = cols(s,:);
end

