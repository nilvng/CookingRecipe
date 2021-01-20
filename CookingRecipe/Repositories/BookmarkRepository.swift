//
//  BookmarkRepository.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 12/16/20.
//

import Foundation
import Disk
import Resolver
import SwiftUI
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

class BaseBookmarkRepository {
    @Published var bookmarks = [RecipePreviewInfo]()
}

protocol BookmarkRepository : BaseBookmarkRepository {

    func saveRecipe(_ recipe: RecipePreviewInfo)
    func removeSave(_ recipe: RecipePreviewInfo)

}

class FirebaseBookmarkRepository: BaseBookmarkRepository, BookmarkRepository, ObservableObject {

    @Injected var authService : AuthenticationService
    @Published var userId : String = "unknown"
    
    var bookmarkPath : String {
        "User/\(userId)/bookmarks"
    }
    var db = Firestore.firestore()
    private var cancellables = Set<AnyCancellable>()
    
    func loadData(){
        db.collection(bookmarkPath)
            .order(by: "createdTime", descending: true)
            .getDocuments() { (querySnapshot, err) in
                if let querySnapshot = querySnapshot {
                    self.bookmarks = querySnapshot.documents.compactMap { document -> RecipePreviewInfo? in
                        try? document.data(as: RecipePreviewInfo.self)
                    }
                }
            }
    }
    
    override init() {
        super.init()
        
        authService.$user
            .compactMap { user in user?.uid}
            .assign(to: \.userId, on: self)
            .store(in: &cancellables)
        
        authService.$user
            .receive(on: DispatchQueue.main)
            .sink { user in
                self.loadData()
            }
            .store(in: &cancellables)
}
    
    func saveRecipe(_ recipe: RecipePreviewInfo) {
        if let docid = recipe.id {
            do {
                let _ = try db.collection(bookmarkPath).document(docid).setData(from: recipe)
            }
            catch {
                print("There was an error while trying to save a recipe \(error.localizedDescription).")
            }
        }
        loadData()
    }
    
    func removeSave(_ recipe: RecipePreviewInfo) {
        if let docid = recipe.id {
            db.collection(bookmarkPath).document(docid).delete { (error) in
                if let error = error {
                    print("Error removing document: \(error.localizedDescription)")
                }
            }
        }
        loadData()
    }
    
}

class LocalbookmarkRepository : BaseBookmarkRepository, BookmarkRepository {
    
    var filePath : String = "bookmarks.json"
    
    func loadFavState(recipeId : String) -> Bool {
        var isFav = false
        for bookmark in bookmarks {
            if bookmark.id == recipeId {
                isFav = true
            }
        }
        return isFav
    }
        
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
    
    func removeSave(_ recipe: RecipePreviewInfo){
        
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
