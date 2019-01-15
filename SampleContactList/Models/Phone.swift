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

enum PhoneType: String {
    case home
    case office
    case cellular

    init?(rawValue: String){
        switch rawValue {
        case "Home":
            self = .home
        case "Cellphone":
            self = .cellular
        case "Office":
            self = .office
        default:
            return nil
        }
        
    }
}

