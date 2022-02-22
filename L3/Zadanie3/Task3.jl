#Vadym Liss

function msiecznych(f, x0::Float64, x1::Float64, delta::Float64, epsilon::Float64, maxit::Int)
    #funkcja rozwiązuje równanie f(x) = 0 metodą siecznych
    #Dane:
    #      f: funckja f(x) podana jako anonimowa funkcja
    # x0, x1: przybliżenia początkowe
    #  delta: dokładność przybliżenia x
    #epsilon: dokładność przybliżenia f(x)
    #  maxit: maksymalna dopuszczalna liczba iteracji
    #
    #Wywołanie: msiecznych(x->x^2-5, -4.5, -4.0, 0.00001, 0.00001, 5)
    #
    #Wynik: czwórka (r, v, it, err) gdzie
    #      r: przybliżenie rozwiązania równania f(x) = 0
    #      v: f(r)
    #     it: liczba iteracji wykonanych przez algorytm
    #    err: sygnalizacja błędu
    #         0: nie wystąpił błąd
    #         1: nie osiągnięto wymaganej dokładności w maxit iteracji
    f0 = f(x0)
    f1 = f(x1)
    for k in 0:maxit
        if abs(f0) > abs(f1)
            x0, x1 = x1, x0
            f0, f1 = f1, f0
        end
        s = (x1-x0)/(f1-f0)
        x1 = x0
        f1 = f0
        x0 -= f0*s
        f0 = f(x0)
        if abs(x1-x0) < delta || abs(f0) < epsilon
            return (x0, f0, k+1, 0)
        end
    end
    return (x0, f0, maxit, 1)
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
println("- siecznych: $(msiecznych(f, x0, x1, delta, epsilon, maxit))")
