function z = fschaffer(x, y, r)
  term1 = (sin(r*sqrt(x.^2 + y.^2))).^2 - 0.5;
  term2 = (1 + 0.001*r*(x.^2 + y.^2)).^2;
  z = 0.5 + term1/term2;
end

