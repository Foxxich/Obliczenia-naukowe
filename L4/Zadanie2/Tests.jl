#Vadym Liss

include("Interpolation.jl")
using .Interpolation
using Test

xi = [-2.0, -1.0, 0.0, 1.0, 2.0, 3.0]
fxi = [-25.0, 3.0, 1.0, -1.0, 27.0, 235.0]
i = ilorazyRoznicowe(xi, fxi)
print(warNewton(xi, i, 3.0))




