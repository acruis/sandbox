import Foundation

typealias tup = (Double, Bool)
var arrayOfArrayOfTuples = [[tup]](count: 3, repeatedValue: [tup]())

arrayOfArrayOfTuples[0].append((0.5, true))
arrayOfArrayOfTuples[1].append((0.6, false))
arrayOfArrayOfTuples[0][0] == (0.5, true) // true
arrayOfArrayOfTuples[1][0] == (0.6, false) // true