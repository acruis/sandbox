//: Playground - noun: a place where people can play

import UIKit

let asciiStr = "ASCII"

print(asciiStr.count)           // 5
print(asciiStr.utf8.count)      // 5

let emojiStr = "😀👏💼🛀🏻🎰🌁🔓🕧🇺🇸"

print(emojiStr.count)           // 9
print(emojiStr.utf8.count)      // 44 (😀 is 4 bytes, the rest are 5 bytes)

// Splitting an emoji results in nil conversion.

let firstHalf3 = [UInt8](emojiStr.utf8)[..<3]
let secondHalf3 = [UInt8](emojiStr.utf8)[3...]
let whole = [UInt8](emojiStr.utf8)

print(String(data: Data(whole), encoding: .utf8))
print(String(data: Data(whole), encoding: .utf8) == emojiStr)

print(String(data: Data(firstHalf3), encoding: .utf8))
print(String(data: Data(secondHalf3), encoding: .utf8))

// If we don't split an emoji, the conversion works fine.

let firstHalf4 = [UInt8](emojiStr.utf8)[..<4]
let secondHalf4 = [UInt8](emojiStr.utf8)[4...]

print(String(data: Data(firstHalf4), encoding: .utf8))
print(String(data: Data(secondHalf4), encoding: .utf8))

print(String(data: Data(firstHalf4), encoding: .utf8)! + String(data: Data(secondHalf4), encoding: .utf8)! == emojiStr)
