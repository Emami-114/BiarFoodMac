//
//  AddCategorieViewModel.swift
//  BiarFoodMac
//
//  Created by Ecc on 25/08/2023.
//

import Foundation
import Combine
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift
class CategorieViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var description = ""
    @Published var type: String = ""
    @Published  var selectedImage: NSImage? = nil
    @Published  var uploadProgress: Double = 0.0
    @Published  var uploadComplete: Bool? = nil
    
    @Published var selectedCategorie = Category(mainId: "", name: "", desc: "", type: "", imageUrl: "")
    @Published var categories = [Category]()
    @Published var mainCategories = [Category]()
    private var cancellables = Set<AnyCancellable>()
    
    let categorieRespository = CategorieRepository.shared
    let storageRespository = StorageRepository.shared
    
    
    init() {
        categorieRespository.categories
            .sink{ [weak self] categories in
                guard let self else {return}
                self.categories = categories
                self.mainCategories = categories.filter({ category in
                    category.type == "Main"
                })
                
            }
            .store(in: &cancellables)
        fetchCategories()
    }
    

    
    
    func createCategorie() async throws{
        
        guard let imageUrl = try await uploadCatgoryPhoto() else {return}
        
        categorieRespository.createCatgorie(title: title, mainId: selectedCategorie.id ?? "", desc: description, type: type, imageUrl: imageUrl)
        

    }
    
    func resetCategoryFiels() {
        self.title = ""
        self.description = ""
        self.type = ""
        self.selectedImage = nil
        self.selectedCategorie = Category(mainId: "",name: "",desc: "", type: "", imageUrl: "")
        
    }
    
    
  private func uploadCatgoryPhoto() async throws -> String? {
        guard let image = selectedImage else {return ""}
    
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/category_images/\(filename)")
        guard let imageDataCompressor = image.compressUnderMegaBytes(megabytes: 0.5) else {return nil}
        
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
    
    func choosePhoto() {
        self.selectedImage = PhotoChoisePanel.shared.choosePhoto()
    }
    
    func fetchCategories(){
        categorieRespository.fetchCatrgories()
    }
    

    
    
    func deleteCategory(with id :String,imageUrl: String){
        categorieRespository.deleteCategory(with: id)
        storageRespository.deleteImage(with: imageUrl)
    }
    
}

