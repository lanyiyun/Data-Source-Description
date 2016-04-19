

function f = find_max(T)

n = T;

if n>2
    f(n) = [max(f(n-1)), max(min(f(n-1)), 5.5)];
elseif n == 2
    f = [5.5,5.5];
end
end