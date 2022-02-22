#By Vadym Liss

function find_x(start)
    x::Float64 = start
    two::Float64 = 2.0
    
    while x*(1/x) == 1.0 && x < two
        x = nextfloat(x)
    end
    return x
end

println(find_x(1.5))
println(find_x(1.0))