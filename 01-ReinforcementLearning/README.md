# Practical Reinforcement Learning Examples

Reinforcement learning, called approximate dynamic programming, 
is a set of methods to solve intertemporal optimization problems. 
These problems have a wide range of applicability from robotics to
finance. 

The examples:

`pharma_valuation.jl`

This example demonstrates how a pharmaceutical company can value 
a pharmaceutical patent when company possess an opportunity to abandon
the project during the R&D phase. 

There are two sources of uncertainty in this model the expected investment
remaining and the net sales cash flow received upon completion of the project.

A Go version of this model can be found [here](https://github.com/danzoppo/realoptions).
See the references at that linke as well. Additionally a more extensive blog post 
that I wrote on this model can be found [here](https://freeholdfinance.com/2021/04/01/valuing-rd-and-patents-with-real-options-analysis/)

`natural_gas_valuation.jl`

This example demonstrates the valuation and control of a natural gas 
storage facility. This is an example of a stochastic storage problem. See the second reference for an introduction to the field. 

# References
