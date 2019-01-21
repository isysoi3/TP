//
//  main.swift
//  lab6
//
//  Created by Ilya Sysoi on 27.03.2018.
//  Copyright © 2018 Ilya Sysoi. All rights reserved.
//

import Foundation


func countSubstringsFromString(_ str: String) {
    let arr: [String] = str.components(separatedBy: " ")
    var dict: [String: Int] = [:]
    arr.forEach {
        dict[$0, default: 0] += 1
    }
    
    let sortedDict = dict.sorted{ (first, second) in
        if first.value == second.value {
            return first.key < second.key
        }
        return first.value > second.value
    }
    
    for (index,element) in sortedDict.enumerated() {
        if index == 5 {
            break
        }
        print("\(element.key):", element.value)
    }
    print()
}

func tests() {
    countSubstringsFromString("foo bar foo bar")
    countSubstringsFromString("test record created")
    countSubstringsFromString("1 2 3 4 5 1 2 3 4 5 6 7 8 9")
    countSubstringsFromString("Hello World")
}

print("Enter the string")
var str = readLine()
countSubstringsFromString(str!)
tests()




