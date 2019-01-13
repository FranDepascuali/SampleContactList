//
//  ContactListSectionViewModel.swift
//  SampleContactList
//
//  Created by Francisco Depascuali on 13/01/2019.
//  Copyright © 2019 depa. All rights reserved.
//

import Foundation

struct ContactListSectionViewModel: Comparable {

    let contactListCellViewModels: [ContactListCellViewModel]

    let character: Character

    init(character: Character, contactListCellViewModels: [ContactListCellViewModel]) {
        self.character = character
        self.contactListCellViewModels = contactListCellViewModels
    }

    static func from(groupedContacts: Dictionary<Character, [Contact]>) -> [ContactListSectionViewModel] {
        return groupedContacts.map { character, contacts in
            ContactListSectionViewModel(
                character: character,
                contactListCellViewModels: contacts.map(ContactListCellViewModel.init)
            )}

            .sorted(by: <)
    }

    static func < (lhs: ContactListSectionViewModel, rhs: ContactListSectionViewModel) -> Bool {
        return lhs.character < rhs.character
    }

    // NOTE: We only need this to satisfy comparable
    static func == (lhs: ContactListSectionViewModel, rhs: ContactListSectionViewModel) -> Bool {
        return lhs.character == rhs.character
    }
}
