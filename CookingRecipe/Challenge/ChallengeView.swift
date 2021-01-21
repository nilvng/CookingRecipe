//
//  ChallengeView.swift
//  CookingRecipe
//
//  Created by Tran Doan Dang Khoa on 21/01/2021.
//

import SwiftUI

struct ChallengeView : View {
    
    @State var show = false
    @State var current : Post!
    
    @State var data = [

        Post(id: 0, name: "Mayonnaise sucks", url: "p1", seen: false, proPic: "user1", loading: false),
        Post(id: 1, name: "Can't Cook", url: "p2", seen: false, proPic: "user2", loading: false),
        Post(id: 2, name: "Pro Burrito", url: "p3", seen: false, proPic: "user3", loading: false),
        Post(id: 3, name: "Salty Captain", url: "p4", seen: false, proPic: "user4", loading: false),
        Post(id: 4, name: "Minh Anh", url: "p5", seen: false, proPic: "user5", loading: false)
    ]
    @ObservedObject var homeVM = HomeViewModel()
    
    var body: some View{
        NavigationView{
        
        ZStack{
            
            Color.black.opacity(0.05).edgesIgnoringSafeArea(.all)
            
            ZStack{
                
                VStack{
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        HStack(spacing: 22){
                            
                            Button(action: {
                                
                            }) {
                                
                                VStack(spacing: 8){
                                    
                                    ZStack(alignment: .bottomTrailing){
                                        
                                        Image("pic")
                                        .renderingMode(.original)
                                        .resizable()
                                        .frame(width: 65, height: 65)
                                        .clipShape(Circle())
                                        
                                        
                                        Image(systemName: "plus")
                                        .resizable()
                                        .frame(width: 12, height: 12)
                                        .padding(8)
                                        .background(Color.white)
                                        .clipShape(Circle())
                                        .offset(x: 6)
                                    }
                                    
                                    Text("You")
                                        .foregroundColor(.black)
                                }
                            }
                            
                            ForEach(0..<self.data.count){i in
                                
                                VStack(spacing: 8){
                                    
                                    ZStack{
                                        
                                        Image(self.data[i].proPic)
                                        .resizable()
                                        .frame(width: 65, height: 65)
                                        .clipShape(Circle())
                                        
                                        if !self.data[i].seen{
                                            
                                            Circle()
                                            .trim(from: 0, to: 1)
                                                .stroke(AngularGradient(gradient: .init(colors: [.red,.orange,.red]), center: .center), style: StrokeStyle(lineWidth: 4, dash: [self.data[i].loading ? 7 : 0]))
                                            .frame(width: 74, height: 74)
                                            .rotationEffect(.init(degrees: self.data[i].loading ? 360 : 0))
                                        }

                                    }
                                    
                                    Text(self.data[i].name)
                                        .foregroundColor(.black)
                                        .lineLimit(1)
                                }
                                .frame(width: 75)
                                .onTapGesture {
                                    
                                    withAnimation(Animation.default.speed(0.35).repeatForever(autoreverses: false)){
                                        
                                        self.data[i].loading.toggle()
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + (self.data[i].seen ? 0 : 1.2)) {
                                            
                                            self.current = self.data[i]
                                            
                                            withAnimation(.default){
                                                
                                               self.show.toggle()
                                            }
                                            
                                            self.data[i].loading = false
                                            self.data[i].seen = true
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top)
                    }

                    
                    Spacer()
                    
                }

                if self.show{
                    
                    ZStack{
                        
                        Color.black.edgesIgnoringSafeArea(.all)
                        
                        ZStack(alignment: .topLeading) {
                            
                            GeometryReader{_ in
                                
                                VStack{
                                    
                                    Image(self.current.url)
                                    .centerCropped()
                                    .edgesIgnoringSafeArea(.all)
                                }
                            }
                            
                            VStack(spacing: 15){
                                
                                Loader(show: self.$show)
                                
                                HStack(spacing: 15){
                                    
                                    Image(self.current.proPic)
                                    .resizable()
                                    .frame(width: 55, height: 55)
                                    .clipShape(Circle())
                                    
                                    Text(self.current.name)
                                        .foregroundColor(.white)
                                    
                                    Spacer()
                                    
                                }
                                .padding(.leading)
                            }
                            .padding(.top)
                        }
                    }
                    .transition(.move(edge: .trailing))
                    .onTapGesture {
                        
                        self.show.toggle()
                    }
                }
            }
        }
        .navigationBarTitle(self.show ? "" : "Challenge",displayMode: .inline)
        .navigationBarHidden(self.show ? true : false)
    }
}
    var recipe: some View{
        NavigationView{
        
        }
    }
}

struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView()
    }
}
