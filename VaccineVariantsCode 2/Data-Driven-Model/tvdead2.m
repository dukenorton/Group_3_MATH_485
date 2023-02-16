function [daily_deaths, tot_deaths] = tvdead2(B,F,tvgain,new_pos,init_state)
% daily deaths assuming that transfer function from new_pos to daily_deaths
% is B/F with gain replaced by time-varying gain tvgain

gain=sum(B)/sum(F);

%B=B/gain; % thus B/F has unit gain

%t=[1:length(new_pos)]';

L=length(tvgain);

u=new_pos(end-L+1:end).*tvgain/gain;


% order of filter numerator
nB=length(B)-1;

% initial state of filter

% if order of filter numerator is greater than zero, include
% past inputs in the filter initial conditions
if nB>0
    
    init_state=filtic(B,F,init_state,flip(new_pos(end-nB+1:end)));

end

daily_deaths=filter(B,F,u,init_state);

tot_deaths=sum(daily_deaths);

end

