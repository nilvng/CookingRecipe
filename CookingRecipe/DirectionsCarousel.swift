//
//  DirectionsCarousel.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 11/27/20.
//

import SwiftUI

struct DirectionsCarousel: View {
    @State var index = 0
    var steps: [String]
    var body: some View {
        VStack {
            Text("\(self.index + 1) of \(steps.count)")
            TabView(selection: self.$index) {
                
                ForEach(steps.indices, id: \.self){ index in
                    ZStack {
                        StepCard(step: steps[index],
                                 index: index,
                             cindex: self.index)
                        Button("next"){
                            withAnimation{
                                self.index += 1
                            }
                        }
                        .position(x: 200, y: 700)
                    }
                    
                }
            }
            .tabViewStyle(PageTabViewStyle(
                            indexDisplayMode: .never))
            .animation(.easeOut)
            
        }
        /*.background(LinearGradient(gradient: Gradient(colors: [Color("ColorYellowLight"), Color("ColorYellowMedium")]), startPoint: .top, endPoint: .bottom))
 */
    }
}

struct DirectionsCarousel_Previews: PreviewProvider {
    static var previews: some View {
        DirectionsCarousel(steps: recipeData[0].directions)
    }
}

struct StepCard: View {
    var step: String
    var index: Int
    var cindex: Int
    var body: some View {
        VStack {
            Image("dalgona_coffee")
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 350)
            // for identifying current index....
            Text(self.step)
                .font(.title3)
                .padding(.vertical, 20)
            Spacer()
        }
        .frame(width: 380,
               height: self.index == self.cindex ?  730 : 680, alignment: .center)
        .background(Color.white)
        .clipped()
        .shadow(color: .secondary ,radius: 10 )
        /* .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.orange, lineWidth: 3)
        ) */
        .tag(index)
    }
}
