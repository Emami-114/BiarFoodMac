//
//  NSImageCompressor.swift
//  BiarFoodMac
//
//  Created by Ecc on 26/08/2023.
//

import Foundation
import AppKit
extension NSImage {
    func compressUnderMegaBytes(megabytes: CGFloat) -> Data? {

        var compressionRatio = 0.5
        guard let tiff = self.tiffRepresentation, let imageRep = NSBitmapImageRep(data: tiff) else { return nil }
        var compressedData = imageRep.representation(using: .jpeg, properties: [.compressionFactor : compressionRatio])
//        if compressedData == nil { return self }
        while CGFloat(compressedData!.count) > megabytes * 1024 * 1024 {
            compressionRatio = compressionRatio * 0.5
            let newCompressedData = imageRep.representation(using: .png, properties:  [.compressionFactor : compressionRatio])
            if compressionRatio <= 0.4 || newCompressedData == nil {
                break
            }
            compressedData = newCompressedData
        }
        return compressedData
    }
}
