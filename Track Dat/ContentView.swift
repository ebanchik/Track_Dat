//
//  ContentView.swift
//  Track Dat
//
//  Created by Eli Banchik on 12/22/23.
//

import Foundation
import SwiftUI

struct PlaceholderView: View {
   var body: some View {
       VStack {
           Text("Loading...")
               .font(.largeTitle)
               .padding()

           ProgressView()
       }
   }
}

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    @StateObject var splitsViewModel = SplitsViewModel()
    @State private var selectedTab = 0
    @State private var selectedSplit = 0
    @State private var showingAddExerciseView = false

    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "gym.bag.fill")
                            
                    }
                    .tag(0)
                    .navigationBarTitle("Home", displayMode: .inline)
                    .navigationBarHidden(false)

                SplitsLandingPageView()
                    .tabItem {
                        Label("Splits Landing", systemImage: "house.fill")
                    }
                    .tag(1)
                
                    .environmentObject(splitsViewModel)
                    .navigationBarTitle("Splits Landing", displayMode: .inline)
                    .navigationBarHidden(false)

                ExercisesListView()
                    .tabItem {
                        Label("Exercises", systemImage: "list.bullet.clipboard")
                    }
                    .tag(2)
                    .environmentObject(viewModel)
                    .navigationBarTitle("Exercises", displayMode: .inline)
                    .navigationBarHidden(false)
            }
            Color.black
            .navigationBarItems(trailing: addButton)
            .sheet(isPresented: $showingAddExerciseView) {
                AddExerciseView().environmentObject(viewModel)
            }
        }
        .onAppear {
            viewModel.fetch()
        }
        .environmentObject(viewModel)
        
    }

    
        // Define the addButton as a computed property
        private var addButton: some View {
            Group {
                if selectedTab == 2 {  // Check if the current tab is the Exercises tab
                    Button(action: {
                        showingAddExerciseView = true
                    }) {
                        Image(systemName: "plus.circle")
                    }
                }
            }
        }
    }


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
      ContentView()
          .environmentObject(SplitsViewModel()) // Providing the environmentObject for the preview
          .environmentObject(ViewModel()) // Adding this line
  }
}
