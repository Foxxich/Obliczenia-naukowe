#Vadym Liss

using Plots

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
    plot(plot_x, [plot_y, plot_ip], label=["f(x)" "w(x)"], lw=2, title=title)

end