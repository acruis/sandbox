//: Playground - noun: a place where people can play

import UIKit

protocol Person: class {
    func say()
}

class Guy: Person {
    func say() {
        print("Waddup")
    }
}

class SomePeople {
    var people: [Person] = []
    
    func addPerson(person: Person) {
        self.people.append(person)
    }
}

let people = SomePeople()
people.addPerson(person: Guy())

people.people.first?.say() // "Waddup"
