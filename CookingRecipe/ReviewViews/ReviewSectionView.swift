//
//  ReviewSection.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 1/21/21.
//

import SwiftUI

struct ReviewSectionView : View {
    @State var index : Int = 0
    @StateObject var reviewVM : ReviewViewModel
    
    var body : some View {
        Text("Reviews")
            .bold()
            .font(.title2)
            .padding(.horizontal, 7)
            .padding(.bottom, 5)
        if let yourReview = reviewVM.yourReview {
            ReviewEditorView(reviewVM: reviewVM,review: yourReview, isNew : false)
        } else{
            ReviewEditorView(reviewVM: reviewVM,review: Review(), isNew : true)
        }

        Divider()
        
        ForEach(reviewVM.reviews){ review in
            ReviewCard(review: review)
            Divider()
        }
    }
}

struct ReviewCard : View {
    var review : Review
    
    var body: some View{
        VStack(alignment: .leading, spacing: 10){
            Text(review.username)
                .font(.title3)
            Text(review.comment)
        }
        .padding(.horizontal,10)
    }
}

struct ReviewEditorView : View {
    var reviewVM : ReviewViewModel
    @State var review : Review
    var isNew : Bool
    @State var showingAlert : Bool = false
    
    var body: some View{
        VStack (alignment: .trailing){
            if !isNew{
                Button(action: {
                    self.showingAlert = true
                    
                }, label: {
                    Image(systemName: "trash")
                })
                .frame(alignment: .trailing)
                .alert(isPresented:$showingAlert) {
                    Alert(title: Text("Are you sure you want to delete this?"),
                          message: Text("There is no undo"),
                          primaryButton: .destructive(Text("Delete")) {
                        print("Deleting...")
                            reviewVM.deleteReview(self.review)
                    }, secondaryButton: .cancel())
                    
                }
            }
                TextField( "some tips?", text: self.$review.comment)
                if review.comment != ""{
                    Button(action : {reviewVM.updateReview(self.review)}){
                        Text("Save")
                            .foregroundColor(.blue)
                    }
                }
            }
            .padding(.horizontal, 10)
        }
    }
