#By Vadym Liss

function check_delta(beg, step, k_max)
    delta::Float64 = step
    start::Float64 = beg
    k::Float64 = 1.0
    done::Float64 = k_max
    one::Float64 = 1.0
    
    while k < done
        println(bitstring(start+k*delta))
        k += one
    end
end

println("Początek: 1, krok: 2^(-52)")
check_delta(1.0, 2^(-52), 10)
println("Początek: 0.5, krok: 2^(-53)")
check_delta(0.5, 2^(-53), 10)
println("Początek: 2, krok: 2^(-51)")
check_delta(2.0, 2^(-51), 10)
println("Początek: 3, krok: 2^(-51)")
check_delta(3.0, 2^(-51), 10)