function z = griewank(x, y)
  z = (x.^2 + y.^2)/4000 - cos(x)*cos(y/sqrt(2)) + 1;
end

