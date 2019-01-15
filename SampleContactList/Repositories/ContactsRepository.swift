//
//  ContactsRepository.swift
//  SampleContactList
//
//  Created by Francisco Depascuali on 12/01/2019.
//  Copyright © 2019 depa. All rights reserved.
//

import Foundation
import ReactiveSwift
import SwiftyJSON
import Result

protocol ContactsRepositoryType {

    // TODO: This can error
    func fetchContacts() -> SignalProducer<[Contact], NoError>

    // TODO: This can error
    func details(for: Contact) -> SignalProducer<DetailedContact, NoError>
}

enum ContactRepositoryError: Error {
    case unknown
}

class ContactsRepository: ContactsRepositoryType {

    let _requestService: RequestServiceType

    init(requestService: RequestServiceType) {
        _requestService = requestService
    }

    func fetchContacts() -> SignalProducer<[Contact], NoError> {
        return _requestService
            .request(URL: "https://private-d0cc1-iguanafixtest.apiary-mock.com/contacts")
            .map(parseContacts)
    }

    func details(for contact: Contact) -> SignalProducer<DetailedContact, NoError> {
        return _requestService
            .request(URL: "https://private-d0cc1-iguanafixtest.apiary-mock.com/contacts/\(contact.id)")
            .flatMap(.latest, { json -> SignalProducer<DetailedContact, ContactRepositoryError> in
                guard let contactDetails = ContactDetails(json: json) else {
                    return SignalProducer(error: .unknown)
                }

                return SignalProducer(value: DetailedContact(contact: contact, contactDetails: contactDetails))
            })
            .take(first: 1)
            .ignoringErrors()
    }
}

extension Address {

    init?(json: JSON) {
        if let rawHomeAddress = json["home"].string {
            self = .init(addressType: .home, address: rawHomeAddress)
        } else if let rawOfficeAddress = json["work"].string {
            self = .init(addressType: .work, address: rawOfficeAddress)
        } else {
            return nil
        }
    }
}

extension ContactDetails {

    init?(json: JSON) {
        guard
            let rawAddresses = json["addresses"].array else {
                return nil
        }

        self = ContactDetails(addresses: rawAddresses.compactMap(Address.init))
    }
}

extension Phone {

    init?(json: JSON) {
        guard
            let phoneType = json["type"].string.flatMap(PhoneType.init),
            let phoneNumber = json["number"].string else {
                return nil
        }

        self = Phone(phoneType: phoneType, number: phoneNumber)
    }
}

extension Contact {

    init?(json: JSON) {
        guard
            let rawId = json["user_id"].string,
            let id = Int(rawId),
            let lastName = json["last_name"].string,
            let firstName = json["first_name"].string,
            let thumbURL = json["thumb"].string,
            let profileURL = json["photo"].string,
            let birthDate = json["birth_date"].string,
            let phones = json["phones"].array
            else {
                return nil
        }

        self = Contact.init(id: id, firstName: firstName, lastName: lastName, birthDate: birthDate, phones: phones.compactMap(Phone.init), thumbURL: thumbURL, photo: profileURL)
    }
}

fileprivate func parseContacts(json: JSON) -> [Contact] {
    guard let rawContacts = json.array else {
        fatalError("Incorrect JSON array")
    }

    return rawContacts.compactMap { Contact(json: $0) }
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
        return SignalProducer(value:
            DetailedContact(contact: contact, contactDetails: ContactDetails(addresses: fakeAddresses)))
    }
}

let fakeHomeNumber = Phone(phoneType: .home, number: "54-11-4902-0876")
let fakeOfficeNumber = Phone(phoneType: .office, number: "54-11-4993-3322")
let fakeContact = Contact(
    id: 0,
    firstName: "Nazareno",
    lastName: "Peluffo",
    birthDate: "",
    phones: [fakeHomeNumber, fakeOfficeNumber],
    thumbURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1e/Creative-Tail-People-police-man.svg/128px-Creative-Tail-People-police-man.svg.png",
    photo: "https://static.pexels.com/photos/101584/pexels-photo-101584.jpeg")

let fakeContact2 = Contact(
    id: 0,
    firstName: "Francisco",
    lastName: "Peluffo",
    birthDate: "",
    phones: [fakeHomeNumber, fakeOfficeNumber],
    thumbURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1e/Creative-Tail-People-police-man.svg/128px-Creative-Tail-People-police-man.svg.png",
    photo: "https://static.pexels.com/photos/101584/pexels-photo-101584.jpeg")


let defaultFakeContacts = Array.init(repeating: fakeContact, count: 7) + Array.init(repeating: fakeContact2, count: 7)

let fakeAddresses = [Address.init(addressType: .home, address: "Av siempre viva 1234")]
