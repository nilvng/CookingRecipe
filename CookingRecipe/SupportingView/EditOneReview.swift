//
//  EditOneReview.swift
//  CookingRecipe
//
//  Created by Minh Anh Tran 2 on 06/01/2021.
//

import SwiftUI
import Firebase
import Resolver

struct EditOneReview: View, Equatable {
    // let recipe : RecipeViewModel
    // let recipeId: String
    
    @AppStorage("reviewPath") public static var reviewPath : String = ""
    public static let dummyPath = "Recipe/VqJyajgojRKVjENBkusa/review"
    var exist: Bool
    
    init(exist: Bool) {
        self.exist = exist
    }
    
    var body: some View {
        Group {
            Text(ReviewRepository.shared.recipeId!)
            EditOneReviewHome(exist: exist)
        }
        .onAppear(perform: myFunc)
    }
    
    func myFunc() {
        Self.reviewPath = ReviewRepository.shared.recipeId! != "" ? "Recipe/\(ReviewRepository.shared.recipeId!)/review" : Self.dummyPath
        print("Init myFunc: \(Self.reviewPath)")
        
    }
}


struct EditOneReviewHome: View {
    @State var x : CGFloat = 0
    @State var count : CGFloat = 0
    @State var screen = UIScreen.main.bounds.width - 30
    @State var op : CGFloat = 0
    //     @State var data : [Recipe] = recipesData
    @Injected var authService : AuthenticationService
    @StateObject var reviewData = getReviews()
    // @StateObject var reviewData = ReviewManager.shared.reviewData
    
    var exist: Bool
    init(exist: Bool) {
        self.exist = exist
    }
    var body: some View {
        if (exist) {
            Text("")
                .onAppear(perform: reviewData.loadData)
            
            VStack {
                if self.reviewData.data.isEmpty{
                    Text("Please create your new review")
                } else {
                    VStack{
                        Text("Please edit your review")
                        //                    Spacer()
                        HStack(spacing: 15){
                            //                    ScrollView(.horizontal, showsIndicators: false){
                            //                    HStack{
                            ForEach(reviewData.data){i in
                                if i.userid == authService.user!.uid {
                                    EditReview(review: i)
                                }
                            } //: FOREACH
                        }
                        .frame(width: UIScreen.main.bounds.width - 25)
                        .offset(x: self.op)
                        Spacer()
                    } //: VSTACK
                    .frame(height:300)
                    .background(Color.black.opacity(0.07).edgesIgnoringSafeArea(.bottom))
                    .animation(.spring())
                } //: ELSE
            }
        } else {
            Text("Your review has not existed, please create new one")
        }
    }
}
