//
//  StorageRepository.swift
//  BiarFoodMac
//
//  Created by Ecc on 05/09/2023.
//

import Foundation
import FirebaseStorage
import AppKit
class StorageRepository{
    static let shared = StorageRepository()
    
    func uploadToFirestorage(image: NSImage,path:String = "product_images",completion: @escaping (_ imageurl : String,_ progres: Double) -> ()) async throws {
        var progressDouble : Double = 0.0
        var imageUrl : String = ""
        
        let filename = NSUUID().uuidString
        let ref = FirebaseManager.shared.storage.reference(withPath: "/\(path)/\(filename)")
        guard let imageDataCompressor = image.compressUnderMegaBytes(megabytes: 0.5) else {
            return
            
        }

//        guard let imageData = imageDataCompressor.tiffRepresentation(using: .jpeg, factor: 0.5) else {return nil}
        
        do{
            _ = try await ref.putDataAsync(imageDataCompressor,metadata: nil,onProgress: {progres in
                progressDouble = Double(progres?.completedUnitCount ?? 0) / Double(progres?.totalUnitCount ?? 0)
            })
           
            let url = try await ref.downloadURL()
          
           imageUrl = url.absoluteString

        }catch{
            print("fehler beim upload images")
             return
        }
        completion(imageUrl,progressDouble)
    }
    
    
    
    func deleteImage(with imageurl: String){
        FirebaseManager.shared.storage.reference(forURL: imageurl).delete { error in
            if error != nil {
                print("Produkt bild könnte nicht gelöscht werden")
                return
            }
        }
    }
}
