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

    // TODO: This can error
    func details(for: Contact) -> SignalProducer<DetailedContact, NoError>
}

class FakeContactsRepository: ContactsRepositoryType {

    public var fakeContacts: [Contact] = []

    init(fakeContacts: [Contact] = defaultFakeContacts) {
        self.fakeContacts = fakeContacts
    }

    func fetchContacts() -> SignalProducer<[Contact], NoError> {
        return SignalProducer(value: fakeContacts)
    }

    func details(for contact: Contact) -> SignalProducer<DetailedContact, NoError> {
        return SignalProducer(value: DetailedContact(contact: contact, addresses: fakeAddresses))
    }
}

let fakeHomeNumber = Phone(phoneType: .home, number: "54-11-4902-0876")
let fakeOfficeNumber = Phone(phoneType: .office, number: "54-11-4993-3322")
let fakeContact = Contact(
    id: 0,
    firstName: "Nazareno",
    lastName: "Peluffo",
    birthDate: Date(),
    phones: [fakeHomeNumber, fakeOfficeNumber],
    thumbURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1e/Creative-Tail-People-police-man.svg/128px-Creative-Tail-People-police-man.svg.png",
    photo: "https://static.pexels.com/photos/101584/pexels-photo-101584.jpeg")


let defaultFakeContacts = Array.init(repeating: fakeContact, count: 7)

let fakeAddresses = [Address.init(addressType: .home, address: "Av siempre viva 1234")]
