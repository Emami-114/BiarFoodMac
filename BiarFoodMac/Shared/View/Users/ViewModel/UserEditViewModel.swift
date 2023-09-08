//
//  UserEditViewModel.swift
//  BiarFoodMac
//
//  Created by Ecc on 08/09/2023.
//

import SwiftUI

class UserEditViewModel : ObservableObject {
    let userRepository = UsersRepository.shared
    let salutationList = ["Herr","Frau","Keine"]
    let rolleList = ["Kunde","Mitarbeiter","Admin","Fahrer/in"]
    
    
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var email = ""
    @Published var salutation = ""
    @Published var emailConfirm = false
    @Published var country = ""
    @Published var phoneNumber = ""
    @Published var rolle = ""
    @Published var street = ""
    @Published var houseNumber = ""
    @Published var zipCode = ""
    
    init(user: User){
        self._firstName = Published(initialValue: user.firstName)
        self._lastName = Published(initialValue: user.lastName)
        self._email = Published(initialValue: user.email)
        self._salutation = Published(initialValue: user.salutation)
        self._emailConfirm = Published(initialValue: user.emailConfirm)
        self._country = Published(initialValue: user.country)
        self._phoneNumber = Published(initialValue: user.phoneNumber)
        self._rolle = Published(initialValue: user.rolle)
        self._street = Published(initialValue: user.street)
        self._houseNumber = Published(initialValue: user.houseNumBer)
        self._zipCode = Published(initialValue: user.zipCode)
    }
    
    
    
    func updateUser(with id: String){
        userRepository.updateUser(with: id, salutation: salutation, firstName: firstName, lastName: lastName, street: street, houseNumBer: houseNumber, zipCode: zipCode, email: email, rolle: rolle, emailConfirm: emailConfirm, phoneNumber: phoneNumber, country: country)
    }
    
}
