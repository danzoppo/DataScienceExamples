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

#function main()
    Δt = 3 * 1 / 1000
    market = Market(3,1000,10000,10/100)
    inventory = vcat(0:25:100,150,200:100:900,950:50:1100,1200:100:1800,1850,1900:25:2000)
    max_inventory = maximum(inventory)
    min_inventory = minimum(inventory)

    withdrawn_gas = withdraw.(inventory, Δt, min_inventory)
    purchased_gas = inject(inventory, time_step)

#end

function simulate(p::PriceProcess, m::Market)
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

function terminal_value(prices,inventory, term_inv)
    return -2 * prices[:,end] .* max.(term_inv .- inventory, 0)
end

"""
    inject 
    The rate of gas injected into the reservoir as a function of the current inventory.
"""
function inject(inventory, time_step)
    # hydro gas constants
    k2 = 730000
    k3 = 500 
    k4 = 2500

    inven_factor = 1 / (inventory + k3)
    deduct_factor = 1 / k4 
    return k2 * sqrt(inven_factor - deduct_factor) * time_step
end

""" 
    withdraw releases gas from the reservoir based on the given inventory levels and 
    the gas constants.
"""
function withdraw(inventory, time_step, min_inventory)
    k1 = 2040.41
    return max(k1 * sqrt(inventory) * time_step, min_inventory - inventory)
end
    

    

end

end #module