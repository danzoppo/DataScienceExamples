# wrap in a module for easy testing at the REPL
module NG 

abstract type AbstractInventory end 
abstract type AbstractPriceProcess end
abstract type AbstractMarket end 

struct Inventory{T} <: AbstractInventory
    terminal_inventory::T 
    min_inventory::T 
    max_inventory::T 
end

struct PriceProcess{T} <: AbstractPriceProcess
    initial_price::T
    volatility::T 
    mean_level::T 
    mean_rev_rate::T 
end

struct Market{T, U} <: AbstractMarket
    horizon::U 
    periods::U
    runs::U
    risk_free_rate::T 
end

function main()
    #inv = Inventory(1000,0,2000)
    nothing
end

function prices(p::PriceProcess, m::Market)
    # calc time step 
    Δt = time_step(m)
    # initialize return value. Julia is column major and 
    # access to period values per run will be need all at once, 
    # hence they are the columns.
    retval = randn(Float64, m.runs, m.periods)

    for period in 1:m.periods
        prev_price = period == 1 ? fill(p.initial_price, m.runs) : retval[:,period-1]
        retval[:,period] .= prev_price .+ p.mean_rev_rate .* (p.mean_level .- prev_price) .*
            Δt .+ p.volatility .* prev_price .* sqrt(Δt) .* retval[:,period]
    end
    return retval
end

function time_step(m::Market)
    return m.horizon * 1 / m.periods
end

const hoochie = 100

end #module