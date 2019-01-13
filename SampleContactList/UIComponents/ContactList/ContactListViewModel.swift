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

    fileprivate let _contacts: MutableProperty<[ContactListCellViewModel]> = .init([])

    init(contactsRepository: ContactsRepositoryType) {
        _contactsRepository = contactsRepository
    }

    func numberOfContacts() -> Int {
        return _contacts.value.count
    }

    public subscript(index: Int) -> ContactListCellViewModel {
        return _contacts.value[index]
    }

    func fetchContacts() -> SignalProducer<(), NoError> {
        return _contactsRepository
            .fetchContacts()
            .on(value: { contacts in
                self._contacts.value = contacts.map(ContactListCellViewModel.init)
            })
            .map { _ in () }
    }

}
