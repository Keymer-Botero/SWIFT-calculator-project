/*******************************************************************
 Name : Keymer A. Botero
 Course Name : Mobile Apps Development (CIS 240)
 
 Date : November 14th, 2018
 Due Date : November 26th, 2018
 
 Description : The purpose of this lab will be
 to implement logic needed to create
 a calculator and becoming familiar with
 constraints.
 
 *      In addition, for every different case there
 are brief descriptions that explain what conditions are needed
 to be met to proceed and what result will come out of each
 case.
 
 *      This program will also feature circular logic, allowing
 for continous calculations and the ability to use decimal
 symbol.
*******************************************************************/
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var numberDisplayLabel: UILabel!

    var equationHolder : (Float?, Float?) = (0,0)
    var operationHolder : Array<Int> = [] //Uses tags to store operation; tracks current operation
    var equationResult : Float = 0
    var nowPerformingOperations : Bool = false
    var operationComplete : Bool = false
    var decimalAdded : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.numberDisplayLabel.text = "0"
    }
    
    
/*================================================================
     MANAGES OPERATIONS OF CALCULATOR
     
     *       The purpose of this Button function is to manage all
     operations of the calculator
     
     *       It will first check if the does not any number entered
     or see if the user has pressed the equal sign button
     or clear button before completing an operation
     
     *       The following list will explain which tag numbers
     belong to what feature :
     
     Sender.tag = 11 -> Divide
     Sender.tag = 12 -> Multiply
     Sender.tag = 13 -> Subtract
     Sender.tag = 14 -> Addition
     Sender.tag = 15 -> Equal
     Sender.tag = 16 -> All Clear
     
================================================================*/
    @IBAction func buttonOperations(_ sender: UIButton)
        {
            nowPerformingOperations = true
            

            //CASE 1 : If user has not entered anything in and tries to perform an operation, assume it's zero and perforem regularly
            if (equationHolder.0 == 0 && (sender.tag == 11 || sender.tag == 12 || sender.tag == 13 || sender.tag == 14))
                    {
                        nowPerformingOperations = true
            
                        if (nowPerformingOperations == true) // tracks current operation
                            {
                                operationHolder.append(sender.tag)
                            }
                    }
            
                //CASE 2 : If the according button is entered, we are sure the user has entered in the correct operation
            else if (equationHolder.0 != 0 && sender.tag != 16 && sender.tag != 15)
                {
                    nowPerformingOperations = true
                    self.numberDisplayLabel.text = "" // Clears the label for the next incoming number
                    decimalAdded = false
                    
                    if (nowPerformingOperations == true)
                        {
                            operationHolder.append(sender.tag)
                        }
                }
        
        
            //CASE 3 : If user has not entered any number and pushes the equal sign button, return zero
            if (equationHolder.0 == 0 && sender.tag == 15)
                {
                    self.numberDisplayLabel.text = String(equationHolder.0!)
                    decimalAdded = false
                }
        
            //CASE 4 : If the user has only entered one number and tries to hit the equal button, it will only return the first number
            if (equationHolder.1 == 0 && sender.tag == 15)
                {
                    self.numberDisplayLabel.text = String(equationHolder.0!)
                    decimalAdded = false
                }
            
            //CASE 5 : If user hits the equal button and there is a number entered, perform the according operation. As it can be seen, certain operations are presented differently to either act as a countermeasure against non-valid decimal values/answers or provide efficiency for the function.
            else if (sender.tag == 15) // The equal buttomn
                {
                    //CASE EX 1 : Accounting for dividing by zero
                    if (operationHolder.last == 11 && equationHolder.1 == 0)
                        {
                            self.numberDisplayLabel.text = "ERROR"
                        }
                        
                    else
                        {
                            if operationHolder.last == 11
                                {
                                    self.numberDisplayLabel.text = String(equationHolder.0! / equationHolder.1!)
                                }
                                
                            else if operationHolder.last == 12
                                {
                                    equationResult = equationHolder.0! * equationHolder.1!
                                    self.numberDisplayLabel.text = String(equationResult)
                                }
                
                            else if operationHolder.last == 13
                                {
                                    equationResult = equationHolder.0! - equationHolder.1!
                                    equationResult = (equationResult * 100).rounded()/100
                                    self.numberDisplayLabel.text = String(equationResult)
                                }
                
                            else if operationHolder.last == 14
                                {
                                    equationResult = equationHolder.0! + equationHolder.1!
                                    self.numberDisplayLabel.text = String(equationResult)
                                }
                    
                        operationComplete = true
                        }
            }
        
                //CASE 6 : If the user pushes All Clear button, changes all values to zero and restart
                if (sender.tag == 16) // The clear button
                    {
                        self.numberDisplayLabel.text = "0"
                        equationHolder.0 = 0
                        equationHolder.1 = 0
                        equationResult = 0
                        operationHolder = []
                        nowPerformingOperations = false
                        decimalAdded = false
                    }
        
                //CASE 7: If the user wishes to continue doing making calculations, the result is stored into the first number, the second number clears its previous value and allows the user to input a new number.
                if (operationComplete == true)
                    {
                        equationHolder.0! = Float(self.numberDisplayLabel.text!)! // Stores result
                        self.numberDisplayLabel.text = String(equationHolder.0!) //continues displaying result
                        equationHolder.1 = 0 //clears second factor
                        equationResult = 0
                        operationHolder = []
                        nowPerformingOperations = true
                        operationComplete = false
                        //decimalAdded = true
                        
                    }
        }
    
/*================================================================
     MANAGES 0-9 BUTTON NUMBERS
     
     *     The purpose of this Button function is to manage all
     numerical buttons 0-9.
     
     *      This function is merely for efficiency, to avoid
     creating multiple button functions that provide
     identical functionality.
     
     *      Each button was tagged to a number to reduce any
     potential redundancy that may be had
     
     *      The following list will explain which tag numbers
     belong to what feature :
     
     Sender.tag  = 1 -> 0
     Sender.tag  = 2 -> 1
     Sender.tag  = 3 -> 2
     Sender.tag  = 4 -> 3
     Sender.tag  = 5 -> 4
     Sender.tag  = 6 -> 5
     Sender.tag  = 7 -> 6
     Sender.tag  = 8 -> 7
     Sender.tag  = 9 -> 8
     Sender.tag  = 10 -> 9
     
==================================================================*/
    @IBAction func buttons09(_ sender: UIButton)
    {
        //CASE 8 : If the first number of this user-created number is zero, nothing will displayed unless the user enters a different number
        if (self.numberDisplayLabel.text == "0")
            {
                self.numberDisplayLabel.text = ""
            }
    
        
        //CASE 9 : If the user has entered in their deisred and pushed an operator button
        if (nowPerformingOperations == true)
            {
                
                //CASE 10 : This check is used as a countermeasure in case a non-valid tag value gets entered.
                if (sender.tag > 0)
                    {
                        self.numberDisplayLabel.text?.append(String(sender.tag-1))
                        equationHolder.1 = Float(self.numberDisplayLabel.text!)!
                        
    
                        if (sender.tag == 15)
                            {
                                nowPerformingOperations = false //If the user hits the equal button, the user will be no longer be editing their second current number
                            }
                    }
            }
        else //Just enter in the first number regularly
            {
            
               if (sender.tag > 0)
                {
                    self.numberDisplayLabel.text?.append(String(sender.tag-1))
                    equationHolder.0 = Float(self.numberDisplayLabel.text!)!
                }
            }
    }
    
/*============================================================
    ADDS A DECIMAL NUMBER TO CURRENT NUMBER
     
     *       The purpose of this function is to allow the user
     to input a decimal point for their current number.
     
     *      Once added, the value is changed to true to signify
     that the action is done. No decimal will be appended
     until the next number is added.
     
============================================================*/
    @IBAction func decimalPointButton(_ sender: UIButton) {
        if (decimalAdded == false)
            {
                self.numberDisplayLabel.text?.append(".")
                decimalAdded = true
            }
    }
}

