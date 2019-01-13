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

    fileprivate let _contacts: MutableProperty<[ContactListSectionViewModel]> = .init([])

    fileprivate(set) var fetchContactDetails: Action<IndexPath, ContactDetailViewModel, NoError>!

    fileprivate(set) var fetchContacts: SignalProducer<(), NoError>!

    init(contactsRepository: ContactsRepositoryType) {
        fetchContactDetails = Action.init(execute: { [unowned self] indexPath in
            return contactsRepository
                .details(for: self.contactCellViewModel(section: indexPath.section, row: indexPath.row).contact)
                .map(ContactDetailViewModel.init)
        })

        fetchContacts = contactsRepository
            .fetchContacts()
            .on(value: { [unowned self] contacts in
                self._contacts.value = ContactListSectionViewModel.from(groupedContacts: groupedByFirstLetter(contacts: contacts))
            })
            .map { _ in () }
    }

    func title(forSection section: Int) -> Character {
        return _contacts.value[section].character
    }

    func numberOfContacts(forSection section: Int) -> Int {
        return _contacts.value[section].contactListCellViewModels.count
    }

    func numberOfSections() -> Int {
        return _contacts.value.count
    }

    func contactCellViewModel(section: Int, row: Int) -> ContactListCellViewModel {
        return _contacts.value[section].contactListCellViewModels[row]
    }

}

func groupedByFirstLetter(contacts: [Contact]) -> Dictionary<Character, [Contact]>  {
    return Dictionary(grouping: contacts, by: { $0.firstName.first! })
}
