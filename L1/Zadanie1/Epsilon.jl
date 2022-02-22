#By Vadym Liss

function get_macheps(art_type)
    macheps::art_type = 1.0
    one::art_type = 1.0
    two::art_type = 2.0
    
    while one + macheps > one
            macheps /= two
    end
    macheps *= two
    return macheps
end

println("Float16:\n\tmacheps wyliczony: $(get_macheps(Float16))\n\teps(Float16): $(eps(Float16))")
println("Float32:\n\tmacheps wyliczony: $(get_macheps(Float32))\n\teps(Float32): $(eps(Float32))")
println("Float64:\n\tmacheps wyliczony: $(get_macheps(Float64))\n\teps(Float64): $(eps(Float64))")

println("Precyzja Float16: ", 2^-11)
println("Precyzja Float32: ", 2^-24)
println("Precyzja Float64: ", 2^-53)