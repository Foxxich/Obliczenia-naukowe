#Vadym Liss

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