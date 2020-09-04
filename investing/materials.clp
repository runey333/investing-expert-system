/*
* Arun Sundaresan
*
* May 14, 2019
*
* This module contains a script to generate a list of companies in the basic materials 
* sector and uses the askAll function to verify the health of each company.
*/
(deftemplate stock (slot query) (slot name))

(bind ?materials (create$))

(bind ?materials (insert$ ?materials (+ (length$ ?materials) 1) "Dow Inc."))
(bind ?materials (insert$ ?materials (+ (length$ ?materials) 1) "Chevron"))
(bind ?materials (insert$ ?materials (+ (length$ ?materials) 1) "Exxon Mobil"))

(askAll ?materials)