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

    let phonesStackView: UIStackView

    let addressesStackView: UIStackView

    let phonesLabel = createPhoneLabel()

    let addressesLabel = createAddressLabel()

    init(phones: [Phone], addresses: [Address]) {
        phonesStackView = createPhonesStackView(phones: phones)
        addressesStackView = createAddressesStackView(addresses: addresses)
        super.init(frame: .zero)
        backgroundColor = .white
        addSubview(profileImageView)
        addSubview(fullName)
        addSubview(phonesStackView)
        addSubview(phonesLabel)
        addSubview(addressesLabel)
        addSubview(addressesStackView)
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

        phonesLabel.autoPinEdge(.top, to: .bottom, of: fullName, withOffset: 15)
        phonesLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 15)

        phonesStackView.autoPinEdge(.top, to: .bottom, of: phonesLabel, withOffset: 7)
        phonesStackView.autoPinEdge(toSuperviewEdge: .left, withInset: 15)

        addressesLabel.autoPinEdge(.top, to: .bottom, of: phonesStackView, withOffset: 15)
        addressesLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 15)

        addressesStackView.autoPinEdge(.top, to: .bottom, of: addressesLabel, withOffset: 7)
        addressesStackView.autoPinEdge(toSuperviewEdge: .left, withInset: 15)

    }

}

fileprivate func createPhonesStackView(phones: [Phone]) -> UIStackView {
    let phonesViews = phones.map { createStackViewItem("\($0.phoneType)", $0.number) }
    let containerStackView = UIStackView(arrangedSubviews: phonesViews)
    containerStackView.axis = .vertical
    containerStackView.spacing = 7

    return containerStackView
}

fileprivate func createAddressesStackView(addresses: [Address]) -> UIStackView {
    let adressesViews = addresses.map { createStackViewItem("\($0.addressType)", $0.address) }
    let containerStackView = UIStackView(arrangedSubviews: adressesViews)
    containerStackView.axis = .vertical
    containerStackView.spacing = 7

    return containerStackView
}

fileprivate func createDetailsStackView(phones: [Phone], addresses: [Address]) -> UIStackView {
    let phonesViews = phones.map { createStackViewItem("\($0.phoneType)", $0.number) }

    let adressesViews = addresses.map { createStackViewItem("\($0.addressType)", $0.address) }

    let containerStackView = UIStackView(arrangedSubviews: phonesViews + adressesViews)
    containerStackView.axis = .vertical
    containerStackView.spacing = 7

    return containerStackView
}

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

fileprivate func createPhoneLabel() -> UILabel {
    let phoneLabel = UILabel()
    phoneLabel.text = "Phones"
    return phoneLabel
}

fileprivate func createAddressLabel() -> UILabel {
    let addressesLabel = UILabel()
    addressesLabel.text = "Addresses"
    return addressesLabel
}
