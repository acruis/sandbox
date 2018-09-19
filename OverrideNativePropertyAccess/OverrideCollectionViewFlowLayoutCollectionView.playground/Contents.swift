import UIKit

class CustomFlowLayout: UICollectionViewFlowLayout {
    override var collectionView: UICollectionView? {
        get {
            print("Injected")
            return super.collectionView
        }
    }
}

let customFlowLayout = CustomFlowLayout()
let collectionView = UICollectionView(frame: .zero,
                                      collectionViewLayout: CustomFlowLayout())
customFlowLayout.collectionView // Prints "Injected"
