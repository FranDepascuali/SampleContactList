//
//  Phone.swift
//  SampleContactList
//
//  Created by Francisco Depascuali on 13/01/2019.
//  Copyright © 2019 depa. All rights reserved.
//

import Foundation

struct Phone {

    let phoneType: PhoneType

    let number: String

}

enum PhoneType {
    case home
    case office
    case cellular
}

