//: Playground - noun: a place where people can play

import UIKit

class Foo {
    typealias ThreeType = (() -> ())
    
    let one: String
    let two: String
    let three: ThreeType
    
    init(one: String, two: String = "Herp", three: ThreeType? = nil) {
        self.one = one
        self.two = two
        self.three = three ?? { print("Default three") }
    }
}

let a = Foo(one: "A", two: "Derp") {
    print("Hi hi")
}

let b = Foo(one: "B") {
    print("Bye bye")
}


let c = Foo(one: "C")

a.three()
b.three()
c.three()
