//
//  SplitsView.swift
//  Track Dat
//
//  Created by Eli Banchik on 12/24/23.
//


// DATA STRUCTURES AND DECODING ----------------------------------------

    
    
    // VIEW MODEL -----------------------------------------------------------
    
   
// SplitsView.swift
//import SwiftUI

//public struct SplitsView: View {
//  @EnvironmentObject var splitsViewModel: SplitsViewModel
//  @State private var selectedUpper1: Upper1?
//  @State private var selectedUpper2: Upper2?
//
//    public var body: some View {
//      NavigationView {
//          ScrollView(.horizontal, showsIndicators: false) {
//              HStack {
//                 ForEach($splitsViewModel.upper1, id: \.self) { upper1 in
//                    NavigationLink(destination: Upper1DetailView(upper1: upper1), tag: upper1, selection: $selectedUpper1) {
//                        Text("Upper1: \(upper1.name)")
//                            .padding()
//                            .background(Color.blue)
//                            .foregroundColor(.white)
//                            .cornerRadius(10)
//                    }
//                }
//                ForEach(splitsViewModel.upper2, id: \.self) { upper2 in
//                    NavigationLink(destination: Upper2DetailView(upper2: upper2), tag: upper2, selection: $selectedUpper2) {
//                        Text("Upper2: \(upper2.name)")
//                            .padding()
//                            .background(Color.green)
//                            .foregroundColor(.white)
//                            .cornerRadius(10)
//                    }
//                }
//              }
//          }
//          .navigationTitle("Splits")
//          .onAppear {
//              print("Fetching Upper1")
//              splitsViewModel.fetchUpper1()
//              print("Fetching Upper2")
//              splitsViewModel.fetchUpper2()
//          }
//          .onReceive($splitsViewModel.$upper1) { _ in
//          }
//          .onReceive($splitsViewModel.$upper2) { _ in
//          }
//      }
//  }
//}
//
//struct SplitsView_Previews: PreviewProvider {
//   static var previews: some View {
//       SplitsView()
//   }
//}
