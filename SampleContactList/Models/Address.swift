//
//  Address.swift
//  SampleContactList
//
//  Created by Francisco Depascuali on 13/01/2019.
//  Copyright © 2019 depa. All rights reserved.
//

import Foundation

enum AddressType {
    case home
    case work
}

struct Address {

    let addressType: AddressType

    let address: String
}
