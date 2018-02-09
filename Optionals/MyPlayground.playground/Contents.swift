/*
 flatMap
 
 TL;DR: flatMap maps THEN culls nils.
 */

let arrayOfOptionals: [Int?] = [42, nil, 58]

let unwrapped = arrayOfOptionals.flatMap { _ in 10 }
unwrapped // [10, 10, 10]. Does NOT cull nils before mapping.

let optionalMask = [true, false, true]

let removedOptionals = optionalMask.flatMap { $0 ? 10 : nil }
removedOptionals // [10, 10]. Culls nils after mapping.

/*
 Catching nil unwrapping
 */

func unwrapNil() throws {
    let x: Int? = nil
    x!
}

// The following does not work. It's not possible to catch a fatal error.
/*
do {
    try unwrapNil()
} catch {
    print("Gotcha")
}
*/

/*
 Overriding removes Optional
 */

class ParentWithComputedOptionals {
    var computedOptional: Int? { return nil }
}

class ChildThatUnwraps: ParentWithComputedOptionals {
    override var computedOptional: Int { return 10 }
}

let b = ChildThatUnwraps()
print(b.computedOptional)
let a = b as ParentWithComputedOptionals
print(a.computedOptional ?? 0)
