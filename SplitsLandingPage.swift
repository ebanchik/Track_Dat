import Foundation
import SwiftUI

struct SplitsLandingPageView: View {
 @State private var selectedSplit: Splits = .upper1


 var body: some View {
    ZStack {
        Color(UIColor.systemGroupedBackground) // Change this to your desired color
            .ignoresSafeArea()
        
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
                    .background(Color.white)
                    .foregroundColor(.blue)
                    .cornerRadius(10)
                }
                
                Button(action: {
                 self.selectedSplit = .upper2
                }) {
                 Text("Upper 2")
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.blue)
                    .cornerRadius(10)
                }
            }

            HStack {
                Button(action: {
                 self.selectedSplit = .shoulders
                }) {
                 Text("Shoulders")
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.blue)
                    .cornerRadius(10)
                }
                
                Button(action: {
                 self.selectedSplit = .legs
                }) {
                 Text("Legs")
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.blue)
                    .cornerRadius(10)
                }
            }
            
            // Use a switch statement to present the correct view based on the selectedSplit variable
            switch selectedSplit {
            case .upper1:
                Text("Upper 1 Exercises")
                  .font(.system(size:24))
                 .padding()
                 .offset(y:20)
                 .underline()
                Upper1ListView()
            case .upper2:
                Text("Upper 2 Exercises")
                  .font(.system(size:24))
                 .padding()
                 .underline()
                Upper2ListView()
            case .shoulders:
                Text("Shoulders Exercises")
                  .font(.system(size:24))
                 .padding()
                 .underline()
                ShouldersListView()
            case .legs:
                Text("Legs Exercises")
                  .font(.system(size:24))
                 .padding()
                 .underline()
                LegsListView()
            default:
                EmptyView()
            }
        }
    }
 }
}
