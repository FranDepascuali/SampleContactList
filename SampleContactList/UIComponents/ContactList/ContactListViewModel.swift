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

    fileprivate let _contacts: MutableProperty<[ContactListCellViewModel]> = .init([])

    fileprivate(set) var fetchContactDetails: Action<Int, ContactDetailViewModel, NoError>!

    fileprivate(set) var fetchContacts: SignalProducer<(), NoError>!

    init(contactsRepository: ContactsRepositoryType) {
        fetchContactDetails = Action.init(execute: { [unowned self] index in
            let contact = self[index].contact
            return contactsRepository.details(for: contact).map(ContactDetailViewModel.init)
        })

        fetchContacts = contactsRepository
            .fetchContacts()
            .on(value: { [unowned self] contacts in
                self._contacts.value = contacts.map(ContactListCellViewModel.init)
            })
            .map { _ in () }
    }

    func numberOfContacts() -> Int {
        return _contacts.value.count
    }

    public subscript(index: Int) -> ContactListCellViewModel {
        return _contacts.value[index]
    }

    func details(for: Contact) -> SignalProducer<String, NoError> {
        return SignalProducer(value: "")
    }

}
