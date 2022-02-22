# Vadym Liss
include("utils.jl")
include("matrixgen.jl")
using .matrixgen
using .blocksys
using .MatrixUtils
using Plots

# Testy z pliku
sciezki = ["tests/Dane100000/"]
folder = "results/"

function labTest() 
    for i = 1:length(sciezki)

        file_name = string(sciezki[i])
        full_name = SubString(file_name, 7, length(file_name) - 1)

        A, n, l = pobierzMacierz(string(sciezki[i], "A.txt") )
        b = generujWektorB(A, n, l)
        x = rozwiazUkladGaussZWyborem(A, b, n, l)
        zapiszDoPliku("results/gauss_wybor_$full_name.txt", x, n, true)
    
        A, n, l = pobierzMacierz(string(sciezki[i], "A.txt") )
        b = generujWektorB(A, n, l)
        x = rozwiazUkladGauss(A, b, n, l)
        zapiszDoPliku("results/gauss_$full_name.txt", x, n, true)
    
        A, n, l = pobierzMacierz(string(sciezki[i], "A.txt") )
        b = generujWektorB(A, n, l)
        A1, b1 = rozkladLU(A, b, n, l)
        x = rozwiazUkladLU(A1, b1, n, l)
        zapiszDoPliku("results/lu_$full_name.txt", x, n, true)
    
        A, n, l = pobierzMacierz(string(sciezki[i], "A.txt") )
        b = generujWektorB(A, n, l)
        A1, perm, b1 = rozkladLUZWyborem(A, b, n, l)
        x = rozwiazUkladLUZWyborem(A1, perm, b1, n, l)
        zapiszDoPliku("results/lu_wybor_$full_name.txt", x, n, true)
    end    
end

labTest()