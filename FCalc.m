function [estV] = FCalc(par, popsize, x, y, kasus)
    for i = 1:popsize
        xin = x(par(i,1));
        yin = y(par(i,2));
        switch kasus
            case 1
                calc = fpeaks(xin, yin);
            case 2
                calc = fsphere(xin, yin);
            case 3
                calc = frastrigin(xin, yin, 15, .25);
            case 4
                calc = fgriewank(xin, yin);
            case 5
                calc = fschaffer(xin, yin, .25);
            otherwise
        end    
        estV(i,:)=[xin yin calc];   % calc = misfit calculation
    end
end