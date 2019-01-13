//
//  UITableView.swift
//  SampleContactList
//
//  Created by Francisco Depascuali on 13/01/2019.
//  Copyright © 2019 depa. All rights reserved.
//

import UIKit

extension UITableView {

    func dequeueReusableCell(withIdentifier identifier: CellIdentifier) -> UITableViewCell? {
        return dequeueReusableCell(withIdentifier: identifier.rawValue)
    }

    func register(cellClass: AnyClass, forCellReuseIdentifier identifier: CellIdentifier) {
        register(cellClass, forCellReuseIdentifier: identifier.rawValue)
    }

}
