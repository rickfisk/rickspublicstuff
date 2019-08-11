#!/usr/bin/ruby
#
#
#
#
require 'rounding.rb';
#Arrays
expected       = Array.[](17363, -5476, 7362, 19383, -27062, -11570, 0, 0, 57431, 34635, 44727, 27364)
incomes        = Array.[](86813, -27380, 36814, 96913, -135308, -162659, -113682, 213781, 291863, 173176, 223632, 136823)
rolling_tax    = Array.[]
#months = Array.[]('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec')

#                            totals           
historical_income     = 0.00
tax_paid              = 0.00 # register for total tax liability
current_tax_liability = 0.00
#taxrate               = 0.1999994999
taxrate               = 0.20


incomes.each_index { 

	|x| 

        # tally the income each iteration
	if x == 0 
		current_tax_liability = ( incomes[x] * taxrate ).round_to(1)
        else	
		
		#if we're still in the red due to losses past months, we have to adgust the tax liability accordingly
		if historical_income < 0
			current_tax_liability =  ( ( incomes[x] + historical_income ) * taxrate ).round_to(1)
		else
	            current_tax_liability = ( incomes[x] * taxrate ).round_to(1) 
		end

		#can't refund more than there is income
		if current_tax_liability < 0 && current_tax_liability < (tax_paid * -1)  
			current_tax_liability = ( tax_paid * -1 ).round_to(1) 
	        end

	end
	historical_income = ( historical_income + incomes[x] ).round_to(1) 
	tax_paid          = ( tax_paid          + current_tax_liability ).round_to(1)
	rolling_tax[x]    = current_tax_liability.round_to(1)
} 

#puts incomes.join(",") 
puts rolling_tax.join(",")
#puts expected.join(",")
