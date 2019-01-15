//
//  ContactListCellViewModel.swift
//  SampleContactList
//
//  Created by Francisco Depascuali on 13/01/2019.
//  Copyright © 2019 depa. All rights reserved.
//

import Foundation

struct ContactListCellViewModel {

    let contact: Contact

    public init(contact: Contact) {
        self.contact = contact
    }

    var fullName: String {
        return "\(contact.firstName) \(contact.lastName)"
    }

    var thumbURL: String {
        return contact.thumbURL
    }
}
