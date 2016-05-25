//
//  Calculator.swift
//  Calculator
//
//  Created by Clément DEUST on 24/05/16.
//  Copyright © 2016 cdeust. All rights reserved.
//

import UIKit
import AVFoundation
import Darwin

//MARK: ViewController iVars & Outlets
class Calculator: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var soundSwitch: UISwitch!
    @IBOutlet weak var operationResult: UILabel!
    
    var currentOperation: Operation = Operation.Empty
    var runningNumber: String = ""
    var leftNumber: String = ""
    var rightNumber: String = ""
    var result: String = ""
    
    var soundsOperation: SoundsOperation!
}

//MARK: ViewController life cycle
extension Calculator {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        soundsOperation = SoundsOperation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}

//MARK: ViewController refresh
extension Calculator {
    
    func updateOperationResult(currentNum: String) {
        operationResult.text = currentNum
    }
    
}

//MARK: IBOutlet actions
extension Calculator {
    
    @IBAction func numberPressed(sender: UIButton!) -> Void {
        soundsOperation.playSound()
        
        runningNumber += "\(sender.tag)"
        
        updateOperationResult(runningNumber)
    }
    
    @IBAction func comaPressed(sender: UIButton!) -> Void {
        soundsOperation.playSound()
        
        if runningNumber == "" {
            runningNumber += "0."
        } else {
            runningNumber += "."
        }
        
        updateOperationResult(runningNumber)
    }
    
    @IBAction func clearPressed(sender: UIButton!) -> Void {
        runningNumber = ""
        leftNumber = ""
        rightNumber = ""
        result = ""
        currentOperation = Operation.Empty
        
        updateOperationResult("0")
    }
    
    @IBAction func onPowerTwoPressed(sender: UIButton!) -> Void {
        runningNumber = "\(pow(Double(runningNumber)!, 2))"
        
        updateOperationResult(runningNumber)
    }
    
    @IBAction func onPowerTenPressed(sender: UIButton!) -> Void {
        runningNumber = "\(pow(Double(runningNumber)!, 10))"
        
        updateOperationResult(runningNumber)
    }
    
    @IBAction func onSquareRootPressed(sender: UIButton!) -> Void {
        runningNumber = "\(sqrt(Double(runningNumber)!))"
        
        updateOperationResult(runningNumber)
    }
    
    @IBAction func onMultiplyPressed(sender: UIButton!) -> Void {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onDividePressed(sender: UIButton!) -> Void {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onAddPressed(sender: UIButton!) -> Void {
        processOperation(Operation.Add)
    }
    
    @IBAction func onSubtractPressed(sender: UIButton!) -> Void {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onEqualPressed(sender: UIButton!) -> Void {
        processOperation(currentOperation)
    }
    
}

//MARK: Sounds activation/deactivation
extension Calculator {
    
    @IBAction func soundsSwitchValueChanged(sender: UISwitch) {
        
        if sender.on == true {
            soundsOperation.activeSounds = true;
        } else {
            soundsOperation.activeSounds = false;
        }
        
    }
    
}

//MARK: Maths
extension Calculator {
    
    func processOperation(op: Operation) -> Void {
        
        soundsOperation.playSound()
        
        if self.currentOperation != Operation.Empty {
            
            if runningNumber != "" {
                
                rightNumber = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftNumber)! * Double(rightNumber)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftNumber)! / Double(rightNumber)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftNumber)! + Double(rightNumber)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftNumber)! - Double(rightNumber)!)"
                }
                
                leftNumber = result
                updateOperationResult(result)
                
            }
            
            currentOperation = op
        } else {
            leftNumber = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
}