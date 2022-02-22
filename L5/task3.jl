# Vadym Liss

include("task2.jl")

#funkcja rozwiazujaca uklad rownan Ax=b metoda eliminacji Gaussa przy znanym wczesniej rozkladzie LU
#A - macierz nxn
#b - wektor prawych stron
#n -rozmiar macierzy
#l - rozmiar macierzy wewnetrznych
function rozwiazUkladLU(A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64) 
    for i = 1:n-1
        sum = Float64(0.0)
        for j in i+1:min(n, i+ l + 1)
            b[j] = b[j] - A[j, i] * b[i]
        end
    end

    x = Vector{Float64}(undef, n)

    for i = n:-1:1
        sum = Float64(0.0)

        for j = i + 1:min(i+ l, n)
            sum += A[i, j] * x[j]
        end
        x[i] = (b[i] -  sum) / A[i, i]
    end
    return x
end


#funkcja rozwiazujaca uklad rownan Ax=b metoda eliminacji Gaussa z czesciowym wyborem elementu glownego przy znanym wczesniej rozkladzie LU
#A - macierz nxn
#b - wektor prawych stron
#n -rozmiar macierzy
#l - rozmiar macierzy wewnetrznych
function rozwiazUkladLUZWyborem(A::SparseMatrixCSC{Float64, Int64}, perm::Vector{Int64},
                                                b::Vector{Float64}, n::Int64, l::Int64) 
    for i = 1:n-1
        sum = Float64(0.0)
        for j in i+1:min(n, 2*l + i + 5)
            b[perm[j]] = b[perm[j]] - A[perm[j], i] * b[perm[i]]
        end
    end

    x = Vector{Float64}(undef, n)

    for i = n:-1:1
        sum = Float64(0.0)

        for j = i + 1:min(i + 2 * l, n)
            sum += A[perm[i], j] * x[j]
        end
        x[i] = (b[perm[i]] -  sum) / A[perm[i], i]
    end
    return x
end