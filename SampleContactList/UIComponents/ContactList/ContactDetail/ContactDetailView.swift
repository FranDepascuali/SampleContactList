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

    let detailsStackView: UIStackView

    init(phones: [Phone], addresses: [Address]) {
        detailsStackView = createDetailsStackView(phones: phones, addresses: addresses)
        super.init(frame: .zero)
        backgroundColor = .white
        addSubview(profileImageView)
        addSubview(fullName)
        addSubview(detailsStackView)
        setConstraints()
        fake()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

fileprivate func createDetailsStackView(phones: [Phone], addresses: [Address]) -> UIStackView {
    let createStackViewItem: (String, String) -> UIView = { fieldLabel, fieldValue in
        let label = UILabel()
        label.text = fieldLabel

        let value = UILabel()
        value.text = fieldValue

        let stackView = UIStackView(arrangedSubviews: [label, value])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 7

        return stackView
    }

    let phonesViews = phones.map { createStackViewItem("\($0.phoneType)", $0.number) }

    let adressesViews = addresses.map { createStackViewItem("\($0.addressType)", $0.address) }

    let containerStackView = UIStackView(arrangedSubviews: phonesViews + adressesViews)
    containerStackView.axis = .vertical
    containerStackView.spacing = 7

    return containerStackView
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

        detailsStackView.autoPinEdge(.top, to: .bottom, of: fullName, withOffset: 15)
        detailsStackView.autoPinEdge(toSuperviewEdge: .left, withInset: 15)
    }

}
