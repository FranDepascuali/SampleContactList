//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import ReactiveSwift
import PureLayout

// Utils
import enum Result.NoError

//public typealias NoError = Result.NoError
//import struct Result.AnyError
//
////typealias NoError = Result.NoError
//typealias AnyError = Result.AnyError

// Models

struct Contact {
    fileprivate let id: Int

    let firstName: String

    let lastName: String

    let birthDate: Date

    let phones: [Phone]

    let thumbURL: String

    let photo: String
}

enum AddressType {
    case home
    case work
}

struct Address {

    let addressType: AddressType

    let address: String
}

struct Phone {

    let phoneType: PhoneType

    let number: Int

}

enum PhoneType {
    case home
    case office
    case cellular
}

// Repositories

protocol ContactsRepositoryType {

    // TODO: This can error
    func fetchContacts() -> SignalProducer<[Contact], NoError>

    func details(for: Contact) -> SignalProducer<String, NoError>
}

class FakeContactsRepository: ContactsRepositoryType {

    fileprivate var _fakeContacts: [Contact] = []

    func setFakedContacts(contacts: [Contact]) {
        _fakeContacts = contacts
    }

    func fetchContacts() -> SignalProducer<[Contact], NoError> {
        return SignalProducer(value: _fakeContacts)
    }

    func details(for: Contact) -> SignalProducer<String, NoError> {
        return SignalProducer(value: "Detail")
    }
}


// ContactList


class ContactListViewModel {

    fileprivate let _contactsRepository: ContactsRepositoryType

    init(contactsRepository: ContactsRepositoryType) {
        _contactsRepository = contactsRepository
    }

}

class ContactListView: UIView {

    var _didSetConstraints = false

    let searchBar = UISearchBar(frame: .zero)

    init() {
        super.init(frame: .zero)
        addSubview(searchBar)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        if !_didSetConstraints {
            _didSetConstraints = true
            setConstraints()
        }
        super.updateConstraints()
    }

}

fileprivate extension ContactListView {

    func setConstraints() {
        searchBar.autoPinEdgesToSuperviewSafeArea(with: .zero, excludingEdge: .bottom)
        searchBar.autoSetDimension(.height, toSize: 40)
    }

}

class ContactListViewController: UIViewController {

    fileprivate let _viewModel: ContactListViewModel

    fileprivate let _view: ContactListView

    init(viewModel: ContactListViewModel) {
        _viewModel = viewModel
        _view = ContactListView()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = UIView()
        view.addSubview(_view)
        _view.autoPinEdgesToSuperviewEdges()
    }
}


















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
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = ContactListViewController(
    viewModel: ContactListViewModel(contactsRepository: FakeContactsRepository()))

























