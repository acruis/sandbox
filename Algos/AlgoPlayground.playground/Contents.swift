import Foundation

func binarySearch<T: Comparable>(arr: [T], target: T) -> Int {
    var start: Int = 0
    var end: Int = arr.count - 1
    
    while start <= end {
        let curr_index = (start + end) / 2
        if arr[curr_index] < target {
            start = curr_index + 1
        } else if arr[curr_index] > target {
            end = curr_index - 1
        } else {
            return curr_index
        }
    }
    
    return -1
}

let searchedArr = [2,3,4]
binarySearch(arr: searchedArr, target: 2)

func quickSort<T: Comparable>(arr: inout [T], left: Int, right: Int) {
    guard left < right else {
        return
    }
    
    var i = left + 1
    var j = right
    
    while true {
        while i < right && arr[i] < arr[left] {
            i = i + 1
        }
        
        while j > left && arr[j] >= arr[left] {
            j = j - 1
        }
        
        guard i < j else {
            break
        }
        
        let temp = arr[i]
        arr[i] = arr[j]
        arr[j] = temp
    }
    
    let temp = arr[left]
    arr[left] = arr[j]
    arr[j] = temp
    
    quickSort(arr: &arr, left: left, right: j - 1)
    quickSort(arr: &arr, left: j + 1, right: right)
}

var sortedArr = [-2, -1, 3, 4, -3, 5, -7]
quickSort(arr: &sortedArr, left: 0, right: sortedArr.count - 1)
print(sortedArr)
