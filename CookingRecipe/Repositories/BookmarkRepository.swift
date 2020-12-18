//
//  BookmarkRepository.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 12/16/20.
//

import Foundation
import Disk
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

class BaseBookmarkRepository {
    @Published var bookmarks = [RecipePreviewInfo]()
}

protocol BookmarkRepository : BaseBookmarkRepository {

    func saveRecipe(_ recipe: RecipePreviewInfo)
    func removeBookmark(_ recipe: RecipePreviewInfo)
    
}

class FirebaseBookmarkRepository: BaseBookmarkRepository, BookmarkRepository, ObservableObject {
    
    var bookmarkPath : String = "User/user1/bookmarks"
    var db = Firestore.firestore()
    
    private func loadData(){
        db.collection(bookmarkPath)
            .order(by: "createdTime", descending: true)
            .addSnapshotListener { (querySnapshot, err) in
            if let querySnapshot = querySnapshot {
                self.bookmarks = querySnapshot.documents.compactMap { document -> RecipePreviewInfo? in
                    try? document.data(as: RecipePreviewInfo.self)
                }
            }
        }
    }
    
    func saveRecipe(_ recipe: RecipePreviewInfo) {
        if let docid = recipe.id {
            do {
                let _ = try db.collection(bookmarkPath).document(docid).setData(from: recipe)
            }
            catch {
                print("There was an error while trying to save a task \(error.localizedDescription).")
            }
        }
    }
    
    func removeBookmark(_ recipe: RecipePreviewInfo) {
        if let docid = recipe.id {
            db.collection(bookmarkPath).document(docid).delete { (error) in
                if let error = error {
                    print("Error removing document: \(error.localizedDescription)")
                }
            }
        }
    }


    override init() {
        super.init()
        loadData()
    }
}

class LocalbookmarkRepository : BaseBookmarkRepository, BookmarkRepository {
    var filePath : String = "bookmarks.json"
    
    func saveRecipe(_ recipe: RecipePreviewInfo){
        self.bookmarks.append(recipe)
    }
    func loadData(){
        do {
            self.bookmarks = try Disk.retrieve(filePath, from: .caches, as: [RecipePreviewInfo].self)
        } catch  {
            print("Cannot get this list")
             return
        }
    }
    
    func removeBookmark(_ recipe: RecipePreviewInfo){
        
        if let i = bookmarks.firstIndex(of: recipe){
            bookmarks.remove(at: i)
            
        }
    }
    func writeData(){
        do {
            try Disk.save(bookmarks, to: .caches, as: filePath)
        } catch  {
            print("Cannot save to this list")
             return
        }
        
    }

    
    override init() {
        super.init()
        loadData()
    }

}
