#By Vadym Liss
x = [2.718281828, -3.141592654, 1.414213562, 0.5772156649, 0.3010299957]
y = [1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]
actual = -1.00657107000000*10^(-11)

function from_big(x, y, art_type)
    pos = zeros(art_type, 0)
    neg = zeros(art_type, 0)
    
    for i in 1:length(x)
        prod::art_type = x[i]*y[i]
        if prod > 0.0
            append!(pos, prod)
        else
            append!(neg, prod)
        end
    end
    return sum(reverse(sort(pos))) + sum(sort(neg))
end

println("Float32: s = $(from_big(x,y,Float32)) różnica: $(abs(from_big(x,y,Float32)-actual))")
println("Float64: s = $(from_big(x,y,Float64)) różnica: $(abs(from_big(x,y,Float64)-actual))")