#!/usr/bin//perl
#
#
use Math::Round qw(round);
use Data::Dumper;
#Arrays
my @expected    =   (17363, -5476, 7362, 19383, -27062, -11570, 0, 0, 57431, 34635, 44727, 27364);
my @incomes     =   (86813, -27380, 36814, 96913, -135308, -162659, -113682, 213781, 291863, 173176, 223632, 136823);
my @rolling_tax;
#my @months = ('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec')

#                            totals           
my $historical_income     = 0;
my $tax_paid              = 0;# register for total tax liability
my $current_tax_liability = 0;
my $taxrate               = 0.20;

my $counter = 0;
foreach my $income ( @incomes ) { 

        # tally the income each iteration
	if ($counter == 0 )  {
		$current_tax_liability = round($income * $taxrate); 
	} else {	
	        $current_tax_liability = round($income * $taxrate) ;
		
		# If we're still in the red due to losses past months, 
		# we have to adgust the tax liability accordingly
		if ( $historical_income lt  0 ) {
			$current_tax_liability = round( ($income + $historical_income ) * $taxrate);
		}
		#can't refund more than there is income
		if ( ( $current_tax_liability lt 0 ) 
                   && ( $current_tax_liability < $tax_paid * -1 )) {
			$current_tax_liability = $tax_paid * -1 ;
		}

        } 
	$historical_income       = round( $historical_income + $income ) ;
	$tax_paid                = round( $tax_paid    + $current_tax_liability ) ;
	$rolling_tax[$counter]   = round( $current_tax_liability);
        $counter++;
}

#print join( ",", @incomes ) . "\n";
print join( ",", @rolling_tax) . "\n";
#print join( ",", @expected) . "\n";
