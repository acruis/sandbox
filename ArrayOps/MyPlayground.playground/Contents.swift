//: Playground - noun: a place where people can play

import Foundation

func takeElements(from arr: [Int], upTo: Int) -> [Int] {
    return Array(arr[0..<min(upTo, arr.count)])
}

let a = [1,2,3,4,5]
print(takeElements(from: a, upTo: 2))
print(takeElements(from: a, upTo: 4))
print(takeElements(from: a, upTo: 5))
print(takeElements(from: a, upTo: 10))
