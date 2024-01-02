import Foundation
import SwiftUI

struct SplitsLandingPageView: View {
 @ObservedObject var splitsViewModel = SplitsViewModel()

 var body: some View {
   ZStack {
       Color(UIColor.systemGroupedBackground) // Change this to your desired color
           .ignoresSafeArea()

       VStack {
           Text("Current Split")
               .font(.largeTitle).bold()
               .padding()

           List {
               NavigationLink(destination: Upper1ListView()) {
                   Text("Upper 1").bold()
               }

               NavigationLink(destination: Upper2ListView()) {
                  Text("Upper 2").bold()
               }

               NavigationLink(destination: ShouldersListView()) {
                  Text("Shoulders").bold()
               }

               NavigationLink(destination: LegsListView()) {
                  Text("Legs").bold()
               }
           }
           .offset(y:-30)
       }
   }
   .environmentObject(splitsViewModel)
 }
}
