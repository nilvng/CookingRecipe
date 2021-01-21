//
//  UserView.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 12/11/20.
//

import SwiftUI
import Combine
import Firebase
import FirebaseFirestoreSwift
import Resolver

struct UserView: View {
    @ObservedObject var userVM  = UserViewModel()
    @State var show : Bool = false
    @State var editVM = EditRecipeViewModel.newRecipe()
    @Injected var authService : AuthenticationService
    var auth = Auth.auth()
    @State private var signedIn = false
    @State private var email : String = ""

    init() {
        self.signedIn = auth.currentUser?.isAnonymous != true
        print(signedIn)
        }

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: true) {
                VStack (alignment: .leading, spacing: 10){
                    Text("Hi \(authService.user?.displayName ?? "newcomer")")
                    Section{
                        // if ((auth.currentUser?.isAnonymous) != nil) {
                        if (self.signedIn) {
                            Button(action: {
                                do {
                                    try Auth.auth().signOut()
                                    self.signedIn = false
                                } catch let signOutError as NSError {
                                    print ("Error signing out: %@", signOutError)
                                }
                            }){
                                Text("Log Out")
                            }
                        } else {
                            GoogleLogin(signedIn: $signedIn)
                                .frame(width: 200, height: 30, alignment: .center)
                        }
                    }
                    
                    FavoriteView(bookmarks: self.userVM.bookmarks)
                    
                    VStack {
                        HStack{
                            Text("Created")
                            Button(action: {
                                self.editVM  = EditRecipeViewModel.newRecipe()
                                self.show.toggle()
                            }) {
                                Image(systemName: "plus")
                                    .resizable().frame(width: 18, height: 18).foregroundColor(.white)
                            }
                            .padding()
                            .background(Color.red)
                            .clipShape(Circle())
                            .padding()
                        }
                        
                        
                        ForEach(userVM.recipes) { recipe in
                            VStack {
                                NavigationLink(destination:
                                                EditRecipeView(editRecipeVM: EditRecipeViewModel(recipe: recipe),isNew: false)
                                ) {
                                    HStack {
                                        if recipe.photoUrl != "" {
                                            ImageLoaderView(withURL: recipe.photoUrl)
                                                .frame(width:100, height:100)

                                        }
                                        else if recipe.videoUrl != nil && recipe.videoUrl != ""{
                                            VideoPlayer(urlString: recipe.videoUrl!)
                                                .frame(height: 150, alignment: .center)
                                        }
                                        Text(recipe.title)
                                        Spacer(minLength: 0)
                                        Button(action : {
                                            userVM.deleteRecipe(recipe : recipe)
                                        }){
                                            Image(systemName: "trash")
                                        }
                                    }
                                }
                                Divider()
                            }
                        }
                    }
                }
            }
        }
        .sheet(isPresented: self.$show){
            EditRecipeView(editRecipeVM: self.editVM)
        }
    }
}
struct FavoriteView : View {
    var bookmarks : [RecipePreviewInfo]
    var body : some View {
        Text("Favorites")
            .font(.title)
        ScrollView(.horizontal, showsIndicators: false) {
            HStack (alignment: .top, spacing: 0){
                ForEach(self.bookmarks){ recipeP in
                    VStack (alignment: .center, spacing: 10) {
                        if let image = recipeP.image{
                            ImageLoaderView(withURL: image)
                                .frame(width: 100, height: 100, alignment: .center)
                        }
                        Text(recipeP.title)

                    }
                }
            }
        }
    }
}

class UserViewModel : ObservableObject {
    @Injected var recipeRepo : RecipeRepository
    @Injected var bookmarkRepo : BookmarkRepository
    
    @Published var recipes = [Recipe]()
    @Published var bookmarks = [RecipePreviewInfo]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        recipeRepo.$recipes
            .assign(to: \.recipes, on: self)
            .store(in: &cancellables)
        
        bookmarkRepo.$bookmarks
            .assign(to: \.bookmarks, on: self)
            .store(in: &cancellables)
    }
    
    func deleteRecipe(recipe : Recipe){
        recipeRepo.deleteRecipe(recipe)
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
