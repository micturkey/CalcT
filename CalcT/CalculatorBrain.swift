//
//  CalculatorBrain.swift
//  CalcT
//
//  Created by Ethan Zhai on 16/2/14.
//  Copyright © 2016年 Ethan Zhai. All rights reserved.
//

import Foundation
class CalculatorBrain{
    private enum Op: CustomStringConvertible{
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)

        var description: String{
            get{
                switch self {
                case .Operand(let operand):
                    return("\(operand)")
                case .UnaryOperation(let symbol, _):
                        return(symbol)
                case .BinaryOperation(let symbol, _):
                        return(symbol)
                }
            }
        }
    }
    
    private var opStack = [Op]()
    private var knownOps = [String:Op]()
    private var operand2 = 0.0
    
    init(){
        func learnOp(op: Op){
            knownOps[op.description] = op
        }
        knownOps["×"] = Op.BinaryOperation("×",*)
        knownOps["÷"] = Op.BinaryOperation("÷"){$0 / $1}
        knownOps["+"] = Op.BinaryOperation("+",+)
        knownOps["−"] = Op.BinaryOperation("−"){$0 - $1}
        knownOps["√"] = Op.UnaryOperation("√", sqrt)
        knownOps["sin"] = Op.UnaryOperation("sin", sin)
        knownOps["cos"] = Op.UnaryOperation("cos", cos)
        knownOps["tan"] = Op.UnaryOperation("tan", tan)
    }
    
    private func evaluate(var ops: [Op]) -> (Double?){

            switch ops.removeLast(){
            case .Operand(let operand):
                operand2 = operand
                return(evaluate(ops))
                
            case .UnaryOperation(_, let operation):
                switch ops[0]{
                    case .Operand(let operand):
                    return(operation(operand))
                default: break
                }

            case .BinaryOperation(_, let operation):
                
                print("a \(ops)")
                switch ops[0]{
                case .Operand(let operand1):
                return(operation(operand1, operand2))
                default: break
                    
            }
            }
        
        return(nil)
    }
    
    func evaluate() -> Double?{
        let result = evaluate(opStack)
        erase()
        print("b \(opStack)")
        return result

    }

    
    func erase(){
        opStack.removeAll()
    }
    
    func remove(){
        opStack.removeLast()
    }
    
    func pushOperand(operand: Double) -> Double?{
        if opStack.count == 1 {
            opStack.removeLast()
        }
        opStack.append(Op.Operand(operand))
        print("c \(opStack)")
        if opStack.count >= 2 {
            return performOperation()
        }
        return(operand)
    }
    
    func performOperation() -> Double?{
        return evaluate()
    }
    
    
    func pushOperation(symbol: String){
        if let operation = knownOps[symbol]{
            opStack.append(operation)
        }
        //return evaluate()
    }
}