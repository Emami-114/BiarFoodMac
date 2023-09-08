//
//  AddViewModel.swift
//  BiarFoodMac
//
//  Created by Ecc on 22/08/2023.
//


import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth


class AddProductViewModel: ObservableObject {
    
    let unitList = ["Kg","g","l","ml"]
    let taxList = ["19","17"]
    let bezuspunkts = ["pro 100g","pro 100ml","pro 1000ml"]
    
    @Published  var unitAnount = ""
    @Published  var unitGrundAnount = ""

    @Published  var selectedImage: NSImage? = nil
    
    @Published  var uploadProgress: Double = 0.0
    @Published  var uploadComplete: Bool = true
    
    
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
    @Published var pfand: Bool = false
    @Published var pfandArt: Pfand = .keine
    @Published var pfandPreise = "0.0"
    @Published var nettoFullmenge = ""
    @Published var alkoholgehalt = ""
    @Published var NutriScore: NutriScore = .keine
    @Published var zutatUndAlergie = ""
    @Published var productCountry = ""
    @Published  var unitAmountPreise = ""

    //Mark: Nähwertdeklaration
    @Published var bezugsPunk = ""
    @Published var brennwertKJ = ""
    @Published var brennwertKcal = ""
    @Published var fett = ""
    @Published var fettDavonSaueren = ""
    @Published var kohlenhydrate = ""
    @Published var kohlenhydrateDavonZucker = ""
    @Published var eiweiß = ""
    @Published var salz = ""
    @Published var additionallyWert = ""
    @Published var isCold: Bool = false
    @Published var isPublic : Bool = true
    
    
    let productRepository = ProductRepository.shared
    let storageRepository = StorageRepository.shared
    
    
    func createProduct() async throws{
        let preiseReplacing = price.replacingOccurrences(of: ",", with: ".")
        let salePreiseReplacing = salePrice.replacingOccurrences(of: ",", with: ".")
        let pfandPreiseReplacing = pfandPreise.replacingOccurrences(of: ",", with: ".")
        let preiseDouble = Double(preiseReplacing) ?? 0.0
         let salePreiseDouble = Double(salePreiseReplacing) ?? 0.0
        let pfandPreiseDouble = Double(pfandPreiseReplacing)  ?? 0.0
        
        let imageUrl = try await uploadToFirestorage()
        
        productRepository.createProduct(title: title, description: description, price: preiseDouble, categorie: Array(categorie),brand: brand ,sale: sale, salePrice: salePreiseDouble, unit: unit, imageUrl: imageUrl, unitAmountPrice: unitGrundAnount, tax: Int(tax) ?? 0, articleNumber: articleNumber, available: available, availableAmount: Int(availableAmount) ?? 0, deposit: pfand, depositType: pfandArt.title, depositPrice: pfandPreiseDouble, netFillingQuantity: nettoFullmenge, alcoholicContent: alkoholgehalt, nutriScore: NutriScore.rawValue, ingredientsAndAlegy: zutatUndAlergie, madeIn: productCountry, referencePoint: bezugsPunk, calorificKJ: brennwertKJ, caloricValueKcal: brennwertKcal, fat: fett, fatFromSour: fettDavonSaueren, carbohydrates: kohlenhydrate, CarbohydratesFromSugar: kohlenhydrateDavonZucker, protein: eiweiß, salt: salz, additionallyWert: additionallyWert,isCold: isCold,isPublic: isPublic)
    }
    @MainActor
    func uploadToFirestorage() async throws -> String{
        guard let image = selectedImage else {return "" }
        var imageUrl = ""
        var progress = 0.0
        try await storageRepository.uploadToFirestorage(image: image) { imageurl, progres in
            imageUrl = imageurl
            progress = progres

        }
        if progress >= 1 {
            self.uploadComplete = true
        }
        self.uploadProgress = progress
        return imageUrl
        
                   
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
        self.pfand = false
        self.pfandArt = .keine
        self.pfandPreise = "0.0"
        self.nettoFullmenge = ""
        self.alkoholgehalt = ""
        self.NutriScore = .keine
        self.zutatUndAlergie = ""
        self.productCountry = ""
        self.unitAmountPreise = ""

        //Mark: Nähwertdeklaration
        self.bezugsPunk = ""
        self.brennwertKJ = ""
        self.brennwertKcal = ""
        self.fett = ""
        self.fettDavonSaueren = ""
        self.kohlenhydrate = ""
        self.kohlenhydrateDavonZucker = ""
        self.eiweiß = ""
        self.salz = ""
        self.additionallyWert = ""
        self.selectedImage = nil
        self.isCold = false
        self.isPublic = true

        
    }
    
    
    func choosePhoto() {
        self.selectedImage = PhotoChoisePanel.shared.choosePhoto()
    }
    
    
    func unitPreise() -> Int{
        
        let amount = Int(unitAnount) ?? 0
        let groundAmount = Int(unitGrundAnount) ?? 0
        guard let preseInt = Int(price) else { return 0}
        
        return (preseInt / amount)*groundAmount
    }
    

    
}
