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

    fileprivate let _view: UIView

    init(viewModel: ContactDetailViewModel, _view: UIView = ContactDetailView() ) {
        _viewModel = viewModel
        self._view = _view
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = UIView()
        view.addSubview(_view)
        _view.autoPinEdgesToSuperviewEdges()

        self.navigationController?.navigationBar.isHidden = false
    }
}
