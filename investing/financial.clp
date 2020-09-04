/*
* Arun Sundaresan
*
* May 14, 2019
*
* This module contains a script to generate a list of companies in the financial
* sector and uses the askFinancial function to verify the health of each company.
*/
(deftemplate stock (slot query) (slot name))

(bind ?fin (create$))

(bind ?fin (insert$ ?fin (+ (length$ ?fin) 1) "American Express"))
(bind ?fin (insert$ ?fin (+ (length$ ?fin) 1) "Goldman Sachs"))
(bind ?fin (insert$ ?fin (+ (length$ ?fin) 1) "JP Morgan Chase"))
(bind ?fin (insert$ ?fin (+ (length$ ?fin) 1) "Travelers"))
(bind ?fin (insert$ ?fin (+ (length$ ?fin) 1) "Visa"))

(askFinancial ?fin)