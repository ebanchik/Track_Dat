//
//  ContentView.swift
//  Track Dat
//
//  Created by Eli Banchik on 12/22/23.
//

import Foundation
import SwiftUI


public struct SplitsView: View {
 @EnvironmentObject var splitsViewModel: SplitsViewModel
 @State private var selectedTab = 0

    public var body: some View {
      NavigationView {
          TabView(selection: $selectedTab) {
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

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    @StateObject var splitsViewModel = SplitsViewModel() // StateObject for your ViewModel
    @State private var showingDetail = false
    @State private var selectedExercise: Exercise? = nil
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)
            
//            ExercisesListView()
//                .tabItem {
//                    Label("Exercises", systemImage: "heart.fill")
//                }
//                .tag(1)
            
            SplitsView()
                .environmentObject(splitsViewModel) // Applying environmentObject here
                .tabItem {
                    Label("Splits", systemImage: "list.dash")
                }
                .tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SplitsViewModel()) // Providing the environmentObject for the preview
    }
}
