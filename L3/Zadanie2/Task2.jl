#Vadym Liss

function mstycznych(f,pf,x0::Float64, delta::Float64, epsilon::Float64, maxit::Int)
    #funkcja rozwiązuje równanie f(x) = 0 metodą Newtona
    #Dane:
    #      f: funckja f(x) podana jako anonimowa funkcja
    #     pf: pochodzna f(x) podana jako anonimowa funkcja
    #     x0: przybliżenie początkowe
    #  delta: dokładność przybliżenia x
    #epsilon: dokładność przybliżenia f(x)
    #  maxit: maksymalna dopuszczalna liczba iteracji
    #
    #Wywołanie: mstycznych(x->x^2-5, x->2x, -4.0, 0.00001, 0.00001, 5)
    #
    #Wynik: czwórka (r, v, it, err) gdzie
    #      r: przybliżenie rozwiązania równania f(x) = 0
    #      v: f(r)
    #     it: liczba iteracji wykonanych przez algorytm
    #    err: sygnalizacja błędu
    #         0: nie wystąpił błąd
    #         1: nie osiągnięto wymaganej dokładności w maxit iteracji
    #         2: pochodna bliska 0
    it = 0
    x1::Float64 = 0.0
    v = f(x0)
    if abs(pf(x0)) < epsilon
        return (x1, f(x1), it, 2)
    end
    if abs(v) < epsilon
        return (x0, v, it, 0)
    end
    for k in 0:maxit
        x1 = x0-v/pf(x0)
        v = f(x1)
        if abs(x1-x0) < delta || abs(v) < epsilon
            return (x1, v, k+1, 0)
        end
        x0 = x1
    end
    return (x1, v, maxit, 1)
end

f(x) = x^2-1
pf(x) = 2*x
a = -3.0
b = -0.5
maxit = 100
x0 = 40.0
x1 = 2000.0
delta = 0.00001
epsilon = 0.00001
println("Wyniki uzyskane za pomocą metody:")
println("- Newtona:   $(mstycznych(f, pf, x0, delta, epsilon, maxit))")