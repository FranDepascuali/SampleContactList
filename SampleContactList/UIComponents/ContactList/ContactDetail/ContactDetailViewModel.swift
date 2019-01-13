//
//  ContactDetailViewModel.swift
//  SampleContactList
//
//  Created by Francisco Depascuali on 12/01/2019.
//  Copyright © 2019 depa. All rights reserved.
//

import UIKit

final class ContactDetailViewModel {

    fileprivate let _detailedContact: DetailedContact

    init(detailedContact: DetailedContact) {
        _detailedContact = detailedContact
    }

    var fullName: String {
        return "\(_detailedContact.contact.firstName) \(_detailedContact.contact.lastName)"
    }

    var phones: [Phone] {
        return _detailedContact.contact.phones
    }

    var addresses: [Address] {
        return _detailedContact.addresses
    }

}
