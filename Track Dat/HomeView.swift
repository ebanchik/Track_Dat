//
//  HomeView.swift
//  Track Dat
//
//  Created by Eli Banchik on 12/22/23.
//

import SwiftUI

    struct HomeView: View {
    var body: some View {
        VStack {
            Text("Programs")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
                .offset(y:20)
            Spacer()
                
        }
    }
}

struct HomeView_Previews: PreviewProvider {
static var previews: some View {
    HomeView()
}
}
