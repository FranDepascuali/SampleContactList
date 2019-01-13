//
//  ContactListViewModel.swift
//  SampleContactList
//
//  Created by Francisco Depascuali on 12/01/2019.
//  Copyright © 2019 depa. All rights reserved.
//

import Foundation

class ContactListViewModel {

    fileprivate let _contactsRepository: ContactsRepositoryType

    init(contactsRepository: ContactsRepositoryType) {
        _contactsRepository = contactsRepository
    }

}
