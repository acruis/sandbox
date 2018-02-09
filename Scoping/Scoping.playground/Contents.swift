import UIKit

var x = 10
let closureTakingX = { () -> Int in x }
closureTakingX() // 10

x = 40
closureTakingX() // 40
