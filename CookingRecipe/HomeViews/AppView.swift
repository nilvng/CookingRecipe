//
//  AppView.swift
//  CanCookHomePage
//
//  Created by Tran Doan Dang Khoa on 02/12/2020.
//

import SwiftUI

struct AppView: View {
  var body: some View {
    init() {
            UITabBar.appearance().backgroundColor = UIColor.blue
        }
      HomeView()
        .tabItem({
            Image(systemName: "house")
          Text("Browse")
        })
        CategoryView()
            .tabItem({
                Image(systemName: "globe")
              Text("Categories")
            })
        UserView()
            .tabItem ({
                Image(systemName: "person")
              Text("Library")
            })
        ChallengeView()
            .tabItem ({
                Image(systemName: "burst.fill")
                Text("Challenge")
            })
    }
    .edgesIgnoringSafeArea(.all)
    .accentColor(Color.primary)
  }
}

struct AppView_Previews: PreviewProvider {
  static var previews: some View {
    AppView()
  }
}
