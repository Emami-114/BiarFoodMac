//
//  FirebaseManager.swift
//  BiarFoodMac
//
//  Created by Ecc on 22/08/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage
class FirebaseManager {
    static let shared = FirebaseManager()
    
    let auth = Auth.auth()
    
    let database = Firestore.firestore()
    let storage = Storage.storage()
    
    var userId: String? {
        auth.currentUser?.uid
    }
    
}
