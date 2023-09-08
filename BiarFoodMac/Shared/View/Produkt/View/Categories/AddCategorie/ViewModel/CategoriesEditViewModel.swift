//
//  EditViewModel.swift
//  BiarFoodMac
//
//  Created by Ecc on 05/09/2023.
//

import Foundation
import AppKit
import Firebase
import FirebaseStorage
class CategoriesEditViewModel : ObservableObject {
    @Published var title: String = ""
    @Published var description = ""
    @Published var type: String = ""
    @Published var imageUrl: String = ""
    @Published  var selectedImage: NSImage? = nil
    @Published  var uploadProgress: Double = 0.0
    @Published  var uploadComplete: Bool? = nil
    
    let categoriesRepository = CategorieRepository.shared
    
    init(category: Category){
        self._title = Published(initialValue: category.name)
        self._description = Published(initialValue: category.desc)
        self._type = Published(initialValue: category.type)
        self._imageUrl = Published(initialValue: category.imageUrl)
        
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
    
    
    func updateCategory(with id: String) async throws{
            
            guard let uploadImageUrl = try await uploadCatgoryPhoto() else { return}

            categoriesRepository.updateCategory(with: id, title: title, desc: description, type: type, imageUrl: updateImage(uploadImageUrl: uploadImageUrl))
        }
    
    func choosePhoto() {
        self.selectedImage = PhotoChoisePanel.shared.choosePhoto()
    }
    
    
    func updateImage(uploadImageUrl : String) -> String{

        if selectedImage == nil {
            return imageUrl
        }else{
            return uploadImageUrl
        }
    }
    
}
