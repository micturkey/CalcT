//
//  ViewController.swift
//  CalcT
//
//  Created by Ethan Zhai on 16/2/13.
//  Copyright © 2016年 Ethan Zhai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let π = M_PI

    @IBOutlet weak var cbutton: UIButton!
    @IBOutlet weak var display: UILabel!
    
    var cButtonIsUsed = false
    var userIsInTheMiddleOfTypingANumber = false
    var userHasTypedPoint = false
//    var userHasChoosenSymbol = false
    
    var brain = CalculatorBrain()
    

    @IBAction func appendPoint(sender: UIButton) {
        let digit = "."
        if !userHasTypedPoint{
            if userIsInTheMiddleOfTypingANumber{
                display.text = display.text! + digit
            }else{
                display.text = "0" + digit
                userIsInTheMiddleOfTypingANumber = true
            }
        userHasTypedPoint = true
        }
    }
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        cButtonIsUsed = true
        cbutton.setTitle("C",forState: UIControlState.Normal)
        if userIsInTheMiddleOfTypingANumber{
        display.text = display.text! + digit
        //print("digit=\(digit)")
        }else{
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func inverse() {
        displayValue = 0 - displayValue
    }
    
    
    @IBAction func cancel() {
//        userHasChoosenSymbol = false
        if cButtonIsUsed == true {
            displayValue = 0
            cButtonIsUsed = false
            cbutton.setTitle("AC",forState: UIControlState.Normal)
        }else{
            brain.erase()
        }
    }
    @IBAction func percent() {
        displayValue /= 100
    }
    
    @IBAction func operateU(sender: UIButton) {
        enter()
        enter()
        if let operation = sender.currentTitle{
            brain.pushOperation(operation)
        }
        
        enter()
    }
    @IBAction func operate(sender: UIButton) {
        
        enter()
        enter()
        if let operation = sender.currentTitle{
            brain.pushOperation(operation)
        }
        //enter()
    }
    
    
    @IBAction func equal() {
        enter()
    }
    
    func enter() {
        userIsInTheMiddleOfTypingANumber = false
        userHasTypedPoint = false
        if let result = brain.pushOperand(displayValue){
            displayValue = result
        }else{
            displayValue = 0
        }
    }
    var displayValue: Double{
        get{
            return (display.text! as NSString).doubleValue //NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text="\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }

}

