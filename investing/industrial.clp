/*
* Arun Sundaresan
*
* May 14, 2019
*
* This module contains a script to generate a list of companies in the industrial
* sector and uses the askAll function to verify the health of each company.
*/
(deftemplate stock (slot query) (slot name))

(bind ?industrial (create$))

(bind ?industrial (insert$ ?industrial (+ (length$ ?industrial) 1) "3M"))
(bind ?industrial (insert$ ?industrial (+ (length$ ?industrial) 1) "Caterpillar"))
(bind ?industrial (insert$ ?industrial (+ (length$ ?industrial) 1) "Boeing"))

(askAll ?industrial)