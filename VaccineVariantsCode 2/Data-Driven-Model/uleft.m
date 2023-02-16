function [x,y] = uleft(string)
% writes stirng in the upper left corner of current plot

X=xlim; Y=ylim;

x=X(1)+(X(2)-X(1))/40;

y=Y(2)-(Y(2)-Y(1))/20;

text(x,y,string,'FontWeight','bold');

end

