//
//  CatgegoryView.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 12/8/20.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct CategoryView: View {
    
    let data = [
        "quick n easy",
        "kid-friendly",
        "beverage",
        "dessert",
        "vegan"    ]
    
    let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    

    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid (columns: columns, spacing: 20) {
                    ForEach(data, id: \.self) { item in
                        //let categoryVM = CategoryViewModel(categoryName: item)
                        //NavigationLink (destination: RecipeListView(recipeViewModels: categoryVM.recipeViewModels)
                        //) {
                            CategoryGridView(title: item)
                        //}
                    }
                }
                .padding(.horizontal)
            }
            .navigationBarHidden(true)
        }
    }
}
    

struct CategoryGridView : View {
    var title : String
    
    var body : some View {
        NavigationLink (destination: RecipeGridView(title: self.title)) {
        VStack {
            Text(title)
                .bold()
                .foregroundColor(.white)
        }
        .frame(width: 170, height: 170)
        .background(Color.green)
        .cornerRadius(25)
        }
    }
}

struct RecipeGridView : View {
    
    var db = Firestore.firestore()
    var title : String
    @State var recipeInRequest = [Recipe]()

    var body: some View {
        List(recipeInRequest) { recipe in
            Text(recipe.title)
        }.onAppear(perform: loadData)
        .navigationTitle(Text(self.title))
    }
    func loadData(){
        db.collection("Recipe").whereField("categories", arrayContains: title)
            .getDocuments() { (querySnapshot, err) in
                if let queryss = querySnapshot {
                    self.recipeInRequest = queryss.documents.compactMap { document -> Recipe? in
                        try? document.data( as: Recipe.self )
                    }
                }
            }

    }
    

}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
