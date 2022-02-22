#By Vadym Liss

function get_max(art_type)
    two::art_type = 2.0
    max = prevfloat(one(art_type))
    
    while !isinf(max*two)
            max *= two
    end
    return max
end

println("Float16:\n\tmax wyliczony: $(get_max(Float16))\n\tfloatmax(Float16): $(floatmax(Float16))")
println("Float32:\n\tmax wyliczony: $(get_max(Float32))\n\tfloatmax(Float32): $(floatmax(Float32))")
println("Float32:\n\tmax wyliczony: $(get_max(Float64))\n\tfloatmax(Float64): $(floatmax(Float64))")