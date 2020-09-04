/*
* Arun Sundaresan
*
* May 14, 2019
*
* This module contains a script to generate a list of companies in the technology
* sector and uses the askAll function to verify the health of each company.
*/
(deftemplate stock (slot query) (slot name))

(bind ?tech (create$))

(bind ?tech (insert$ ?tech (+ (length$ ?tech) 1) "Apple"))
(bind ?tech (insert$ ?tech (+ (length$ ?tech) 1) "Cisco"))
(bind ?tech (insert$ ?tech (+ (length$ ?tech) 1) "IBM"))
(bind ?tech (insert$ ?tech (+ (length$ ?tech) 1) "Intel"))
(bind ?tech (insert$ ?tech (+ (length$ ?tech) 1) "Microsoft"))
(bind ?tech (insert$ ?tech (+ (length$ ?tech) 1) "Verizon"))
(bind ?tech (insert$ ?tech (+ (length$ ?tech) 1) "United Technologies"))

(askAll ?tech)