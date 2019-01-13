//
//  Contact.swift
//  SampleContactList
//
//  Created by Francisco Depascuali on 12/01/2019.
//  Copyright © 2019 depa. All rights reserved.
//

import Foundation

struct Contact {

    let id: Int

    let firstName: String

    let lastName: String

    let birthDate: Date

    let phones: [Phone]

    let thumbURL: String

    let photo: String
}

struct DetailedContact {

    let contact: Contact

    let addresses: [Address]

}
