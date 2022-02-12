# Optimal Stopping problems 

This example demonstrates an optimal stopping problem used to value
a pharmaceutical patent. At each point in time during investment
the company can either continue to invest or abandon the project. 

The process of investment leads to learning about the cost to complete
the project. Once investment is complete the project is sold at market and receives
cash flows that evolve according to a geometric brownian motion process.

A Go version of this model can be found [here](https://github.com/danzoppo/realoptions).
See the references at that linke as well. Additionally a more extensive blog post 
that I wrote on this model can be found [here](https://freeholdfinance.com/2021/04/01/valuing-rd-and-patents-with-real-options-analysis/)

# Markov Decision Process

A Markov decision process is a way to conceptualize a problem. The system
Markovian because the next state only depends on the current state of 
the system. Two separate examples are given. The first is the valuation
of a pharmaceutical patent when the 
