class Container {
    private var arrayCat: [Int] = []
    private var arrayDog: [Int] = []
    
    func append(_ item: Int, toArrayCat: Bool) {
        // Bug: arrays are pass-by-value so doing this just appends to a copy of whichever
        // array is chosen, and not the internal array itself.
        var arrayToMutate = toArrayCat
            ? self.arrayCat
            : self.arrayDog
        arrayToMutate.append(item)
    }
    
    func printContents() {
        print(self.arrayCat)
        print(self.arrayDog)
    }
}

let container = Container()
container.append(10, toArrayCat: false) // It doesn't matter which array we insert into
container.printContents() // [] and []

class Container2D {
    private var arrays: [[Int]] = [[], []]
    
    func append(_ item: Int, toArrayIndex index: Int) {
        // But this will work.
        arrays[index].append(item)
    }
    
    func printContents() {
        print(self.arrays[0])
        print(self.arrays[1])
    }
}

let container2d = Container2D()
container2d.append(10, toArrayIndex: 0)
container2d.printContents() // [10] and []

// To make things more readable, we can do
extension Container2D {
    var arrayCat: [Int] {
        get {
            return arrays[0]
        } set {
            self.arrays[0] = newValue
        }
    }
    
    var arrayDog: [Int] {
        get {
            return arrays[1]
        } set {
            self.arrays[1] = newValue
        }
    }
}

container2d.arrayDog.append(9)
container2d.printContents() // [10] and [9]
