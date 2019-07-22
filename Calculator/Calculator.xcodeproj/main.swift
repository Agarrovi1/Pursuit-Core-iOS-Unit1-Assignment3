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
    print("For simple calculations type in 1, \nFor an operation guessing game type in 2 \nFor more complex calculations type in 3: ")
    let input = readLine()
    var value = Int()
    if let unwrap = input?.first {
        if let integerVers = Int("\(unwrap)") {
            value = integerVers
        }
    }
    return value
}

func askForNums() -> [Int] {
    print("please enter the numbers you wish to change separated by a comma ex 1,2,3: ")
    var arrayOfInts = [Int]()
    let array = readLine()?
        .split {$0 == ","}
        .map (String.init)
    if let unwrap = array {
        for a in unwrap {
            if let unwrapped = Int(a) {
                arrayOfInts.append(unwrapped)
            }
        }
    }
    return arrayOfInts
}

func askForCrocs() -> String {
    print("please enter < or > for how you want to filter your numbers: ")
    let input = readLine()
    var ans = String()
    if let justTheFirstChara = input?.first {
        ans = "\(justTheFirstChara)"
    }
    return ans
}

func askForOperands() -> String {
    print("please enter an operand for how you want to change your numbers: ")
    let input = readLine()
    var ans = String()
    if let justTheFirstChara = input?.first {
        ans = "\(justTheFirstChara)"
    }
    return ans
}

func onlySumAndProduce() -> String {
    print("please enter an either + or * to reduce numbers by: ")
    let input = readLine()
    var ans = String()
    if let justTheFirstChara = input?.first {
        ans = "\(justTheFirstChara)"
    }
    return ans
}

func secondNum() -> Int {
    print("Now enter the num you want to compare to (filter) or change by (map) or start at (reduce): ")
    let input = readLine()
    var ans = Int()
    if let unwrap = input?.first {
        if let intVers = Int("\(unwrap)") {
            ans = intVers
        }
    }
    return ans
}

func myFilter(inputArray: [Int], filter: (Int) -> Bool) -> [Int] {
    let newArray = inputArray.filter(filter)
    return newArray
}

func wholeFilter() -> [Int] {
    let nums = askForNums()
    let greaterOrLess = askForCrocs()
    let compareTo = secondNum()
    var ans = [Int]()
    switch greaterOrLess {
    case ">":
        ans = myFilter(inputArray: nums, filter: {(a:Int) -> Bool in
            return a > compareTo
        })
    case "<":
        ans = myFilter(inputArray: nums, filter: {(a:Int) -> Bool in
            return a < compareTo
        })
    default:
        print("Invalid input")
    }
    return ans
}

//let sample = [1,2,3,4,5]
//let test = myFilter(inputArray: sample, filter: {(a: Int) -> Bool in
//    return a > 3})
//print(test)

func myMap(inputArray: [Int], closure: (Int) -> Int) -> [Int] {
    var newArray = inputArray.map(closure)
    return newArray
}

func wholeMap() -> [Int] {
    let nums = askForNums()
    let operand = askForOperands()
    let byThisNum = secondNum()
    var ans = [Int]()
    switch operand {
    case "+":
        ans = myMap(inputArray: nums, closure: {(a:Int) -> Int in
            return a + byThisNum
        })
    case "*":
        ans = myMap(inputArray: nums, closure: {(a:Int) -> Int in
            return a * byThisNum
        })
    case "-":
        ans = myMap(inputArray: nums, closure: {(a:Int) -> Int in
            return a - byThisNum
        })
    case "/":
        if byThisNum != 0 {
            ans = myMap(inputArray: nums, closure: {(a:Int) -> Int in
                return a / byThisNum
            })
        } else {
            print("cannot divide by zero")
        }
    default:
        print("invalid input")
    }
    return ans
}

func myReduce(inputArray: [Int],startingPoint: Int, closure: (Int,Int) -> Int) -> Int {
    return inputArray.reduce(startingPoint, closure)
}

func wholeReduce() -> Int {
    let nums = askForNums()
    let operand = onlySumAndProduce()
    let start = secondNum()
    var ans = Int()
    switch operand {
    case "*":
        ans = myReduce(inputArray: nums, startingPoint: start, closure: {(a,b) -> Int in
            return a * b
        })
    case "+":
        ans = myReduce(inputArray: nums, startingPoint: start, closure: {(a,b) -> Int in
            return a + b
        })
    default:
        print("invalid input")
    }
    return ans
}

func mapsFilterReduceOhMy(string: String) {
    switch string {
    case "filter":
        let answer1 = wholeFilter()
        print(answer1)
    case "map":
        let answer2 = wholeMap()
        print(answer2)
    case "reduce":
        let answer3 = wholeReduce()
        print(answer3)
    default:
        print("invalid input")
    }
}

func complex() -> String {
    print("Type in the specific keywords for methods- filter, map, or reduce: ")
    let input = readLine()
    var value = String()
    if let unwrap = input {
        value = unwrap
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
    case 3:
        let keyword = complex()
        mapsFilterReduceOhMy(string: keyword)
    default:
        print("not a valid input")
    }
}
Calculator()
