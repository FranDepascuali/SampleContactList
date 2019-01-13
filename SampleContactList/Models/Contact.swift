//
//  Contact.swift
//  SampleContactList
//
//  Created by Francisco Depascuali on 12/01/2019.
//  Copyright © 2019 depa. All rights reserved.
//

import Foundation

import enum Result.NoError
import struct Result.AnyError

typealias NoError = Result.NoError
typealias AnyError = Result.AnyError

struct Contact {
    fileprivate let id: Int

    let firstName: String

    let lastName: String

    let birthDate: Date

    let phones: [Phone]

    let thumbURL: String

    let photo: String
}

enum AddressType {
    case home
    case work
}

struct Address {

    let addressType: AddressType

    let address: String
}

struct Phone {

    let phoneType: PhoneType

    let number: Int

}

enum PhoneType {
    case home
    case office
    case cellular
}

