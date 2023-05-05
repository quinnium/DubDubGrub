//
//  UIImage+Ext.swift
//  DubDubGrub
//
//  Created by Quinn on 24/07/2022.
//

import UIKit
import CloudKit

extension UIImage {
    
    func comvertToCKAsset() -> CKAsset? {
        
        // Get our app's base document directory URL
        guard let urlPath   = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        // Append some unique identifier for our profile image
        let fileUrl         = urlPath.appendingPathComponent("selectedAvatarImage")
        
        // Write the image data to the location the address poiints to
        guard let imageData = jpegData(compressionQuality: 0.25) else { return nil }
        
        // create our CKAsset with that fileURL
        do {
            try imageData.write(to: fileUrl)
            return CKAsset(fileURL: fileUrl)
        }
        catch {
            return nil
        }
    }
}
