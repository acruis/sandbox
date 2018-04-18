//: Playground - noun: a place where people can play

import Foundation

var emptyOptStr: String? = ""

let bool: Bool = emptyOptStr == nil || emptyOptStr?.isEmpty
print(emptyOptStr?.count == 0)
print(type(of: emptyOptStr?.count))
