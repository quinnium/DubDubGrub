//
//  PhotoPicker.swift
//  DubDubGrub
//
//  Created by Quinn on 22/07/2022.
//

import SwiftUI

struct PhotoPicker: UIViewControllerRepresentable {
    
    @Binding var image: UIImage
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }
    
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) { }
    
    
    func makeCoordinator() -> Coordinator { return Coordinator(photoPicker: self) }
    
    
    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        let photoPicker: PhotoPicker
        
        init(photoPicker: PhotoPicker) { self.photoPicker = photoPicker }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.editedImage] as? UIImage { photoPicker.image = image }
            picker.dismiss(animated: true)
        }
    }
}