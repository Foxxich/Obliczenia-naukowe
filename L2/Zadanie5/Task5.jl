#Written by Vadym Liss
function simulation(my_type, mod::Bool)
    result = []
    p::my_type = 0.01
    r::my_type = 3.0
    one::my_type = 1.0
    
    for i in 1:40
        p = p + r * p * (one - p)
        
        if mod == true && i == 10
            p = trunc(p, digits=3)
        end
        append!(result, p)
    end

    return result
end

s1 = simulation(Float32, false)
s2 = simulation(Float32, true)

println("Bez modyfikacji", "      ", "Z modyfikacją")
for i in 1:length(s1)
    println(i, "    ", s1[i], "           ", s2[i])
end

s3 = simulation(Float64, false)

println("Float32", "                  ", "Float64")
for i in 1:length(s1)
    println(i, "    ", s1[i], "           ", s3[i])
end