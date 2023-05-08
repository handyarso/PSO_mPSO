function z = rastrigin(x, y, A, k)
  z = A*2 + (x.^2 - A*cos(2*k*pi*x)) + (y.^2 - A*cos(2*k*pi*y));
end

