/*
* Arun Sundaresan and Eric Nelson
*
* May 3, 2019
* 
* This expert system recommends stocks to invest in from the 30 listed on
* the Dow Jones Industrial Average for new investors. It asks questions 
* relating to the health of the economy overall as well as the state
* of individual companies. This particular module asks about factors
* affecting the economy as a whole and contains a query to create
* a final list of stocks that should be invested in.
*/

(clear)
(reset)

(defglobal ?*MIN_STOCKS* = 10)
(batch investing/investing_utilities.clp)
(deftemplate stock (slot query) (slot name))


/*
* The rule below is meant to fire first, so it has a salience of 100. 
* It prints out a message to the user describing the purpose of this 
* expert system. 
*/
(defrule startUp "Prints a message explaining the purpose of this expert system"
   (declare (salience 100))
=>
   (printline "This expert system is for novice investors to build a starting portfolio.")
   (printline "You must respond to questions about the economy and business health.")
   (printline "Respond with y(yes), n(no), or ?(don't know). ")
   (printline "Type (runAgain) to use this expert system again. ")
   (printline "")
) ;defrule startUp

/*
* This rule asks if the US Federal Reserve announced economic contractions
* or rate hikes. These actions indicate an impending economic slowdown,
* meaning that investors will lose money, creating an unfavorable climate
* for new investors.
*/
(defrule badFedNews "Asks about announcements by the US Federal Reserve"

=>
   (bind ?question "Has the US Federal Reserve announced economic contraction ")
   (bind ?question (str-cat ?question "or a rate hike in the past 6 months? "))
   (bind ?x (askValidate ?question))
   (assert (badFedNews ?x))
) ;defrule badFedNews

/*
* This rule asks if the US government passed legislation to increase corporate
* regulation across the board. This will cause stock prices to drop, creating
* an unfavorable climate for a new investor.
*/
(defrule regulation "Asks about US corporate tax hikes"
   
=>
   (bind ?question "Has the US government recently announced corporate tax increases? ")
   (bind ?x (askValidate ?question))
   (assert (regulation ?x))
) ;defrule regulation

/*
* This rule determines whether or not to invest by testing if either the Federal
* Reserve made a negative announcement or the US government announced increased 
* tariffs. If either of these is true, the climate is not favorable for a novice
* investor.
*/
(defrule noInvestment
   (or (badFedNews "y") (regulation "y"))
=>
   (printline "You should not invest given these government and Fed actions.")
   (halt)
) ;defrule noInvestment

/*
* This rule fires when the user answers "?" to either the question about federal
* reserve or tariff announcements. If either fact representing the answers has 
* a value of "?", there is not enough knowledge to make a decision about whether 
* to invest.
*/
(defrule noKnowledge
   (or (badFedNews "?") (regulation "?")) 
=>
   (bind ?message "There isn't enough information to continue.")
   (bind ?message (str-cat ?message " Please find out about recent US    ")) 
   (bind ?message (str-cat ?message " Federal Reserve and US Government actions"))
   (bind ?message (str-cat ?message " before using this expert system again."))
   (printline ?message)
   (halt)
) ;defrule noKnowledge

/*
* In the case where the user indicates that there has been neither negative 
* news from the Federal Reserve nor widespread corporate regulation, this rule
* asserts a fact saying that the climate is optimal for new investors.
*/
(defrule doInvest
   (and (badFedNews "n") (regulation "n"))
=>
   (retract-string "(badFedNews \"n\")")
   (retract-string "(regulation \"n\")")
   (assert (badFedNews x))
   (assert (regulation x))
   (assert (tariffs x))
   (assert (invest y))
) ;defrule doInvest

/*
* This rule asks about tariffs on raw materials, which can be a death knell 
* for materials and industrial stocks. If no new tariffs are present, this rule 
* asserts a fact giving a positive verdict to investing in industrial
* and materials stocks.
*/
(defrule materialTariff "Asks if foreign countries imposed tariffs on US raw materials"
   (declare (salience 10))
   (invest y)
=>
   (bind ?q "Have foreign powers put tariffs on US raw materials in the last 6 months? ")
   (bind ?x (askValidate ?q)) 
   (if (eq ?x "n") then
      (assert (portfolio industrial))
      (assert (portfolio materials))
   )
) ;defrule materialTariff

/*
* This rule asks about government action relating to healthcare, which can harm
* the industry greatly. If no harmful actions are present, this rule asserts a 
* fact giving a positive verdict to investing in healthcare stocks.
*/
(defrule healthGov "Asks about factors affecting healthcare stocks"
   (declare (salience 10))
   (invest y)
=>
   (bind ?q "Is the ACA set to be repealed or is the US government projected to  
      take a larger role in healthcare? ")
   (bind ?x (askValidate ?q))
   (if (eq ?x "n") then
      (assert (portfolio healthcare))
   )
) ;defrule healthGov

/*
* All of the major pitfalls for the other sectors are covered in the badFedNews and
* regulation rules. This rule asserts facts about investing in the remaining sectors
* on the Dow Jones Industrial Average.
*/
(defrule dowSectors "Asserts facts about the remaining sectors"
   (invest y)
=>
   (assert (portfolio defensive))
   (assert (portfolio cyclical))
   (assert (portfolio tech))
   (assert (portfolio financial))
) ;defrule dowSectors

/*
* The rules below batch a knowledge island file for stocks of a particular sector.
*/

/*
* Batches a file with rules about the consumer defensive sector.
*/
(defrule defensive "Batches a file with rules about the consumer defensive sector"
   (portfolio defensive)
=>
   (batch investing/defensive.clp)
) ;defrule defensive

/*
* Batches a file with rules about the materials sector.
*/
(defrule materials "Batches a file with rules about the materials sector"
   (portfolio materials)
=>
   (batch investing/materials.clp)
) ;defrule materials

/*
* Batches a file with rules about the industrial sector.
*/
(defrule industrial "Batches a file with rules about the industrial sector"
   (portfolio industrial)
=>
   (batch investing/industrial.clp)
) ;defrule industrial

/*
* Batches a file with rules about the healthcare sector.
*/
(defrule healthcare "Batches a file with rules about the healthcare sector"
   (portfolio healthcare)
=>
   (batch investing/healthcare.clp)
) ;defrule healthcare

/*
* Batches a file with rules about the consumer cyclical sector.
*/
(defrule cyclical "Batches a file with rules about the consumer cyclical sector"
   (portfolio cyclical)
=>
   (batch investing/cyclical.clp)
) ;defrule cyclical

/*
* Batches a file with rules about the tech sector.
*/
(defrule tech "Batches a file with rules about the tech sector"
   (portfolio tech)
=>
   (batch investing/tech.clp)
) ;defrule tech

/*
* Batches a file with rules about the financial sector.
*/
(defrule financial "Batches a file with rules about the financial sector"
   (portfolio financial)
=>
   (batch investing/financial.clp)
) ;defrule financial


/*
* To convey that a particular stock should be invested in, this expert system 
* asserts a fact with the name of that stock and a letter used to distinguish
* these facts from others. This query examines the working memory to isolate
* all facts indicating that a stock should be invested in.
*/
(defquery search-stocks        
   (declare (variables ?q))
   (stock (query ?q) (name ?n))
) ;defquery search-stocks

/*
* The rule below, if its left hand is satisfied, will use the search-stocks 
* query to gather all stocks to be invested in and print a message to the user
* about the investment choices. Finally, this rule uses the halt function to
* stop running.
*/
(defrule finalizeStocks "Finds and prints stocks to be invested in"
   (declare (salience -100))
=>
   (bind ?count (count-query-results search-stocks "s"))
   
   (if (< ?count ?*MIN_STOCKS*) then
      (printline "There aren't enough eligible stocks to make a viable portfolio.")
   else
      (bind ?result (run-query* search-stocks "s"))
      (printline "You should invest in: ")
      (while (?result next) 
         (printout t (?result getString n) crlf)
      )
   )    
   (halt)
) ;defrule finalizeStocks

/*
* This function is meant to run the expert system again.
*/
(deffunction runAgain ()
   (reset)
   (run)
   (return)
) ;defrule runAgain

/*
* A JESS script to run the module is below.
*/
(run)


