//
//  ContactDetailViewController.swift
//  SampleContactList
//
//  Created by Francisco Depascuali on 12/01/2019.
//  Copyright © 2019 depa. All rights reserved.
//

import UIKit

final class ContactDetailViewController: UIViewController {

    fileprivate let _viewModel: ContactDetailViewModel

    fileprivate let _view: ContactDetailView

    init(viewModel: ContactDetailViewModel) {
        _viewModel = viewModel
        _view = ContactDetailView(phones: viewModel.phones, addresses: viewModel.addresses)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = UIView()
        view.addSubview(_view)
        _view.autoPinEdgesToSuperviewSafeArea()

        navigationController?.navigationBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
}

fileprivate extension ContactDetailViewController {

    func bindViewModel() {
        _view.fullName.text = _viewModel.fullName
    }
    

}
