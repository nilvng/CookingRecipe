//
//  BookmarkViewModel.swift
//  CookingRecipe
//
//  Created by Ngan Nguyen Bao on 12/16/20.
//

import Foundation
import Disk
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

class BookmarkViewModel : ObservableObject{
    
    var db = Firestore.firestore()
    var bookmarkPath : String = "User/user1/bookmarks"
    @Published private var savedRecipes = [RecipePreviewInfo]()
    
    init() {
        loadLocalData()
    }
    
    func loadDataFromFirebase(){
        db.collection(bookmarkPath).addSnapshotListener { (querySnapshot, err) in
            if let querySnapshot = querySnapshot {
                self.savedRecipes = querySnapshot.documents.compactMap { document -> RecipePreviewInfo? in
                    try? document.data(as: RecipePreviewInfo.self)
                }
            }
        }
    }

    func toFavorite(recipe : RecipePreviewInfo){

        if let i = savedRecipes.firstIndex(of: recipe){
            savedRecipes.remove(at: i)
        } else {
            savedRecipes.append(recipe)
        }
        // write data somewhere....
        writeDataLocally()
    }
    
    func loadLocalData(){
        do {
            self.savedRecipes = try Disk.retrieve("savedRecipes.json", from: .caches, as: [RecipePreviewInfo].self)
        } catch  {
            print("Cannot get this list")
             return
        }
    }
    
    func writeDataLocally(){
        
        do {
            try Disk.save(savedRecipes, to: .caches, as: "savedRecipes.json")
        } catch  {
            print("Cannot save to this list")
             return
        }
        
    }
    
}

struct RecipePreviewInfo : Hashable, Codable {

    var prefID : String
    var title : String
    var image : String?
    
}
