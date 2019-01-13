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
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

fileprivate extension ContactListCell {

    func setConstraints() {
        thumb.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .right)
        thumb.autoMatch(.width, to: .height, of: thumb)

        fullName.autoAlignAxis(.horizontal, toSameAxisOf: thumb)
    }

}
