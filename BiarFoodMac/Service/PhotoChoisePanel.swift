//
//  PhotoChoisePanel.swift
//  BiarFoodMac
//
//  Created by Ecc on 05/09/2023.
//

import Foundation
import AppKit
class PhotoChoisePanel {
    static let shared = PhotoChoisePanel()
    
    
    
    func choosePhoto() -> NSImage {
        var selectedImage: NSImage = NSImage()
        let dialog = NSOpenPanel()
        dialog.allowedContentTypes = [.image]
        dialog.allowsMultipleSelection = false
        if dialog.runModal() == NSApplication.ModalResponse.OK {
            if let imageURL = dialog.url, let image = NSImage(contentsOf: imageURL) {
                selectedImage = image
            }
        }
        return selectedImage
    }
    
}
