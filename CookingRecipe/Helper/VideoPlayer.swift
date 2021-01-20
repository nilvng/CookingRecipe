//
//  VideoPlayer.swift
//  Cloud
//
//  Created by Nil Nguyen on 12/31/20.
//  Copyright © 2020 Balaji. All rights reserved.
//

import Foundation
import AVKit
import SwiftUI

struct VideoPlayer : UIViewControllerRepresentable {
    
    var urlString : String
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<VideoPlayer>) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        let player = AVPlayer(url: URL(string: urlString)!)
        controller.player = player
        return controller
        
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: UIViewControllerRepresentableContext<VideoPlayer>) {
        
    }
    
}
