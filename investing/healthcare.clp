/*
* Arun Sundaresan
*
* May 14, 2019
*
* This module contains a script to generate a list of companies in the healthcare
* sector and uses the askAll function to verify the health of each company.
*/
(deftemplate stock (slot query) (slot name))

(bind ?health (create$))

(bind ?health (insert$ ?health (+ (length$ ?health) 1) "Merck"))
(bind ?health (insert$ ?health (+ (length$ ?health) 1) "Pfizer"))
(bind ?health (insert$ ?health (+ (length$ ?health) 1) "United Health Group"))
   
(askAll ?health)