// When method is private

class Parent {
    func doThing() {
        self.doInnerThing()
    }
    
    private func doInnerThing() {
        print("Parent version")
    }
}

class Child: Parent {
    override func doThing() {
        super.doThing()
        self.doInnerThing()
    }
    
    private func doInnerThing() {
        print("Child version")
    }
}

let a = Child()
a.doThing() // "Parent version", then "Child version"

// When method is overridden

class A {
    func doThing() {
        self.doInnerThing()
    }
    
    func doInnerThing() {
        print("A version")
    }
}

class B: A {
    override func doThing() {
        super.doThing()
    }
    
    func doThingNoOverride() {
        super.doThing()
    }
    
    override func doInnerThing() {
        print("B version")
    }
}

let b = B()
b.doThing() // "B version"
b.doThingNoOverride() // "B version"
