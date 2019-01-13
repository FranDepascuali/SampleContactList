//
//  ContactListView.swift
//  SampleContactList
//
//  Created by Francisco Depascuali on 12/01/2019.
//  Copyright © 2019 depa. All rights reserved.
//

import Foundation
import PureLayout

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
