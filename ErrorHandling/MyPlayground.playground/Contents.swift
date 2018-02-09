import Foundation

extension String: Error {}

func doSomethingThatThrows() throws {
    do {
        throw "Throwing"
    } catch {
        print("Catching")
        return
    }
    
    print("Return in catch doesn't work")
}

try doSomethingThatThrows()
