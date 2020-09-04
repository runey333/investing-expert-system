/*
* Arun Sundaresan
*
* May 14, 2019
*
* This module contains a script to generate a list of companies in the consumer 
* defensive sector and uses the askAll function to verify the health of each company.
*/
(deftemplate stock (slot query) (slot name))

(bind ?def (create$))

(bind ?def (insert$ ?def (+ (length$ ?def) 1) "Johnson & Johnson"))
(bind ?def (insert$ ?def (+ (length$ ?def) 1) "Coca-Cola"))
(bind ?def (insert$ ?def (+ (length$ ?def) 1) "WalMart"))
(bind ?def (insert$ ?def (+ (length$ ?def) 1) "Walgreens Boots Alliance"))
(bind ?def (insert$ ?def (+ (length$ ?def) 1) "Procter & Gamble"))
   
(askAll ?def)