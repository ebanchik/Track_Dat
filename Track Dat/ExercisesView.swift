//
//  ExercisesView.swift
//  Track Dat
//
//  Created by Eli Banchik on 12/24/23.
//

import Foundation
import SwiftUI


struct ExerciseDetailView: View {
   let exercise: Exercise

   var body: some View {
       VStack {
         Text(exercise.name)
             .font(.title)
         Text("Sets: \(exercise.sets)")
         Text("Reps: \(exercise.reps)")
         Text("Break Time: \(exercise.break_t ?? "Default Value")")
         Text("Style: \(exercise.style)")
     }
     .padding()
   }
}

struct Exercise: Hashable, Codable, Identifiable {
   let id: UUID
   let name: String
   let sets: Int
   let reps: String
   let break_t: String?
   let style: String

   enum CodingKeys: String, CodingKey {
       case id
       case name
       case sets
       case reps
       case break_t
       case style
   }

   init(from decoder: Decoder) throws {
       let container = try decoder.container(keyedBy: CodingKeys.self)
       id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
       name = try container.decode(String.self, forKey: .name)
       sets = try container.decode(Int.self, forKey: .sets)
       reps = try container.decode(String.self, forKey: .reps)
       break_t = try container.decodeIfPresent(String.self, forKey: .break_t)
       style = try container.decode(String.self, forKey: .style)
   }
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

struct ExercisesListView: View {
 @EnvironmentObject var viewModel: ViewModel
 @State private var selectedExercise: Exercise? = nil
 @State private var showingDetail = false

    public var body: some View {
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
                   if !ProcessInfo.processInfo.arguments.contains("-ui_testing") {
                     viewModel.fetch()
                   }
                }
            }
        }
        .sheet(item: $selectedExercise) { exercise in
            ExerciseDetailView(exercise: exercise)
        }
     }
     }
    }
