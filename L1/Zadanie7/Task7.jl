#By Vadym Liss
function count_approx_der(f, x::Float64, h::Float64)
    return (f(x+h)-f(x))/h
end

function count_der(x::Float64)
    return cos(x)-3*sin(3*x)
end

function f(x::Float64)
    return sin(x) + cos(3*x)
end

function count()
    h::Float64 = 1.0
    for i in 0:54
        println("wartość wyliczona: $(count_approx_der(f, 1.0, h)) błąd: $(abs(count_der(1.0)-count_approx_der(f, 1.0, h)))")
        h /= 2.0
    end
end

count()