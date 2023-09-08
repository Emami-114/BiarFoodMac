//
//  CategorieRepository.swift
//  BiarFoodMac
//
//  Created by Ecc on 25/08/2023.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift
 class CategorieRepository {
    
    static let shared = CategorieRepository()
    var categories = CurrentValueSubject<[Category],Never>([])
    var categorieListner: ListenerRegistration?

    private let encoder: Firestore.Encoder = {
        let encoder = Firestore.Encoder()
//        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    private let decoder : Firestore.Decoder = {
        let decoder = Firestore.Decoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    
    
    func fetchCatrgories(){
        
        self.categorieListner = FirebaseManager.shared.database.collection("categories")
        
            .addSnapshotListener({ queryDocument, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let document = queryDocument?.documents else {
                    print("Fehler beim laden Produkten")
                    return
                }
                
                let categories = document.compactMap { queryDocumentSnapshot -> Category? in

                    let categorie = try? queryDocumentSnapshot.data(as: Category.self)

                    return categorie
                }
                self.categories.send(categories)
                
            })
    }

}

extension CategorieRepository {
    
    func updateCategory(with id: String,title:String,desc:String,type: String,imageUrl:String){
        let data = [
            "name": title,
            "desc" : desc,
            "type" : type,
            "imageUrl" : imageUrl
        ]
        FirebaseManager.shared.database.collection("categories").document(id).setData(data, merge: true){error in
            if error != nil{
                print("Kategorie Update Fehler geschlagen")
            }
        }
    }

    
//    func addSubCategorie(mainId: String,subCat: Category) async throws{
//        guard let data = try? encoder.encode(subCat) else {
//            throw URLError(.badURL)
//        }
//        let subCategory = [ "subcategories" : FieldValue.arrayUnion([data]) ]
//      try await  FirebaseManager.shared.database.collection("categories").document(mainId).updateData(subCategory)
//
//        }
//
    
    
    
    func createCatgorie(title:String,mainId:String,desc:String,type: String,imageUrl:String){
        let firebaseRes = FirebaseManager.shared.database.collection("categories")
        
        let categorie = Category(mainId: mainId, name: title,desc: desc,type: type,imageUrl: imageUrl)
        
        do{
            try firebaseRes.addDocument(from: categorie)
        } catch let error {
            print("Fehler beim Speichern des tasks: \(error)")
        }
        
    }
    
    
    func deleteCategory(with id: String){
        FirebaseManager.shared.database.collection("categories").document(id).delete(){error in
            if let error{
                print("Kategorie könnte nicht gelöscht werden",error.localizedDescription)
                return
            }
        }
    }
    
}



