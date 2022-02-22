#Vadym Liss

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

xi = [-2.0, -1.0, 0.0, 1.0, 2.0, 3.0]
fxi = [-25.0, 3.0, 1.0, -1.0, 27.0, 235.0]

print(ilorazyRoznicowe(xi, fxi))