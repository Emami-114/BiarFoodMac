//
//  ImageUploader.swift
//  BiarFoodMac
//
//  Created by Ecc on 22/08/2023.
//

import Foundation
import PhotosUI
import Firebase
import FirebaseStorage
import SwiftUI
struct ImageUploader {
    
    var progress = 0.0
    
    static func uploadImage(image: NSImage) async throws -> String? {

        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/product_images/\(filename)")
        
//        if let imageData = image.tiffRepresentation,
//            let bitmap = NSBitmapImageRep(data: imageData),
//                let compressedData = bitmap.representation(using: .jpeg, properties: [.compressionFactor: NSNumber(value: Float(0.5))])
        
            guard let imageData = image.tiffRepresentation(using: .jpeg, factor: 0.5) else { return nil }
            
        
        do{
            _ = try await ref.putDataAsync(imageData)
            let url = try await ref.downloadURL()
            return url.absoluteString
        }catch {
            print("Debug: failed to upload image with error \(error.localizedDescription)")
            return nil
        }
      
        
      
        
    }
}
