//
//  ContactListViewController.swift
//  SampleContactList
//
//  Created by Francisco Depascuali on 12/01/2019.
//  Copyright © 2019 depa. All rights reserved.
//

import Foundation
import PureLayout
import ReactiveCocoa
import ReactiveSwift

final class ContactListViewController: UIViewController {

    fileprivate let _viewModel: ContactListViewModel

    fileprivate let _view = ContactListView()

    init(viewModel: ContactListViewModel) {
        _viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        view.addSubview(_view)
        _view.autoPinEdgesToSuperviewEdges()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        bindViewModel()

        _view.contactList.register(cellClass: ContactListCell.self, forCellReuseIdentifier: .contactListCell)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
}

fileprivate extension ContactListViewController {

    func setDelegates() {
        _view.contactList.delegate = self
        _view.contactList.dataSource = self
    }

    fileprivate func bindViewModel() {
        _viewModel
            .fetchContacts
            .producer
            .startWithValues { [unowned self] _ in
                self._view.contactList.reloadData()
        }

        _viewModel
            .searchedForText
            .producer
            .startWithValues { [unowned self] _ in
                self._view.contactList.reloadData()
        }


        _viewModel.searchText <~ _view
            .searchBar
            .reactive
            .continuousTextValues
        
    }

}

extension ContactListViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return _viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _viewModel.numberOfContacts(forSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .contactListCell) as! ContactListCell
        cell.bindViewModel(viewModel: _viewModel.contactCellViewModel(section: indexPath.section, row: indexPath.row))
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(_viewModel.title(forSection: section))"
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _viewModel
            .fetchContactDetails
            .apply(indexPath)
            .take(first: 1)
            .ignoringErrors()
            .startWithValues { contactDetailViewModel in
                self.navigationController?.pushViewController(ContactDetailViewController(viewModel: contactDetailViewModel), animated: true)
            }
    }

}
