//
//  TwoColumnsView.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 12/18/20.
//

import SwiftUI

struct TwoColumnsView<Content: View, Content1 : View>: View {
    var subView : Content
    var desView : Content1
    var data : [String]
    
    let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid (columns: columns, spacing: 20) {
                    ForEach(data, id: \.self) { category in
//                        NavigationLink (
//                            destination: RecipeGridView(title: category)) {
//                            CategoryGridView(title: category)
//                        }
                    }
                }
                .padding(.horizontal)
            }
            .navigationBarHidden(true)
        }

    }
}

struct TwoColumnsView_Previews: PreviewProvider {
    static var previews: some View {
        TwoColumnsView(subView: Text("hello"),
                       desView : Image(systemName: "smile"),
                       data: ["vegan", "chicken"])
    }
}
