//
//  ViewController.swift
//  iCalc
//
//  Created by Sagar Vemuri on 5/5/15.
//  Copyright (c) 2015 Sagar Vemuri. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var history: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    
    var brain = CalculatorBrain()
    
    var decimalPointSeen = false

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
//        if (digit == ".") {
//            if (!decimalPointSeen) {
//                decimalPointSeen = true
//            } else {
//                return
//            }
//        }
        
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
        
//        history.text = history.text! + digit
    }
    
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }

        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
        

        
//        history.text = history.text! + operation! + " "
    }
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        
        decimalPointSeen = false
        history.text = history.text! + " "
        
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
}


