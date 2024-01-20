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
  @StateObject var splitsViewModel = SplitsViewModel() // StateObject for your ViewModel
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
                    
                    SplitsLandingPageView()
                        .tabItem {
                            Label("Splits Landing", systemImage: "house.fill")
                        }
                        .tag(1)
                        .environmentObject(splitsViewModel)
                    
                    ExercisesListView()
                        .tabItem {
                            Label("Exercises", systemImage: "list.bullet.clipboard")
                        }
                        .tag(2)
                        .environmentObject(viewModel)
                }
                .navigationBarItems(trailing: addButton)  // Use the addButton view here
                .sheet(isPresented: $showingAddExerciseView) {
                    AddExerciseView().environmentObject(viewModel)
                }
            }
            .onAppear {
                        viewModel.fetch() // Fetch exercises when ContentView appears
                    }
                    .environmentObject(viewModel) // Provide ViewModel as an environment object
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
