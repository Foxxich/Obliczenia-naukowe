# Vadym Liss
include("task1.jl")

#funkcja przeprowadzajacy rozklad LU macierzy A metoda eliminacji gaussa
#A - macierz nxn
#b - wektor prawych stron
#n -rozmiar macierzy
#l - rozmiar macierzy wewnetrznych
function rozkladLU(A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64) 
    return eliminacjaGaussa(A, b, n, l, true)
end

#funkcja przeprowadzajacy rozklad LU macierzy A metoda eliminacji gaussa z czesciowym wyborem elementu glownego
#A - macierz nxn
#b - wektor prawych stron
#n -rozmiar macierzy
#l - rozmiar macierzy wewnetrznych
function rozkladLUZWyborem(A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64) 
     return eliminacjaGaussaZWyborem(A, b, n, l, true)
end