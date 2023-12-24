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
    var id = UUID()
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
