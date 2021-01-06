//
//  MediaPicker.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 1/1/21.
//

import Foundation
import SwiftUI
import Firebase
import UIKit

struct MediaPicker : UIViewControllerRepresentable {

    @Binding var chooseMedia : Bool
    @Binding var mediaURL : URL?
    
    func makeCoordinator() -> Coordinator {
        
        return MediaPicker.Coordinator(parent1: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = context.coordinator
        picker.mediaTypes = ["public.image", "public.video"]
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
        
    }
    
    class Coordinator : NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
        
        var parent : MediaPicker
        
        init(parent1 : MediaPicker) {
            
            parent = parent1
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            
            self.parent.chooseMedia = false
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

            let mediaType = info[.mediaType]
            
            if mediaType as! String == "public.movie" {
                let videoNSUrl = info[.mediaURL] as! NSURL
                let videoUrl = videoNSUrl.filePathURL! as NSURL as URL
                self.parent.mediaURL = videoUrl
            } else if mediaType as! String == "public.image"{
                let imageUrl  = info[.imageURL] as! URL
                self.parent.mediaURL = imageUrl
            } else {
                return
            }
            self.parent.chooseMedia = false
        }
    }
}

