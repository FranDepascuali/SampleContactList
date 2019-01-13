//
//  ContactListCell.swift
//  SampleContactList
//
//  Created by Francisco Depascuali on 13/01/2019.
//  Copyright © 2019 depa. All rights reserved.
//

import UIKit

class ContactListCell: UITableViewCell {

    fileprivate var _didSetConstraints = false

    let thumb = UIImageView()

    let fullName = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(thumb)
        contentView.addSubview(fullName)

        setConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bindViewModel(viewModel: ContactListCellViewModel) {
        fullName.text = viewModel.fullName
        thumb.image = UIImage(named: "sample")
    }

}

fileprivate extension ContactListCell {

    func setConstraints() {
        thumb.autoMatch(.width, to: .height, of: thumb)
        thumb.autoMatch(.height, to: .height, of: contentView, withMultiplier: 0.7)
        thumb.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
        thumb.autoAlignAxis(toSuperviewAxis: .horizontal)

        fullName.autoAlignAxis(.horizontal, toSameAxisOf: thumb)
        fullName.autoPinEdge(.left, to: .right, of: thumb, withOffset: 10)
    }

}
