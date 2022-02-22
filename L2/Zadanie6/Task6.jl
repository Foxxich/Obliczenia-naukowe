#Written by Vadym Liss
using Plots
using DelimitedFiles

arg_x = [i for i in 1:40]

function recursion(input)
    c::Float64 = input[1]
    x::Float64 = input[2]
    result = zeros(Float64, 0)
    for i in 1:40
        x = Float64(x*x) + c
        append!(result, x)
    end
    return result
end

c = [[-2, 1], [-2, 2], [-2, 1.99999999999999], [-1, 1], [-1, -1], [-1, 0.75], [-1, 0.25]]
for el in c
    println("Dla x = ", el[2], " dla c = ", el[1])
    println(recursion(el))
    println("")
    open("$(el).txt", "w") do io 
        writedlm(io, recursion(el)) 
    end
end

savefig(plot(arg_x, recursion([-2, 1]), seriestype = :scatter, title = "c = -2   x0 = 1"), "-2,1.png")
savefig(plot(arg_x, recursion([-2, 2]), seriestype = :scatter, title = "c = -2   x0 = 2"), "-2,2.png")
savefig(plot(arg_x, recursion([-2, 1.99999999999999]), seriestype = :scatter, title = "c = -2   x0 = 1.99999999999999"), "-2,1.99.png")
savefig(plot(arg_x, recursion([-1, 1]), seriestype = :scatter, title = "c = -1   x0 = 1"), "-1,1.png")
savefig(plot(arg_x, recursion([-1, -1]), seriestype = :scatter, title = "c = -1   x0 = -1"), "-1,-1.png")
savefig(plot(arg_x, recursion([-1, 0.75]), seriestype = :scatter, title = "c = -1   x0 = 0.75"), "-1, 0.75.png")
savefig(plot(arg_x, recursion([-1, 0.25]), seriestype = :scatter, title = "c = -1   x0 = 0.25"), "-1, 0.25.png")
