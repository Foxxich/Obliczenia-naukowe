#Written by Vadym Liss
x1 = [2.718281828, -3.141592654, 1.414213562, 0.5772156649, 0.3010299957]
x2 = [2.718281828, -3.141592654, 1.414213562, 0.577215664, 0.301029995]
y = [1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]

function from_small(x, y, art_type)
    pos = zeros(art_type, 0)
    neg = zeros(art_type, 0)
    
    for i in 1:length(x)
        prod = art_type(x[i])*art_type(y[i])
        if prod > 0.0
            append!(pos, prod)
        else
            append!(neg, prod)
        end
    end
    return sum(sort(pos)) + sum(reverse(sort(neg)))
end

println("x1*y")
println("Float32: s = $(from_small(x1,y,Float32))")
println("Float64: s = $(from_small(x1,y,Float64))")
println("x2*y")
println("Float32: s = $(from_small(x2,y,Float32))")
println("Float64: s = $(from_small(x2,y,Float64))")