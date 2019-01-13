//
//  ContactsRepository.swift
//  SampleContactList
//
//  Created by Francisco Depascuali on 12/01/2019.
//  Copyright © 2019 depa. All rights reserved.
//

import Foundation
import ReactiveSwift

protocol ContactsRepositoryType {

    // TODO: This can error
    func fetchContacts() -> SignalProducer<[Contact], NoError>

    func details(for: Contact) -> SignalProducer<String, NoError>
}

class FakeContactsRepository: ContactsRepositoryType {

    public var fakeContacts: [Contact] = []

    func fetchContacts() -> SignalProducer<[Contact], NoError> {
        return SignalProducer(value: fakeContacts)
    }

    func details(for: Contact) -> SignalProducer<String, NoError> {
        return SignalProducer(value: "Detail")
    }
}
