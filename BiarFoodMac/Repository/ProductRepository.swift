//
//  ProductRepository.swift
//  BiarFoodMac
//
//  Created by Ecc on 22/08/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine
class ProductRepository {
    
    static let shared = ProductRepository()
    var listner: ListenerRegistration?
    var products = CurrentValueSubject<[Product],Never>([])
    
}
extension ProductRepository {
    func fetchProducts(with catId: String){
        self.listner = FirebaseManager.shared.database.collection("produkten")
            .order(by: "createdAt", descending: true)
            .whereField("categorie", arrayContains: catId)
            .addSnapshotListener({ queryDocument, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let document = queryDocument?.documents else {
                    print("Fehler beim laden Produkten")
                    return
                }
                
                let products = document.compactMap { queryDocumentSnapshot -> Product? in
                    let product = try? queryDocumentSnapshot.data(as: Product.self)
                    
                    
                    return product
                }
                self.products.send(products)
                
            })
        
    }
    
    func removeListner(){
        self.products.send([])
        self.listner?.remove()
    }
}

extension ProductRepository {
    
    func createProduct(title:String,description: String,price:Double,categorie: [String],brand:String,sale: Bool,salePrice: Double,unit: String,imageUrl:String,unitAmountPrice: String,tax: Int,articleNumber: String,available: Bool,availableAmount: Int,deposit: Bool,depositType: String,depositPrice: Double,netFillingQuantity: String,alcoholicContent: String,nutriScore: String,ingredientsAndAlegy: String,madeIn: String,referencePoint: String,calorificKJ: String,caloricValueKcal: String,fat: String,fatFromSour: String,carbohydrates: String,CarbohydratesFromSugar: String,protein: String,salt: String, additionallyWert: String,isCold: Bool,isPublic: Bool,adult: Bool,
        minimumAge: Int
    
    ){
        let firebaseRef = FirebaseManager.shared.database.collection("produkten")
        let documentId = firebaseRef.document().documentID
        let product = Product(id: documentId ,title: title,
                              desc: description,
                              price: price,
                              categorie: categorie,
                              brand: brand,
                              sale: sale,
                              salePrice: salePrice,
                              unit: unit,
                              imageUrl: imageUrl,
                              unitAmountPrice: unitAmountPrice,
                              tax: tax,
                              articleNumber: articleNumber,
                              available: available,
                              availableAmount: availableAmount,
                              deposit: deposit,
                              depositType: depositType,
                              depositPrice: depositPrice,
                              netFillingQuantity: netFillingQuantity,
                              alcoholicContent: alcoholicContent,
                              nutriScore: nutriScore,
                              ingredientsAndAlegy: ingredientsAndAlegy,
                              madeIn: madeIn, referencePoint: referencePoint,
                              calorificKJ: calorificKJ, caloricValueKcal: caloricValueKcal, fat: fat, fatFromSour: fatFromSour, carbohydrates: carbohydrates, CarbohydratesFromSugar: CarbohydratesFromSugar, protein: protein, salt: salt, additionallyWert: additionallyWert,isCold: isCold,isPublic: isPublic,adult: adult,minimumAge: minimumAge)
        
        do{
            try firebaseRef.document(documentId).setData(from: product)
        } catch let error {
            print("Fehler beim Speichern des tasks: \(error)")
        }
        
    }
    
}

extension ProductRepository{
    func updateProduct(with id: String,title:String,description: String,price:Double,categorie: [String],brand:String,sale: Bool,salePrice: Double,unit: String,imageUrl:String,unitAmountPrice: String,tax: Int,articleNumber: String,available: Bool,availableAmount: Int,deposit: Bool,depositType: String,depositPrice: Double,netFillingQuantity: String,alcoholicContent: String,nutriScore: String,ingredientsAndAlegy: String,madeIn: String,referencePoint: String,calorificKJ: String,caloricValueKcal: String,fat: String,fatFromSour: String,carbohydrates: String,CarbohydratesFromSugar: String,protein: String,salt: String, additionallyWert: String,isCold: Bool,isPublic: Bool,adult: Bool,
                       minimumAge: Int){
        
        let data : [String : Any] = [
            "title" : title,
            "desc" : description,
            "price" : price,
            "categorie" : categorie,
            "brand" : brand,
            "sale" : sale,
            "salePrice" : salePrice,
            "unit" : unit,
            "imageUrl" : imageUrl,
            "unitAmountPrice" : unitAmountPrice,
            "tax" : tax,
            "articleNumber" : articleNumber,
            "available" : available,
            "availableAmount" : availableAmount,
            "deposit" : deposit,
            "depositType" : depositType,
            "depositPrice" : depositPrice,
            "netFillingQuantity" : netFillingQuantity,
            "alcoholicContent" : alcoholicContent,
            "nutriScore" : nutriScore,
            "ingredientsAndAlegy" : ingredientsAndAlegy,
            "madeIn" : madeIn,
            "referencePoint" : referencePoint,
            "calorificKJ" : calorificKJ,
            "caloricValueKcal" : caloricValueKcal,
            "fat" : fat,
            "fatFromSour" : fatFromSour,
            "carbohydrates" : carbohydrates,
            "CarbohydratesFromSugar" : CarbohydratesFromSugar,
            "protein" : protein,
            "salt" : salt,
            "additionallyWert" : additionallyWert,
            "isCold" : isCold,
            "isPublic" : isPublic,
            "adult" : adult,
            "minimumAge" : minimumAge
        ]
        
        FirebaseManager.shared.database.collection("produkten").document(id).setData(data,merge: true){error in
            if let error = error {
                print("Produkt wurde nicht aktualisiert", error.localizedDescription)
                return
            }
            
        }
        
    }
    
    func deleteProduct(with id: String) {
        FirebaseManager.shared.database.collection("produkten").document(id).delete(){error in
            if let error {
                print("produkt kann nicht gelöscht werden",error.localizedDescription)
                return
            }
        }
    }
    
}
