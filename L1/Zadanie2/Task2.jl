#By Vadym Liss

function check_kahan(art_type)
    one::art_type = 1.0
    three::art_type = 3.0
    four::art_type = 4.0
    return three*(four/three-one)-one
end

println("Float16:\n\twyrażenie wyliczone: $(check_kahan(Float16))\n\teps(Float16): $(eps(Float16))")
println("Float32:\n\twyrażenie wyliczone: $(check_kahan(Float32))\n\teps(Float32): $(eps(Float32))")
println("Float64:\n\twyrażenie wyliczone: $(check_kahan(Float64))\n\teps(Float64): $(eps(Float64))")