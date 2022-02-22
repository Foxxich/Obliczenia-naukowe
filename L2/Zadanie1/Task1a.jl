#Written by Vadym Liss
using LinearAlgebra

x1 = [2.718281828, -3.141592654, 1.414213562, 0.5772156649, 0.3010299957]
x2 = [2.718281828, -3.141592654, 1.414213562, 0.577215664, 0.301029995]
y = [1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]

function count_forward(x, y, art_type)
    s::art_type = 0.0
    for i in 1:length(x)
        s += art_type(x[i])*art_type(y[i])
    end
    return s
end

println("x1*y")
println("Float32: s = $(count_forward(x1, y, Float32))")
println("Float64: s = $(count_forward(x1, y, Float64))")
println("x2*y")
println("Float32: s = $(count_forward(x2, y, Float32))")
println("Float64: s = $(count_forward(x2, y, Float64))")