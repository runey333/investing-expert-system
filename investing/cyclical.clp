/*
* Arun Sundaresan
*
* May 14, 2019
*
* This module contains a script to generate a list of companies in the consumer 
* cyclical sector and uses the askAll function to verify the health of each company.
*/
(deftemplate stock (slot query) (slot name))

(bind ?cyclical (create$))

(bind ?cyclical (insert$ ?cyclical (+ (length$ ?cyclical) 1) "Home Depot"))
(bind ?cyclical (insert$ ?cyclical (+ (length$ ?cyclical) 1) "McDonalds"))
(bind ?cyclical (insert$ ?cyclical (+ (length$ ?cyclical) 1) "Nike"))
(bind ?cyclical (insert$ ?cyclical (+ (length$ ?cyclical) 1) "Disney"))

(askAll ?cyclical)