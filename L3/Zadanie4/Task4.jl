#Vadym Liss

function mbisekcji(f, a::Float64, b::Float64, delta::Float64, epsilon::Float64)
    #funckja rozwiązuje równanie f(x) = 0 metodą bisekcji
    #Dane:
    #      f: funkcja f(x) podana jako anonimowa funkcja
    #      a: początek przedziału
    #      b: koniec przedziały
    #  delta: dokładność przybliżenia x
    #epsilon: dokładność przybliżenia f(x)
    #
    #Wywołanie: mbisekcji(x->x^2-5, -5.0, 0.0, 0.0001, 0.00001)
    #
    #Wynik: czwórka (r, v, it, err) gdzie
    #     r: przybliżenie rozwiązania równania f(x) = 0
    #     v: f(r)
    #    it: liczba iteracji wykonanych przez algorytm
    #   err: sygnalizacja błędu:
    #        0: brak błędu
    #        1: f nie zmienia znaku na przedziale [a,b]
    c::Float64 = 0.0
    w::Float64 = 0.0
    u = f(a)
    v = f(b)
    e = b-a
    it = 0
    if signbit(u) == signbit(v)
        return (c, w, it, 1)
    end
    while e > delta
        it += 1
        e /= 2.0
        c = a+e
        w = f(c)
        if abs(e) < delta || abs(w) < epsilon
            return (c, w, it, 0)
        end
        if signbit(w) != signbit(u)
            b = c
            v = w
        else
            a = c
            u = w
        end
    end
end

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

println("Wyniki uzyskane za pomocą metody:")
println("- bisekcji:  $(mbisekcji(x->sin(x)-(0.5*x)^2, 1.5, 2.0, 0.5*0.00001, 0.5*0.00001))")
println("- Newtona:   $(mstycznych(x->sin(x)-(0.5*x)^2, x->cos(x)-0.5*x, 1.5, 0.5*0.00001, 0.5*0.00001, 5))")
println("- siecznych: $(msiecznych(x->sin(x)-(0.5*x)^2, 1.0, 2.0, 0.5*0.00001, 0.5*0.00001, 5))")