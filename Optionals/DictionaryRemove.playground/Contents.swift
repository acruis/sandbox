// TLDR:
// Assigning `nil` to a key is exactly equivalent as calling `remove` for that key,
// but initializing with a nil value is acceptable since we have nested optional types.

import Foundation

var dict: [String: Int] = [
    "one": 1,
    "two": 2,
    "three": 3,
]

dict["two"] = nil
print(dict.count) // 2

dict.removeValue(forKey: "three")
print(dict.count) // 1

var dictWithOptional: [String: Int?] = [
    "one": 1,
    "two": 2,
    "three": 3,
]

dictWithOptional["two"] = nil
print(dictWithOptional.count) // 2

var dictStartingWithOptional: [String: Int?] = [
    "one": 1,
    "two": nil,
    "three": 3,
]

print(dictStartingWithOptional.count) // 3
print(type(of: dictStartingWithOptional["two"])) // Optional<Optional<Int>>
dictStartingWithOptional["two"] = dictStartingWithOptional["two"]
print(dictStartingWithOptional.count) // 3
dictStartingWithOptional["two"] = nil
print(dictStartingWithOptional.count) // 2
dictStartingWithOptional["two"] = Optional<Optional<Int>>(nil)
print(dictStartingWithOptional.count) // 3
