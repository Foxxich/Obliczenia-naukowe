#Vadym Liss

module Interpolation
export ilorazyRoznicowe, warNewton, naturalna, rysujNnfx
using Plots

function ilorazyRoznicowe(x::Vector{Float64}, f::Vector{Float64})
    #funkcja liczy ilorazy różnicowe wielomianu interpolującego funkcję w punktach x
    #Dane:
    #    x: wektor o długości n+1 zawierający węzły x_1, x_2,..., x_{n+1}
    #    f: wektor o długości n+1 zawierający wartości interpolowanej funkcji f(x_i) dla x_i z wektora x
    #
    #Wywołanie: ilorazyRoznicowe([3.0, 1.0, 5.0, 6.0], [1.0, -3.0, 2.0, 4.0])
    #
    #Wynik:
    #   fx: wektor o długości n+1 zawierające obliczone ilorazy różnicowe
    
    n = length(x)
    fx = copy(f)
    
    for i in 2:n
        for j in n:-1:i
            fx[j] = (fx[j]-fx[j-1])/(x[j]-x[j-i+1])
        end
    end
    
    return fx
end

function warNewton(x::Vector{Float64}, fx::Vector{Float64}, t::Float64)
    #funkcja liczy wartość wielomianu interpolacyjnego w punkcie t za pomocą uogólnionego algorytmu Hornera
    #Dane:
    #    x: wektor o długości n+1 zawierający węzły x_0, x_1,..., x_n
    #   fx: wektor długości n+1 zawierający ilorazy różnicowe
    #    t: punkt, w którym należy obliczyć wartość wielomianu
    #
    #Wywołanie: warNewton([3.0, 1.0, 5.0, 6.0], [1.0, 2.0, -3/8, 7/40], 4.0)
    #
    #Wynik:
    #   nt: wartość wielomianu w punkcie t
    
    n = length(x)
    nt = fx[n]
    
    for i in n-1:-1:1
        nt = fx[i] + (t-x[i]) * nt
    end

    return nt
end

function naturalna(x::Vector{Float64}, fx::Vector{Float64})
    #funkcja liczy współczynniki postaci naturalnej interpolowanego wielomianu na podstawie węzłów i ilorazów
    #różnicowych
    #Dane:
    #    x: wektor długości n+1 zawierający węzły x_0, x_1,..., x_n
    #   fx: wektor długości n+1 zawierający ilorazy różnicowe
    #
    #Wywołanie: naturalna([3.0, 1.0, 5.0, 6.0], [1.0, 2.0, -3/8, 7/40])
    #
    #Wynik:
    #   a: wektor długości n+1 zawierający obliczone współczynniki postaci naturalnej
    
    n = length(x)
    a = vec(zeros(Float64, 1, n))
    a[n] = fx[n]

    for i in n-1:-1:1
        a[i] = fx[i] - a[i+1]*x[i]
        for j in i+1:n-1
            a[j] -= a[j+1]*x[i]
        end
    end

    return a
end

function rysujNnfx(f,a::Float64,b::Float64,n::Int)
    #Dane:
    #    f: funkcja f(x) zadana jako anonimowa funkcja
    #  a,b: przedział interpolacji
    #    n: stopień wielomianu interpolacyjnego
    #
    #Wywołanie: rysujNnfx(x->x^3-x^2+5, -1.0, 1.0, 8)
    #
    #Wynik:
    #    -: funkcja rysuje wielomian interpolacyjny i interpolowaną funkcję w przedziale [a, b]
    
    accuracy = 20
    n_max = n + 1 
    
    x = Vector{Float64}(undef, n_max)
    y = Vector{Float64}(undef, n_max)
    f_x = Vector{Float64}(undef, n_max) 
    
    plot_x = Vector{Float64}(undef, n_max*accuracy) 
    plot_y = Vector{Float64}(undef, n_max*accuracy) 
    plot_ip = Vector{Float64}(undef, n_max*accuracy) 
    
    
    h = (b - a) / n
    kh = Float64(0.0)


    for i = 1:n_max
        x[i] = a + kh
        y[i] = f(x[i])
        kh += h
    end
    
    f_x = ilorazyRoznicowe(x, y)
    
    kh = Float64(0.0)
    n_max *= accuracy
    h = (b - a) / (n_max - 1)

    for i = 1:n_max
        plot_x[i] = a + kh
        plot_y[i] = f(plot_x[i])
        plot_ip[i] = warNewton(x, f_x, plot_x[i])
        kh += h
    end

    title = "Interpolacja dla n = " * string(n)
    savefig(plot(plot_x, [plot_y, plot_ip], label=["f(x)" "w(x)"], lw=2, title=title), "Tests.png")
end

end