//
//  AppView.swift
//  CanCookHomePage
//
//  Created by Tran Doan Dang Khoa on 02/12/2020.
//

import SwiftUI
import Foundation

struct AppView: View {
    
    @State var selection = 1
  var body: some View {
    TabView(selection: $selection) {
        HomeView()
        .tabItem({
            Image(systemName: "house.fill")
          Text("Browse")
        })
        CategoryView()
            .tabItem({
                Image(systemName: "globe")
              Text("Categories")
            })
        ChallengeView()
            .tabItem({
                Image(systemName: "burst.fill")
                Text("Challenge")
            })
        UserView()
            .tabItem ({
                Image(systemName: "person.fill")
              Text("Library")
            })
    }
    .accentColor(Color.black)
    .onAppear() {
        UITabBar.appearance().barTintColor = .white
    }
    .edgesIgnoringSafeArea(.all)

  }
}
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}
struct AppView_Previews: PreviewProvider {
  static var previews: some View {
    AppView()
  }
}
