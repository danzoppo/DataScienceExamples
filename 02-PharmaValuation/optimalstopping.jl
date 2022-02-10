
struct CashProcess{T}
    annual_cash_flow::T
    drift::T 
    volatility::T 
    terminal_multiplier::T 
    risk_premium::T 
end

struct CostProcess{T}
    investment::T 
    total_cost::T 
    volatility::T 
    failure_rate::T 
end

struct SimOptions{T,U}
    time_step::T 
    term::U 
    runs::U 
    basis::Function 
end

struct ProjectProcess{T}
    CashProcess
    CostProcess
    correlation::T 
    risk_free_rate::T 
    SimOptions 
end

function main() 
    # TODO
    nothing
end

function simulate(pp::ProjectProcess)
    # Set the number of periods 
    periods = Int(ceil(pp.SimOptions.term / pp.SimOptions.time_step))

    # Risk adjusted cash flow drift rate 
    adj_cash_flow = pp.CashProcess.drift - pp.CashProcess.risk_premium

    # Set return matrices and correlated random errors.
    net_cash = randn(pp.SimOptions.runs, periods)
    cost = pp.correlation * cost_ϵ .+ sqrt(1 - pp.correlation^2) * randn(pp.SimOptions.runs,periods)

    # simulate the investment costs and correlated cash flows 
    @inbounds for run in 1:pp.SimOptions.runs, period in 1:periods
        # cash flow simulation
        prev_cash = period != 1 ? net_cash[run,period-1] : pp.CashProcess.annual_cash_flow
        net_cash[run,period] = prev_cash * exp((adj_cash_flow-0.5 * pp.CashProcess.volatility^2)*pp.SimOptions.time_step +
            pp.CashProcess.volatility * sqrt(pp.SimOptions.time_step) * net_cash[run,period])
        
        # cost simulation 
        prev_cost = period != 1 ? cost[run,period-1] : pp.CostProcess.total_cost
        current_cost = prev_cost - pp.CostProcess.investment * pp.SimOptions.time_step +
            pp.CostProcess.volatility * sqrt(pp.CostProcess.investment*pp.SimOptions.time_step) * cost[run,period]
        cost[run,period] = current_cost < 0.0 ? 0.0 : current_cost
    end
    return net_cash, cost 
end

