# Vadym Liss
using SparseArrays

#funkcja przeprowadzajaca na macierzy eliminacje Gaussa
#A - macierz nxn
#b - wektor prawych stron
#n -rozmiar macierzy
#l - rozmiar macierzy wewnetrznych
#zRozkladem - flaga odpowiedzialna na przeprowadzanie eliminacji Gaussa (false) lub rozkladu LU (true) 
function eliminacjaGaussa(A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64, zRozkladem::Bool)
    for k = 1:n - 1
        m = l + 1 - ((k + 1) % l)
        for i = k + 1:min(k+m,n)
            a = A[i, k] / A[k, k]
            if zRozkladem
                A[i,k] = a
            else
                A[i,k] = zero(Float64)
            end
            for j = k + 1:min(k + l, n)
                A[i, j] -= a * A[k, j]
            end
            if !zRozkladem
                b[i] -= a * b[k]
            end
        end
    end
    return A, b
end

#funkcja rozwiazujaca uklad rownan Ax=B metoda eliminacji gaussa
#A - macierz nxn
#b - wektor prawych stron
#n -rozmiar macierzy
#l - rozmiar macierzy wewnetrznych

function rozwiazUkladGauss(A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64)
    _A, _b = eliminacjaGaussa(A, b, n, l, false)
    x = Vector{Float64}(undef, n)
    for i = n:-1:1
        suma = zero(Float64)
        for j = i + 1:min(n, i + l)
            suma += _A[i,j] * x[j]
        end
        x[i] = (_b[i] - suma) / _A[i, i]
    end
    return x
end

#funkcja przeprowadzajaca na macierzy eliminacje Gaussa z czesciowym wyborem elementu glownego
#A - macierz nxn
#b - wektor prawych stron
#n -rozmiar macierzy
#l - rozmiar macierzy wewnetrznych
#zRozkladem - flaga odpowiedzialna na przeprowadzanie eliminacji Gaussa (false) lub rozkladu LU (true) 
function eliminacjaGaussaZWyborem(A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64, zRozkladem::Bool)
    perm = Vector{Int64}(undef, n)
    for i = 1:n
        perm[i] = i
    end
    for k = 1:n - 1
        m = l + 1 - ((k + 1) % l)
        max_wiersz = k
        max_element = abs(A[k, k])
        for i = k:min(k+m,n)
            if abs(A[k, perm[i]]) > max_element
                max_element = abs(A[k, perm[i]])
                max_row = i
            end
        end
        perm[k], perm[max_wiersz] = perm[max_wiersz], perm[k]
        for i = k + 1:min(k+m,n)
            a = A[perm[i], k] / A[perm[k], k]
            if zRozkladem
                A[perm[i], k] = a
            else
                A[perm[i], k] = zero(Float64)
            end
            for j = k + 1:min(k + 2 * l, n)
                A[perm[i], j] -= a * A[perm[k], j]
            end
            if !zRozkladem
                b[perm[i]] -= a * b[perm[k]]
            end
        end 
    end

    return A, perm, b
end

#funkcja rozwiazujaca uklad rownan Ax=B metoda eliminacji gaussa z czesciowym wyborem elementu glownego
#A - macierz nxn
#b - wektor prawych stron
#n -rozmiar macierzy
#l - rozmiar macierzy wewnetrznych
function rozwiazUkladGaussZWyborem(A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64)
    _A, _perm, _b = eliminacjaGaussaZWyborem(A, b, n, l, false)
    x = Vector{Float64}(undef, n)

    for i = n:-1:1
        suma = zero(Float64)
        for j = i + 1:min(i + 2 * l + 1, n)
            suma += _A[_perm[i], j] * x[j]
        end
        x[i] = (_b[_perm[i]] - suma) / _A[ _perm[i], i]
    end

    return x
end



#funkcja pomocniczna do obliczania wartosci modulo w konkretnej kolumnie
function modulo(a, b)
    if a % b == b - 1
        return b
    else
        return a % b
    end
end