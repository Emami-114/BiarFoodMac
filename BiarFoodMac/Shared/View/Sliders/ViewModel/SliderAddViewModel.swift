//
//  SliderAddViewModel.swift
//  BiarFoodMac
//
//  Created by Ecc on 07/09/2023.
//

import Foundation
import AppKit
class SliderAddViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var desc: String = ""
    @Published var isPublic: Bool = true
    @Published  var selectedImage: NSImage? = nil
    @Published  var uploadProgress: Double = 0.0
    @Published  var uploadComplete: Bool = false
    
    let sliderRepository = SliderRepository.shared
    let storageRepository = StorageRepository.shared
    
    func createSlider() async throws {
        let imageUrl = try await uploadPhoto()
        
        sliderRepository.createSlider(title: title, desc: desc, imageUrl: imageUrl, isPublich: isPublic)
        
    }
    func uploadPhoto() async throws -> String {
        guard let image = selectedImage else {return ""}
        var imageUrl = ""
        try await storageRepository.uploadToFirestorage(image: image,path: "slider_images", uploadprogrss: { progres in
            self._uploadProgress = Published(initialValue: progres)
                    if progres >= 1 {
                        self._uploadComplete = Published(initialValue: true)
                    }
            print("Upload Image Progress: \(progres)")
        }, imageUrl: { imageurl in
            imageUrl = imageurl

        })
    
        return imageUrl
    }
    
    func clearFields(){
        self.title = ""
        self.desc = ""
        self.isPublic = true
        self.selectedImage = nil
        self.uploadProgress = 0.0
        
    }
    
    
    @MainActor func choosePhoto(){
        self.selectedImage = PhotoChoisePanel.shared.choosePhoto()
    }
    
}
