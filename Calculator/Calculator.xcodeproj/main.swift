//
//  main.swift
//  Calculator
//
//  Created by Angela Garrovillas on 7/20/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import Foundation

var operations: ([String: (Double, Double) -> Double]) = ["+": { $0 + $1 },"-": { $0 - $1 },"*": { $0 * $1 },"/": { $0 / $1 }]

func userInput() -> [String] {
    print("enter your operation here ex. 1 + 9: ")
    //should read input as [num,operation,num]
    let array = readLine()?
        .split {$0 == " "}
        .map (String.init)
    var retValue = [String]()
    if let stringArray = array {
        retValue = stringArray
    }
    return retValue
}

func userInputForGame() -> [String] {
    print("enter here ex. 1 ? 9: ")
    //should read input as [num,operation,num]
    let array = readLine()?
        .split {$0 == " "}
        .map (String.init)
    var retValue = [String]()
    if let stringArray = array {
        retValue = stringArray
    }
    return retValue
}

//need to guard for invalid inputs, probably put in overall function
func changeArray(arr: [String]) -> [String:(Double,Double)]{
    var dict: [String:(Double,Double)] = [:]
    var operand = String()
    var blankDouble = Double()
    var blank2 = Double()
    for a in 0...2 {
        switch arr[a] {
        case arr[0]:
            if let unwrap = Double(arr[0]) {
                blankDouble = unwrap
            }
        case arr[1]:
            operand = arr[1]
        case arr[2]:
            if let unwrap = Double(arr[2]) {
                blank2 = unwrap
            }
        default:
            continue
        }
    }
    dict[operand] = (blankDouble,blank2)
    return dict
}

func changeArrayForGame(arr: [String]) -> [String:(Double,Double)]{
    var dict: [String:(Double,Double)] = [:]
    var operand: String? = String()
    var blankDouble = Double()
    var blank2 = Double()
    let arrOfOperations = ["+","*","-","/"]
    for a in 0...2 {
        switch arr[a] {
        case arr[0]:
            if let unwrap = Double(arr[0]) {
                blankDouble = unwrap
            }
        case arr[1]:
            operand = arr[1]
        case arr[2]:
            if let unwrap = Double(arr[2]) {
                blank2 = unwrap
            }
        default:
            continue
        }
    }
    operand = arrOfOperations.randomElement()
    if let unwrap = operand {
        dict[unwrap] = (blankDouble,blank2)
    }
    return dict
}

func changeInputToCalculations(problem: [String:(Double,Double)]) -> Double {
    var blank = Double()
    for (a,b) in problem {
        switch a {
        case "+":
            blank = b.0 + b.1
        case "-":
            blank = b.0 - b.1
        case "*":
            blank = b.0 * b.1
        case "/":
            if b.1 != 0 {
                blank = b.0 / b.1
            } else {
                print("cannot divide by zero")
            }
        default:
            print("invalid operand \(a)")
        }
    }
    return blank
}

func simpleCalculations() {
    let input = userInput()
    
    guard input.count == 3 else {
        print("invalid input try again like so:1 + 8")
        return simpleCalculations()
    }
    
    let correctFormat = changeArray(arr: input)
    //print(correctFormat)
    
    let answer = changeInputToCalculations(problem: correctFormat)
    print(answer)
}

func guessTheOperator() -> String {
    print("Guess the operator: ")
    let input = readLine()
    var value = String()
    if let ans = input?.first {
        value = "\(ans)"
    }
    return value
}

func findTheOperatorUsed(dict: [String:(Double,Double)]) -> String {
    var key = String()
    for (a,_) in dict {
        key = a
    }
    return key
}

func randomGame() {
    print("Let's play a game, where you pick two numbers and have a ? in place of the operator ex. 4 ? 9 \n From the result guess which operater was used.")
    let input = userInputForGame()
    let changedInput = changeArrayForGame(arr: input)
    let answer = changeInputToCalculations(problem: changedInput)
    let theOperationUsed = findTheOperatorUsed(dict: changedInput)
    print(answer)
    let secondInput = guessTheOperator()
    if secondInput == theOperationUsed {
        print("Correct!")
    } else {
        print("Incorrect!")
    }
}

func SimpleOrGame() -> Int {
    print("For simple calculations type in 1, \nFor an operation guessing game type in 2: ")
    let input = readLine()
    var value = Int()
    if let unwrap = input?.first {
        if let integerVers = Int("\(unwrap)") {
            value = integerVers
        }
    }
    return value
}

func Calculator() {
    let input = SimpleOrGame()
    switch input {
    case 1:
        simpleCalculations()
    case 2:
        randomGame()
    default:
        print("not a valid input")
    }
}
Calculator()
