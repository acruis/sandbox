import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let view1 = UIView(frame: CGRect(x: 150, y: 200, width: 200, height: 20))
        view1.backgroundColor = .red

        let view2 = UIView(frame: CGRect(x: 150, y: 300, width: 200, height: 20))
        view2.backgroundColor = .blue

        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black
        
        view.addSubview(view1)
        view.addSubview(view2)

        view1.addSubview(label)
        view2.bringSubview(toFront: label) // No effect, label stays in view1.
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
