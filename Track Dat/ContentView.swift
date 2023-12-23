//
//  ContentView.swift
//  Track Dat
//
//  Created by Eli Banchik on 12/22/23.
//

import Foundation
import SwiftUI

struct Exercise: Hashable, Codable {
    let name: String
    let sets: Int
    let reps: String
    let break_t: String?
    let style: String
    
}

class ViewModel: ObservableObject {
    @Published var exercises: [Exercise] = []
    @Published var isLoading = false
    
    func fetch() {
        isLoading = true
        guard let url = URL(string:
            "http://localhost:3000/exercises.json") else {
                return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self]data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let exercises = try JSONDecoder().decode([Exercise].self, from: data)
                DispatchQueue.main.async {
                    self?.exercises = exercises
                }
            }
            catch {
                print(error)
            }
        }
        
        task.resume()
        isLoading = false
    }
}

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
           NavigationView {
               Group {
                   if viewModel.isLoading {
                      ProgressView()
                   } else {
                      List(viewModel.exercises, id: \.self) { exercise in
                          HStack {
                              Text(exercise.name)
                                  .bold()
                          }
                          .padding(3)
                      }
                      .navigationTitle("Exercises")
                      .onAppear {
                          viewModel.fetch()
                      }
                   }
    
    
//    @StateObject var viewModel = ViewModel()
//    
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(viewModel.exercises, id: \.self) { exercise in
//                    HStack {
//                        Text(exercise.name)
//                            .bold()
//                    }
//                    .padding(3)
//                }
//            }
//            .navigationTitle("Exercises")
//            .onAppear {
//                viewModel.fetch()
            }
        }
    }
}
//        TabView {
//            HomeView()
//                .tabItem {
//                    Label("Home", systemImage: "person")
//                }
//            
//        }
//    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
    }
}
