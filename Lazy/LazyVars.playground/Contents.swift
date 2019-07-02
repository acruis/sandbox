import Foundation

class Parent {
    lazy var xyz: Int? = getXYZ()

    func getXYZ() -> Int? {
        print("Did evaluate lazy value")
        return 10
    }
}

let lazyParent = Parent()
print(String(describing: lazyParent.xyz))

let eagerParent = Parent()
eagerParent.xyz = nil
print(String(describing: eagerParent.xyz))

let modelParent = Parent()
eagerParent.xyz = 20
print(String(describing: modelParent.xyz))

let evilParent = Parent()
evilParent.xyz = 30
evilParent.xyz = nil
print(String(describing: evilParent.xyz))
