#By Vadym Liss
x = [2.718281828, -3.141592654, 1.414213562, 0.5772156649, 0.3010299957]
y = [1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]
actual = -1.00657107000000*10^(-11)

function count_forward(x, y, art_type)
    s::art_type = 0.0
    for i in 1:length(x)
        s += x[i]*y[i]
    end
    return s
end

println("Float32: s = $(count_forward(reverse(x), reverse(y), Float32)) różnica: $(abs(count_forward(reverse(x), reverse(y), Float32)-actual))")
println("Float64: s = $(count_forward(reverse(x), reverse(y), Float64)) różnica: $(abs(count_forward(reverse(x), reverse(y), Float64)-actual))")