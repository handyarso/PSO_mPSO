function [z]=fpeaks(x,y)
    z = 10-((3*(1-x).^2.*exp(-(x.^2) - (y+1).^2) ...
        - 10*(x/5 - x.^7 - y.^5).*exp(-x.^2-y.^2) ...
        - 1/3*exp(-(x+1).^2 - y.^2)));

%     z = 10-((3*(1-x).^2.*exp(-(x.^2) - (y+1).^2) ...
%         - 10*(x/5 - x.^3 - y.^5).*exp(-x.^2-y.^2) ...
%         - 1/3*exp(-(x+1).^2 - y.^2)));

%     z = 10-((3*(1-x).^2.*exp(-(x.^2) - (y+1).^2) ...
%         - 10*(x/5 - x.^3 - y.^5).*exp(2*(-x.^2-y.^2)) ...
%         - 1/3*exp(-(x+1).^2 - y.^2)));
end
