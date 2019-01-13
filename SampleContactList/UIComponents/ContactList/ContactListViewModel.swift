//
//  ContactListViewModel.swift
//  SampleContactList
//
//  Created by Francisco Depascuali on 12/01/2019.
//  Copyright © 2019 depa. All rights reserved.
//

import Foundation
import ReactiveSwift

final class ContactListViewModel {

    fileprivate let _contactsRepository: ContactsRepositoryType

    fileprivate let _contacts: MutableProperty<[Contact]> = .init([])

    let contacts: ReadOnlyProperty<[Contact]>

    init(contactsRepository: ContactsRepositoryType) {
        _contactsRepository = contactsRepository
        contacts = ReadOnlyProperty(_contacts)
    }

}
