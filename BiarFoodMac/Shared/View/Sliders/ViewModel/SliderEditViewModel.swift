//
//  SliderEditViewModel.swift
//  BiarFoodMac
//
//  Created by Ecc on 07/09/2023.
//

import Foundation
import AppKit
class SliderEditViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var desc: String = ""
    @Published var imageUrl: String = ""
    @Published var isPublic: Bool = true
    @Published  var selectedImage: NSImage? = nil
    @Published  var uploadProgress: Double = 0.0
    @Published  var uploadComplete: Bool = false
    
    let sliderRepository = SliderRepository.shared
    let storageRepository = StorageRepository.shared
    init(slider: Slider){
        self._title = Published(initialValue: slider.title)
        self._desc = Published(initialValue: slider.desc)
        self._imageUrl = Published(initialValue: slider.imageUrl)
        self._isPublic = Published(initialValue: slider.isPublich)
    }
    
    func updateSlider(with id: String)async throws {
        
        let imageUrl = try await uploadPhoto()

        sliderRepository.updateSlider(with: id, title: title, desc: desc, imageUrl: updateImage(uploadImageUrl: imageUrl), isPublich: isPublic)
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
    
    func updateImage(uploadImageUrl : String) -> String{

        if selectedImage == nil {
            return self.imageUrl
        }else{
            return uploadImageUrl
        }
    }
    @MainActor func choosePhoto(){
        self.selectedImage = PhotoChoisePanel.shared.choosePhoto()
    }
    
}
