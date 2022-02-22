#Written by Vadym Liss
using LinearAlgebra

function hilb(n::Int)
    # Function generates the Hilbert matrix  A of size n,
    #  A (i, j) = 1 / (i + j - 1)
    # Inputs:
    #	n: size of matrix A, n>=1
    #
    #
    # Usage: hilb(10)
    #
    # Pawel Zielinski
    if n < 1
        error("size n should be >= 1")
        end
    return [1 / (i + j - 1) for i in 1:n, j in 1:n]
end

function matcond(n::Int, c::Float64)
    # Function generates a random square matrix A of size n with
    # a given condition number c.
    # Inputs:
    #	n: size of matrix A, n>1
    #	c: condition of matrix A, c>= 1.0
    #
    # Usage: matcond(10, 100.0)
    #
    # Pawel Zielinski
    if n < 2
        error("size n should be > 1")
    end
    if c< 1.0
        error("condition number  c of a matrix  should be >= 1.0")
    end
    (U,S,V)=svd(rand(n,n))
    return U*diagm(0 =>[LinRange(1.0,c,n);])*V
end

function equation(A, n)
    x = ones(n, 1)
    b = A * x
    
    gauss = A \ b
    inverse = inv(A) * b
    
    gauss_err = norm(gauss - x) / norm(x)
    inverse_err = norm(inverse - x) / norm(x)
    println(n, "   ", rank(A), "      ", cond(A), "    ", gauss_err, "    ", inverse_err)
      
end

println("Macierz Hilberta")
println("Wyniki w postaci: ")
println("n rank(A)     cond(A)             eliminacja gaussa              inv")
for i in 2:1:30
    A = hilb(i)
    equation(A, i)   
end


println("Macierz losowa")
println("n rank(A)     cond(A)             eliminacja gaussa              inv")
c = [1, 10, 10^3, 10^7,10^12, 10^16]
n = [5, 10, 20]
for i in n
    for j in c
        A = matcond(i, Float64(j))
        equation(A, i)     
    end
  
end