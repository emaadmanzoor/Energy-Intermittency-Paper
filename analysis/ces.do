program drop nlces

program nlces

    version 15
    
    syntax varlist(min=4 max=4) [aw fw iw] if, at(name)
    local logout: word 1 of `varlist'
    local input_1: word 2 of `varlist'
    local input_2: word 3 of `varlist'
	local input_3: word 4 of `varlist'

    // Retrieve parameters out of at
    tempname b0 rho delta delta_2
    scalar `b0' = `at'[1,1]
    scalar `rho' = `at'[1,2]
    scalar `delta' = `at'[1,3]
	scalar `delta2' = `at'[1,4]

    // Some temporary variables
    tempvar kterm lterm third_term
    generate double `kterm' = `delta'*(`input_1' + 1)^(`rho') `if'
    generate double `lterm' = (1-`delta')*(`input_2' + 1)^(`rho') `if'
	generate double `third_term' = (`delta2')*(`input_3' + 1)^(`rho') `if'
	

    // Now fill in dependent variable
    replace `logout' = `b0' + 1/`rho'*ln(`kterm'+`lterm' + `third_term') `if'

end

// nl ces @ ln(q) a b, parameters(b0 rho delta) initial(b0 2 delta 0.23)
