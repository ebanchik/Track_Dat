import Foundation
import SwiftUI

struct SplitsLandingPageView: View {
    @EnvironmentObject var splitsViewModel: SplitsViewModel
    @EnvironmentObject var viewModel: ViewModel

    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground) // Retaining your background color
                .ignoresSafeArea()

            VStack {
                Text("Current Split")
                    .font(.largeTitle).bold()
                    .padding()

                List {
                    NavigationLink(destination: Upper1ListView().environmentObject(splitsViewModel)) {
                        Text("Upper 1").bold()
                            .font(.system(size: 20))
                    }

                    NavigationLink(destination: Upper2ListView().environmentObject(splitsViewModel)) {
                        Text("Upper 2").bold()
                            .font(.system(size: 20))
                    }

                    NavigationLink(destination: ShouldersListView().environmentObject(splitsViewModel)) {
                        Text("Shoulders").bold()
                            .font(.system(size: 20))
                    }

                    NavigationLink(destination: LegsListView().environmentObject(splitsViewModel)) {
                        Text("Legs").bold()
                            .font(.system(size: 20))
                    }
                }
                .offset(y: -30) // Keeping your offset style
            }
        }
    }
}
