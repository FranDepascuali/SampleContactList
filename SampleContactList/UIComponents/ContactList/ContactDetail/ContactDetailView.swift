//
//  ContactDetailView.swift
//  SampleContactList
//
//  Created by Francisco Depascuali on 12/01/2019.
//  Copyright © 2019 depa. All rights reserved.
//

import UIKit

final class ContactDetailView: UIView {

    let profileImageView = UIImageView()

    let fullName = UILabel()

    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        addSubview(profileImageView)
        addSubview(fullName)
        setConstraints()
        fake()

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

fileprivate extension ContactDetailView {

    func fake() {
        profileImageView.image = UIImage(named: "sample")
        fullName.text = "Francisco Depascuali"
    }

    func setConstraints() {
        profileImageView.autoSetDimensions(to: CGSize(width: 200, height: 200))
        profileImageView.autoAlignAxis(toSuperviewAxis: .vertical)
        profileImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 20)

        fullName.autoAlignAxis(.vertical, toSameAxisOf: profileImageView)
        fullName.autoPinEdge(.top, to: .bottom, of: profileImageView, withOffset: 15)
    }

}
