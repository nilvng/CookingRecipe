//
//  ChallengeDetailView.swift
//  Cloud
//
//  Created by Nil Nguyen on 1/11/21.
//  Copyright © 2021 Balaji. All rights reserved.
//

import SwiftUI
import AVKit
import Foundation

struct ChallengeView: View {
    @ObservedObject var challengeVM = ChallengeViewModel("#dailymeals")
    
    let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack{
                    Text("#dailymeals")
                        .bold()
                        .font(.title)
                    NavigationLink(destination:
                                    EditRecipeView(editRecipeVM: challengeVM.submitRecipe())){
                        Text("Submit")
                            .padding(.vertical,7)
                            .padding(.horizontal, 120)
                            .foregroundColor(.white)
                            .background(Color.green)
                            .cornerRadius(7)
                    }
                    Text("All posts")
                        .bold()
                    LazyVGrid (columns: columns, spacing: 20) {
                        ForEach(challengeVM.submission){ recipe in
                            VStack(alignment: .leading) {
                                if recipe.videoUrl != nil && recipe.videoUrl != ""{
                                    VideoPlayer(urlString: recipe.videoUrl!)
                                        .frame(minWidth: 150, idealWidth: 170, maxWidth: 180, minHeight: 200, idealHeight: 270, maxHeight: 280, alignment: .center)
                                } else if recipe.photoUrl != "" {
                                    ImageLoaderView(withURL: recipe.photoUrl)
                                }
                                
                                Text(recipe.title)
                                    .lineLimit(1)
                                Divider()
                            }
                        }
                    }
                    .padding(.horizontal)
                    Spacer()
            }
        }
        }
    }
}


struct ChallengeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView()
    }
}
