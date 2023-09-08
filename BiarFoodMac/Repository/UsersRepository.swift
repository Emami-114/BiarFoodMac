//
//  UsersRepository.swift
//  BiarFoodMac
//
//  Created by Ecc on 08/09/2023.
//

import Foundation
import Combine
class UsersRepository{
    static let shared = UsersRepository()
    
    var users = CurrentValueSubject<[User]?,Never>(nil)
    
    
}


extension UsersRepository{
    func fetchUsers(){
        FirebaseManager.shared.database.collection("users").addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Fehler beim laden Users: \(error.localizedDescription)")
                return
            }
            guard let documents = querySnapshot?.documents else {return}
            let users = documents.compactMap { queryDocument -> User? in
                let user = try? queryDocument.data(as: User.self)
                return user
            }
            self.users.send(users)
        }
    }
    
    func updateUser(with id: String,salutation: String,firstName: String,lastName: String,street: String,houseNumBer : String,zipCode : String,email: String,rolle: String,emailConfirm: Bool,phoneNumber: String,country: String){
        let data: [String: Any] = [
            "salutation": salutation,
            "firstName" : firstName,
            "lastName" : lastName,
            "street" : street,
            "houseNumBer" : houseNumBer,
            "zipCode" : zipCode,
            "email" : email,
            "rolle" : rolle,
            "emailConfirm" : emailConfirm,
            "phoneNumber" : phoneNumber,
            "country" : country
        ]
        FirebaseManager.shared.database.collection("users").document(id).setData(data, merge: true){error in
            if let error = error {
                print("User wurde nicht aktualisiert", error.localizedDescription)
                return
                
            }
        }
        
    }
    
    func deleteUser(with id: String) {
        FirebaseManager.shared.database.collection("users").document(id).delete(){error in
            if let error {
                print("user kann nicht gelöscht werden",error.localizedDescription)
                return
            }
        }
    }
}
