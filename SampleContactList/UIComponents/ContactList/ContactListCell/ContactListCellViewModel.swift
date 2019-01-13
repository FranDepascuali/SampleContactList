//
//  ContactListCellViewModel.swift
//  SampleContactList
//
//  Created by Francisco Depascuali on 13/01/2019.
//  Copyright © 2019 depa. All rights reserved.
//

import Foundation

struct ContactListCellViewModel {

    fileprivate let _contact: Contact

    public init(contact: Contact) {
        _contact = contact
    }

    var fullName: String {
        return "\(_contact.firstName) \(_contact.lastName)"
    }
}
