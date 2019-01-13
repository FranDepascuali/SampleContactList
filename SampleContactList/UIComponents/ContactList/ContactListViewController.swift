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

        _view.contactList.register(cellClass: ContactListCell.self, forCellReuseIdentifier: .contactListCell)
    }
}

fileprivate extension ContactListViewController {

    func setDelegates() {
        _view.contactList.delegate = self
        _view.contactList.dataSource = self
    }

    fileprivate func bindViewModel() {
        _viewModel
            .fetchContacts()
            .producer
            .startWithValues { [unowned self] _ in
                self._view.contactList.reloadData()
        }
    }

}

extension ContactListViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _viewModel.numberOfContacts()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .contactListCell) as! ContactListCell
        cell.bindViewModel(viewModel: _viewModel[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}
