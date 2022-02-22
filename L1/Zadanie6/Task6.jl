#By Vadym Liss
function f(x::Float64)
    return (x^2+1)^0.5-1
end

function g(x::Float64)
    return x^2/((x^2+1)^0.5+1)
end

function count_funcs(num)
    x::Float64 = 1/8
    for i in 1:num
        println("x: $(x) f(x): $(f(x)) g(x): $(g(x))")
        x /= 8
    end
end

count_funcs(12)