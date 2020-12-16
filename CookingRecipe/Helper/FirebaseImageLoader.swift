//
//  FirebaseImageLoader.swift
//  CookingRecipe
//
//  Created by Ngan Nguyen Bao on 12/16/20.
//

import Foundation
import Firebase
import SwiftUI

class FirebaseImageLoader : ObservableObject {
    @Published var data : Data?

    init(_ id: String){
        // the path to the image
        let url = "\(id)"
        let storage = Storage.storage()
        let ref = storage.reference().child(url)
        ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("\(error)")
            }

            DispatchQueue.main.async {
                self.data = data
            }
        }
    }
}
