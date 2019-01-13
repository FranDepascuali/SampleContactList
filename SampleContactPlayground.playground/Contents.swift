//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import ReactiveSwift
import PureLayout
@testable import ContactListFramework


class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black
        
        view.addSubview(label)
        self.view = view
    }
}

PlaygroundPage.current.liveView = ContactListViewController(
    viewModel: ContactListViewModel(contactsRepository: FakeContactsRepository()))

























