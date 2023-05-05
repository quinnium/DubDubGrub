//
//  HapticManager.swift
//  DubDubGrub
//
//  Created by AQ on 23/08/2022.
//

import UIKit

struct HapticManager {
    
    static func playSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}
