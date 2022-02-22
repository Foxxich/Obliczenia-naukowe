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

end