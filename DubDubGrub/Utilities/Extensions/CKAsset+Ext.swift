//
//  CKAsset+Ext.swift
//  DubDubGrub
//
//  Created by Quinn on 19/07/2022.
//

import UIKit
import CloudKit

extension CKAsset {
    
    func convertToUIImage(in dimension: ImageDimension) -> UIImage {
        let placeholder = ImageDimension.getPlaceholderImage(for: dimension)
        
        guard let fileURL = self.fileURL else { return placeholder }
        
        do {
            let data = try Data(contentsOf: fileURL)
            return UIImage(data: data) ?? placeholder
        } catch {
            return placeholder
        }
    }
}
