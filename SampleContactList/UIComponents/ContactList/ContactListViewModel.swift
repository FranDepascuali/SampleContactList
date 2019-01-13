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

    let searchedForText: SignalProducer<(), NoError>

    fileprivate(set) var fetchContactDetails: Action<IndexPath, ContactDetailViewModel, NoError>!

    fileprivate(set) var fetchContacts: SignalProducer<(), NoError>!

    fileprivate let _contacts: MutableProperty<[ContactListSectionViewModel]> = .init([])

    fileprivate let _filteredContacts: ReadOnlyProperty<[ContactListSectionViewModel]>

    let searchText: MutableProperty<String?> = .init(nil)

    init(contactsRepository: ContactsRepositoryType) {
        _filteredContacts = searchText
            .combineLatest(with: _contacts)
            .map { term, contacts in searchFor(text: term, inSections: contacts) }

        searchedForText = _filteredContacts.producer.map { _ in }

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
        return _filteredContacts.value[section].character
    }

    func numberOfContacts(forSection section: Int) -> Int {
        return _filteredContacts.value[section].contactListCellViewModels.count
    }

    func numberOfSections() -> Int {
        return _filteredContacts.value.count
    }

    func contactCellViewModel(section: Int, row: Int) -> ContactListCellViewModel {
        return _filteredContacts.value[section].contactListCellViewModels[row]
    }

}

func groupedByFirstLetter(contacts: [Contact]) -> Dictionary<Character, [Contact]>  {
    return Dictionary(grouping: contacts, by: { $0.firstName.first! })
}

func searchFor(text: String?, inSections sections: [ContactListSectionViewModel]) -> [ContactListSectionViewModel] {
    guard let text = text, text != "" else {
        return sections
    }

    return sections.compactMap { section in
        let matchedCells = section
            .contactListCellViewModels
            .filter { $0.fullName.range(of: text, options: [.caseInsensitive]) != nil  }

        if !matchedCells.isEmpty {
            return ContactListSectionViewModel(character: section.character, contactListCellViewModels: matchedCells)
        }

        return nil
    }
}
