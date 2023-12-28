import Foundation
import SwiftUI

struct SplitsLandingPageView: View {
 @State private var selectedSplit: Splits = .upper1

 var body: some View {
     VStack {
         Text("Select a split")
             .font(.largeTitle)
             .padding()

         HStack {
             Button(action: {
               self.selectedSplit = .upper1
             }) {
               Text("Upper 1")
                  .padding()
                  .background(Color.blue)
                  .foregroundColor(.white)
                  .cornerRadius(10)
             }
             
             Button(action: {
               self.selectedSplit = .upper2
             }) {
               Text("Upper 2")
                  .padding()
                  .background(Color.blue)
                  .foregroundColor(.white)
                  .cornerRadius(10)
             }
         }

         HStack {
             Button(action: {
               self.selectedSplit = .shoulders
             }) {
               Text("Shoulders")
                  .padding()
                  .background(Color.blue)
                  .foregroundColor(.white)
                  .cornerRadius(10)
             }
             
             Button(action: {
               self.selectedSplit = .legs
             }) {
               Text("Legs")
                  .padding()
                  .background(Color.blue)
                  .foregroundColor(.white)
                  .cornerRadius(10)
             }
         }
         
         // Use a switch statement to present the correct view based on the selectedSplit variable
         switch selectedSplit {
         case .upper1:
             Text("Upper 1 Exercises")
                 .font(.system(size:24))
                .padding()
             Upper1ListView()
         case .upper2:
             Text("Upper 2 Exercises")
                 .font(.system(size:24))
                .padding()
             Upper2ListView()
         case .shoulders:
             Text("Shoulders Exercises")
                 .font(.system(size:24))
                .padding()
             ShouldersListView()
         case .legs:
             Text("Legs Exercises")
                 .font(.system(size:24))
                .padding()
             LegsListView()
         default:
             EmptyView()
         }
     }
 }
}
