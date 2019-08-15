"use strict";
const expected = [17363, -5476, 7362, 19383, -27062, -11570, 0, 0, 57431, 3465, 44727, 27364];
const incomes  = [86813, -27380, 36814, 96913, -135308, -162659, -113682, 213781, 291863, 173176, 223632, 136923];

let totalIncome = 0;
let taxPaid     = 0;
let rollingTax  = [];

const taxRate   = .20;

function main() {
    incomes.forEach(payTax);
    printResults();
}

function payTax(income) {

    let taxAmount;
    if ((totalIncome === 0) && (rollingTax.length === 0)) {
        taxAmount = income * taxRate;
    } else {
        taxAmount = income * taxRate;
    }

    if (totalIncome < 0) {
        taxAmount = (totalIncome + income) * taxRate;
    }

    if ((taxAmount < 0) && (taxAmount < (taxPaid * -1))) {
       taxAmount = (taxPaid * -1);
    }
    totalIncome = Math.round(totalIncome + income);
    rollingTax.push(Math.round(taxAmount));
    taxPaid = Math.round(taxPaid) + Math.round(taxAmount);
}

function printResults() {
    let x = rollingTax.toString();

    document.getElementById('container').insertAdjacentHTML('afterbegin','<p id="results">' + x + '</p>');
    //document.getElementById('container').insertAdjacentHTML('beforeend','<p id="expected">' + expected + '</p>');

}
