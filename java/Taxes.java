
import java.util.*;
import java.lang.Math;


public class Taxes {

	public  Float taxrate;
	public  Float totalIncome;
        public  Float taxPaid;
	public  List<Float> rollingTax;
	public  List<Float> expected;
	public  List<Float> incomes;

	public Taxes() {
        taxrate     = 0.20f;
	totalIncome = 0.00f;
	taxPaid     = 0.00f;
	rollingTax  = new ArrayList<Float>();
	incomes  = Arrays.asList(86813f, -27380f, 36814f, 96913f, -135308f, -162659f, -113682f, 213781f, 291863f, 173176f, 223632f, 136823f);
	expected   = Arrays.asList(17363f, -5476f, 7362f, 19383f, -27062f, -11570f, 0f, 0f, 57431f, 34635f, 44727f, 27364f); 
	}
        	
	public static void main(String[] args) {

		  try {
		       Taxes tx  = new Taxes(); 
                       // System.out.print(tx.incomes.toString());
                       tx.run (args); 
		  } catch (Exception e)
		  {
			  e.printStackTrace();
		  } 

	}
	public void run(String[] args) { 

                  this.iterateThroughIncome();                       
		  this.showResults();
	}
	public void iterateThroughIncome() {

	       	this.incomes.forEach(e -> this.payTax(e));
	}
	public void payTax(Float income) {

		Float taxAmount = new Float(0.00f);

		/* if we haven;t paid tax yet then let's just keep it simple
		   First time through and subsequent times where the conditions are
		   simple. Edges are handled below*
		 * */
		if ( (this.taxPaid == 0) && (this.rollingTax.size() == 0 ) ) {
			taxAmount = income * this.taxrate;
		} else {
			taxAmount = income * this.taxrate;
		}

                
                // We've overpaid the taxes 
		if ( totalIncome  < 0 ) {

                	taxAmount =  (income + totalIncome)  * this.taxrate;

		} 

               /* can't refund more than there is income */
	       if ( (  taxAmount < 0 ) &&  ( taxAmount < ( (this.taxPaid * -1) ) ) ) {  

			taxAmount = ( this.taxPaid * -1 );

	       }

		totalIncome = new Float( Math.round(totalIncome + income) );
		this.rollingTax.add(new Float( Math.round(taxAmount)));
		this.taxPaid = new Float( Math.round ( this.taxPaid + taxAmount));

	}
	// display our results
	public void showResults() {

		prettyPrint(this.rollingTax);
	}

	// converts all members of a Float list to strings
	public void prettyPrint(List<Float> list) {
               
		int i = 1;
		for ( Float number : list ) {
			String formattedNumber = formatFloatToNonDecimalString(number);
		        System.out.print(formattedNumber);
			if (i < list.size() ) { 
				System.out.print(",");
			}
		i++;
		}
		System.out.print( "\n");
	}

	// remove trailing zeros for pretty display
	public String formatFloatToNonDecimalString(Float number) {
		String formattedNumber = String.format("%.0f",number);
		return formattedNumber;
	}
}
