//
//  Users.swift
//  BiarFoodMac
//
//  Created by Ecc on 08/09/2023.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
struct User: Codable,Identifiable{
    var id: String
    var salutation: String
    var firstName: String
    var lastName: String
    var street: String
    var houseNumBer : String
    var zipCode : String
    var email: String
    var rolle: String
    var emailConfirm: Bool
    var phoneNumber: String
    var country: String
    var registerAt: Timestamp = Timestamp()
}
