//
//  ImageCrop.swift
//  Instagram Story
//
//  Created by Tran Doan Dang Khoa on 21/01/2021.
//  Copyright © 2021 Balaji. All rights reserved.
//

import Foundation
import SwiftUI

extension Image {
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
            .resizable()
            .scaledToFill()
            .frame(width: geo.size.width, height: geo.size.height)
            .clipped()
        }
    }
}
