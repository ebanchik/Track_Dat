//
//  CircleImage.swift
//  Track Dat
//
//  Created by Eli Banchik on 12/22/23.
//

import SwiftUI

struct CircleImage: View {
    var body: some View {
     Image("barbell")
            .resizable()
            .frame(width: 150, height: 150)
        .clipShape(Circle())
        .overlay {
            Circle().stroke(.black, lineWidth: 4)
        }
        .offset(y:-50)
//        .shadow(radius: 7)
    }
}

#Preview {
    CircleImage()
}
