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

    let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    let data = [
        "quick n easy",
        "kid-friendly",
        "beverage",
        "dessert",
        "vegan"    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid (columns: columns, spacing: 20) {
                    ForEach(data, id: \.self) { category in
                        NavigationLink (
                            destination: RecipeByCateView(title: category)) {
                            CategoryGridView(title: category)
                        }
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

struct RecipeByCateView : View {
    
    var db = Firestore.firestore()
    var title : String
    @State var recipeInRequest = [RecipeViewModel]()

    var body: some View {
        RecipeListView(recipeViewModels: recipeInRequest)
        .onAppear(perform: loadData)
        .navigationTitle(Text(self.title))
    }
    func loadData(){
        db.collection("Recipe").whereField("categories", arrayContains: title)
            .getDocuments() { (querySnapshot, err) in
                if let queryss = querySnapshot {
                    self.recipeInRequest = queryss.documents.compactMap { document -> RecipeViewModel? in
                        let recipe = try? document.data( as: Recipe.self )
                        if let recipe = recipe {
                            return RecipeViewModel(recipe: recipe)
                        } else {
                            return nil
                        }
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
