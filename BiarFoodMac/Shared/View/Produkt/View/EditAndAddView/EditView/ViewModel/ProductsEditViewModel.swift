//
//  EditViewModel.swift
//  BiarFoodMac
//
//  Created by Ecc on 04/09/2023.
//

import Foundation
import Firebase
import FirebaseStorage
import AppKit
import SwiftUI
class ProductsEditViewModel: ObservableObject {
    
    init(product: Product){
        self._title = Published(initialValue: product.title)
        self._description = Published(initialValue: product.desc)
        self._price = Published(initialValue: String(product.price))
        self._categorie = Published(initialValue: Set(product.categorie))
        self._brand = Published(initialValue: product.brand)
        self._sale = Published(initialValue: product.sale)
        self._salePrice = Published(initialValue: String(product.salePrice))
        self._unit = Published(initialValue: product.unit)
        self._tax = Published(initialValue: String(product.tax))
        self._articleNumber = Published(initialValue: product.articleNumber)
        self._available = Published(initialValue: product.available)
        self._availableAmount = Published(initialValue: String(product.depositType))
        self._deposit = Published(initialValue: product.deposit)
        self._depositType = Published(initialValue: product.depositType)
        self._depositPrice = Published(initialValue: String(product.depositPrice))
        self._netFillingQuantity = Published(initialValue: product.netFillingQuantity)
        self._alcoholicContent = Published(initialValue: product.alcoholicContent)
        self._nutriScore = Published(initialValue: product.nutriScore)
        self._ingredientsAndAlegy = Published(initialValue: product.ingredientsAndAlegy)
        self._madeIn = Published(initialValue: product.madeIn)
        self._unitAmountPrice = Published(initialValue: product.unitAmountPrice)
        self._referencePoint = Published(initialValue: product.referencePoint)
        self._calorificKJ = Published(initialValue: product.calorificKJ)
        self._caloricValueKcal = Published(initialValue: product.caloricValueKcal)
        self._fat = Published(initialValue: product.fat)
        self._fatFromSour = Published(initialValue: product.fatFromSour)
        self._carbohydrates = Published(initialValue: product.carbohydrates)
        self._CarbohydratesFromSugar = Published(initialValue: product.CarbohydratesFromSugar)
        self._protein = Published(initialValue: product.protein)
        self._salt = Published(initialValue: product.salt)
        self._additionallyWert = Published(initialValue: product.additionallyWert)
        self._imageUrl = Published(initialValue: product.imageUrl)
        self._isCold = Published(initialValue: product.isCold)
        self._isPublic = Published(initialValue: product.isPublic)
        self._adult = Published(initialValue: product.adult)
        self._minimumAge = Published(initialValue: product.minimumAge)
    }
    
    
    let unitList = ["Kg","g","l","ml"]
    let taxList = ["19","17"]
    let bezuspunkts = ["pro 100g","pro 100ml","pro 1000ml"]
    
    @Published  var unitAnount = ""
    @Published  var unitGrundAnount = ""
    
    @Published  var selectedImage: NSImage? = nil
    
    @Published  var uploadProgress: Double = 0.0
    @Published  var uploadComplete: Bool = false
    @Published var imageUrl = ""
    
    @Published var title: String = ""
    @Published var description : String = ""
    @Published var price: String = "0.0"
    @Published var categorie : Set<String> = []
    @Published var brand = ""
    @Published var sale : Bool = false
    @Published var salePrice : String = "0.0"
    @Published var unit = ""
    @Published var tax = "19"
    @Published var articleNumber = ""
    @Published var available: Bool = true
    @Published var availableAmount = ""
    @Published var deposit: Bool = false
    @Published var depositType: String = ""
    @Published var depositPrice = "0.0"
    @Published var netFillingQuantity = ""
    @Published var alcoholicContent = ""
    @Published var nutriScore: String = ""
    @Published var ingredientsAndAlegy = ""
    @Published var madeIn = ""
    @Published  var unitAmountPrice = ""
    @Published  var adult = false
    @Published  var minimumAge = 0
    //Mark: Nähwertdeklaration
    @Published var referencePoint = "pro 100ml"
    @Published var calorificKJ = ""
    @Published var caloricValueKcal = ""
    @Published var fat = ""
    @Published var fatFromSour = ""
    @Published var carbohydrates = ""
    @Published var CarbohydratesFromSugar = ""
    @Published var protein = ""
    @Published var salt = ""
    @Published var additionallyWert = ""
    @Published var isCold: Bool = false
    @Published var isPublic : Bool = true
    
    
    
    let productRepository = ProductRepository.shared
    
    
    
    func updateProduct(with id :String)async throws{
        let preiseReplacing = price.replacingOccurrences(of: ",", with: ".")
        let salePreiseReplacing = salePrice.replacingOccurrences(of: ",", with: ".")
        let pfandPreiseReplacing = depositPrice.replacingOccurrences(of: ",", with: ".")
        let preiseDouble = Double(preiseReplacing) ?? 0.0
         let salePreiseDouble = Double(salePreiseReplacing) ?? 0.0
        let pfandPreiseDouble = Double(pfandPreiseReplacing)  ?? 0.0
        
        guard let uploadImageUrl = try await uploadToFirestorage() else { return}

        
        
        productRepository.updateProduct(with: id, title: title, description: description, price: preiseDouble, categorie: Array(categorie), brand: brand, sale: sale, salePrice: salePreiseDouble, unit: unit, imageUrl: updateImage(uploadImageUrl: uploadImageUrl), unitAmountPrice: unitAmountPrice, tax: Int(tax) ?? 0, articleNumber: articleNumber, available: available, availableAmount: Int(availableAmount) ?? 0, deposit: deposit, depositType: depositType, depositPrice: pfandPreiseDouble, netFillingQuantity: netFillingQuantity, alcoholicContent: alcoholicContent, nutriScore: nutriScore, ingredientsAndAlegy: ingredientsAndAlegy, madeIn: madeIn, referencePoint: referencePoint, calorificKJ: calorificKJ, caloricValueKcal: caloricValueKcal, fat: fat, fatFromSour: fatFromSour, carbohydrates: carbohydrates, CarbohydratesFromSugar: CarbohydratesFromSugar, protein: protein, salt: salt, additionallyWert: additionallyWert,isCold: isCold,isPublic: isPublic,adult: adult,minimumAge: minimumAge)
    }
    
    
    func updateImage(uploadImageUrl : String) -> String{

        if selectedImage == nil {
            return imageUrl
        }else{
            return uploadImageUrl
        }
    }
    
    
    
    func uploadToFirestorage() async throws -> String? {
        guard let image = selectedImage else {return ""}
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/product_images/\(filename)")
        guard let imageDataCompressor = image.compressUnderMegaBytes(megabytes: 0.5) else {return nil}
        
        //        guard let imageData = imageDataCompressor.tiffRepresentation(using: .jpeg, factor: 0.5) else {return nil}
        
        do{
            _ = try await ref.putDataAsync(imageDataCompressor,metadata: nil,onProgress: {progres in
                self.uploadProgress = Double(progres?.completedUnitCount ?? 0) / Double(progres?.totalUnitCount ?? 0)
            })
            
            let url = try await ref.downloadURL()
            
            return url.absoluteString
            
        }catch{
            print("fehler beim upload images")
            return nil
        }
    }
    
    func resetFields() {
        self.title = ""
        self.description = ""
        self.price  = ""
        self.categorie = Set<String>()
        self.brand = ""
        self.sale = false
        self.salePrice  = ""
        self.unit = ""
        self.tax = "19"
        self.articleNumber = ""
        self.available = true
        self.availableAmount = ""
        self.deposit = false
        self.depositType = ""
        self.depositPrice = "0.0"
        self.netFillingQuantity = ""
        self.alcoholicContent = ""
        self.nutriScore = ""
        self.ingredientsAndAlegy = ""
        self.madeIn = ""
        self.unitAmountPrice = ""
        
        //Mark: Nähwertdeklaration
        self.referencePoint = ""
        self.calorificKJ = ""
        self.caloricValueKcal = ""
        self.fat = ""
        self.fatFromSour = ""
        self.carbohydrates = ""
        self.CarbohydratesFromSugar = ""
        self.protein = ""
        self.salt = ""
        self.additionallyWert = ""
        self.selectedImage = nil
        
        
    }
    
    
    @MainActor func choosePhoto() {
        self.selectedImage = PhotoChoisePanel.shared.choosePhoto()
    }
}
