//
//  Browser.swift
//  CookingRecipe
//
//  Created by Nil Nguyen on 12/12/20.
//
import Foundation
import SwiftUI
import WebKit

struct WebView : UIViewRepresentable {
    var url : String
    
    func makeUIView(context: Context) -> WKWebView{
        guard let url = URL(string: self.url) else {
            return WKWebView()
        }
        let request = URLRequest(url: url)
        let wkWebView = WKWebView()
        wkWebView.load(request)
        return wkWebView
    }
    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<WebView>) {
    }
}
