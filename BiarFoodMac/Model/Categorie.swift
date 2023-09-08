//
//  Categorie.swift
//  BiarFoodMac
//
//  Created by Ecc on 25/08/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

//struct Categorie: Codable,Hashable {
//    @DocumentID var id: String?
//    let title: String
//    let description: String
//    let type: String
//    let mainId: String
//
//}



struct Category: Codable,Identifiable,Hashable{
    func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    
    @DocumentID var id: String?
    let mainId: String
    let name: String
    let desc: String
    let type: String
    let imageUrl : String
}



struct Subcategory: Codable,Hashable {
    var id: String = UUID().uuidString
    var mainId: String
    var name: String
    let desc: String
    let type: String

}
