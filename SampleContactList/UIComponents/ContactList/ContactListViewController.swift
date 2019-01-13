//
//  ContactListViewController.swift
//  SampleContactList
//
//  Created by Francisco Depascuali on 12/01/2019.
//  Copyright © 2019 depa. All rights reserved.
//

import Foundation
import PureLayout

final class ContactListViewController: UIViewController {

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

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        bindViewModel()
    }
}

fileprivate extension ContactListViewController {

    func setDelegates() {
        _view.contactList.delegate = self
        _view.contactList.dataSource = self
    }

    fileprivate func bindViewModel() {
        
    }

}

extension ContactListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _viewModel.contacts.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }


}
