//
//  RecipeCardView.swift
//  CanCookHomePage
//
//  Created by Tran Doan Dang Khoa on 02/12/2020.
//
import SwiftUI

struct RecipeCardView: View {
  // MARK: - PROPERTIES
    @State private var showDetails = false
  var recipe: Recipe
  var hapticImpact = UIImpactFeedbackGenerator(style: .heavy)
  @State private var showModal: Bool = false
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      // CARD IMAGE
        Image(recipe.media["photo"] ?? "dalgona_coffee")
        .resizable()
        .scaledToFit()
        .overlay(
          HStack {
            Spacer()
            VStack {
              Image(systemName: "bookmark")
                .font(Font.title.weight(.light))
                .foregroundColor(Color.white)
                .imageScale(.small)
                .shadow(color: Color.black, radius: 2, x: 0, y: 0)
                .padding(.trailing, 20)
                .padding(.top, 22)
              Spacer()
            }
          }
        )
      
      VStack(alignment: .leading, spacing: 12) {
        // TITLE
        Text(recipe.title)
          .font(.system(.title, design: .serif))
          .fontWeight(.bold)
            .foregroundColor(Color.blue)
          .lineLimit(1)
        
        // HEADLINE
        Text("By \(recipe.owner)")
          .font(.system(.body, design: .serif))
          .foregroundColor(Color.gray)
          .italic()

        // RATING
//        RecipeRatingView(recipe: recipe)
        
        // COOKING
        RecipeCookingView(recipe: recipe)
//        Button(action: {
//                        self.showDetails.toggle()
//                    }) {
//            Image(systemName: "hand.thumbsup.fill")
//                .foregroundColor(Color.yellow)
//
//                    }
        
        //
        
       
      }
      .padding()
      .padding(.bottom, 12)
    }
    .background(Color.white)
    .cornerRadius(12)
    .shadow(color: Color.black, radius: 2, x: 0, y: 0)
  }
}

struct RecipeCardView_Previews: PreviewProvider {
  static var previews: some View {
    RecipeCardView(recipe: recipesData[0])
      .previewLayout(.sizeThatFits)
  }
}

