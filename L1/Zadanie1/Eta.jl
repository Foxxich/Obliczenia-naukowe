#By Vadym Liss

function get_eta(art_type)
    eta::art_type = 1.0
    zero::art_type = 0.0
    two::art_type = 2.0
    
    while eta/two > zero
            eta /= two
    end
    return eta
end

println("Float16:\n\teta wyliczona: $(get_eta(Float16))\n\tnextfloat(Float16(0.0)): $(nextfloat(Float16(0.0)))")
println("Float32:\n\teta wyliczona: $(get_eta(Float32))\n\tnextfloat(Float32(0.0)): $(nextfloat(Float32(0.0)))")
println("Float64:\n\teta wyliczona: $(get_eta(Float64))\n\tnextfloat(Float64(0.0)): $(nextfloat(Float64(0.0)))")

println("Wartości MIN dla odpowiedniej arytmetyki:")
println(floatmin(Float32))
println(floatmin(Float64))