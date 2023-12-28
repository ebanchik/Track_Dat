//
//  ContentView.swift
//  Track Dat
//
//  Created by Eli Banchik on 12/22/23.
//

import Foundation
import SwiftUI


struct SplitsView: View {
 @EnvironmentObject var splitsViewModel: SplitsViewModel
 @Binding var selectedSplit: Int

 var body: some View {
 NavigationView {
     TabView(selection: $selectedSplit) {
         Upper1ListView()
             .tabItem {
               Label("Upper 1", systemImage: "1.square")
             }.tag(0)
         
         Upper2ListView()
             .tabItem {
               Label("Upper 2", systemImage: "2.square")
             }.tag(1)
         
         ShouldersListView()
             .tabItem {
               Label("Shoulders", systemImage: "3.square")
             }.tag(2)
         
         LegsListView()
             .tabItem {
               Label("Legs", systemImage: "4.square")
             }.tag(3)
     }
     .navigationTitle("Splits")
     .onAppear {
         print("Fetching Upper1")
         splitsViewModel.fetchUpper1()
         print("Fetching Upper2")
         splitsViewModel.fetchUpper2()
         print("Fetching Shoulders")
         splitsViewModel.fetchShoulders()
         print("Fetching Legs")
         splitsViewModel.fetchLegs()
     }
     .onReceive(splitsViewModel.$upper1) { _ in
     }
     .onReceive(splitsViewModel.$upper2) { _ in
     }
     .onReceive(splitsViewModel.$shoulders) { _ in
     }
     .onReceive(splitsViewModel.$legs) { _ in
     }
 }
 }
}

enum Splits: String, CaseIterable, Identifiable {
  case upper1 = "Upper 1"
  case upper2 = "Upper 2"
  case shoulders = "Shoulders"
  case legs = "Legs"

  var id: Self { self }
}


struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    @StateObject var splitsViewModel = SplitsViewModel() // StateObject for your ViewModel
    @State private var selectedTab = 0
    @State private var selectedSplit = 0

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
                    .environmentObject(splitsViewModel) // Pass the environment object

                ExercisesListView()
                    .tabItem {
                        Label("Exercises", systemImage: "list.bullet.clipboard")
                    }
                    .tag(2)

                SplitsView(selectedSplit: $selectedSplit)
                    .tabItem {
                        Label("Splits", systemImage: "list.dash")
                    }
                    .tag(3)
                    .environmentObject(splitsViewModel) // Pass the environment object
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
