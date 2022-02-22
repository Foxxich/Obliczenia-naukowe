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

println("x_1: $(mbisekcji(x->3*x-ℯ^x, 0.5, 0.8, 0.0001, 0.0001))")
println("x_2: $(mbisekcji(x->3*x-ℯ^x, 1.5, 1.6, 0.0001, 0.0001))")