//
//  FirebaseImageView.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 12/12/20.
//

import Foundation
import Combine
import FirebaseStorage
import SwiftUI

let placeholder = UIImage(named: "shu")!

struct FirebaseImage : View {

    @ObservedObject private var imageLoader : FirebaseImageLoader

    var image: UIImage? {
        imageLoader.data.flatMap(UIImage.init)
    }
    
    init(id: String) {
        self.imageLoader = FirebaseImageLoader(id)
    }


    var body: some View {
        HStack(alignment: .center, spacing: nil){
            if let image = image{
                Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            } else {
                Text("Loading...")
            }
        }
    }
}

final class Loader : ObservableObject {
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
