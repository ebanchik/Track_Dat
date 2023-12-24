//
//  ContentView.swift
//  Track Dat
//
//  Created by Eli Banchik on 12/22/23.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
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
            
            
            NavigationView {
                Group {
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        List(viewModel.exercises, id: \.self) { exercise in
                            Button(action: {
                                self.selectedExercise = exercise
                                self.showingDetail = true
                            }) {
                                HStack {
                                    Text(exercise.name)
                                        .bold()
                                }
                                .padding(8)
                            }
                        }
                        .navigationTitle("Exercises")
                        .onAppear {
                            viewModel.fetch()
                        }
                    }
                }
                .sheet(item: $selectedExercise) { exercise in
                    ExerciseDetailView(exercise: exercise)
                }
            }
            .tabItem { 
                Label("Content", systemImage: "doc.text")
            }
            .tag(1)
            
                }
            }
        }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
