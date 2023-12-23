//
//  ContentView.swift
//  Track Dat
//
//  Created by Eli Banchik on 12/22/23.
//

import SwiftUI

struct LaunchView: View {
    var body: some View {
        VStack(alignment: .center) {
            CircleImage()
            Text("Track Dat")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
                .offset(y:-15)
            HStack {
                Text("Finally. Tracking.")
                    .font(.subheadline)
                    .offset(y:-15)
            }
        }
        .offset(y:-15)
        .padding()
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}

