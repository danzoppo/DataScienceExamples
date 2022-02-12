module GMM

using Optim: optimize
using RDatasets: datasets  

# Import dataset cars 
const cars = datasets("MASS", "Cars93")

struct GMMData{T}
    y::Vector{T} 
    x::Matrix{T}
    weight::Matrix{T}
end

function estimate(gmm::GenMethodMomentsData)
end

end # module