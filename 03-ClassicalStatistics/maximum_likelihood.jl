module ML 

using Optim: optimize
using RDatasets: dataset

# Import Cars93 dataset as the example dataset 
const cars = dataset("MASS", "Cars93")

function main() 
end 

struct NormalData{T}
    y::Vector{T}
    x::Matrix{T}
end

function estimate(nd::NormalData)
    Optim.optimize()
end

end # module