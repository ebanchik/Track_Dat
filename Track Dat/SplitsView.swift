//
//  SplitsView.swift
//  Track Dat
//
//  Created by Eli Banchik on 12/24/23.
//

import Foundation
import SwiftUI

struct Upper1: Codable, Identifiable, Hashable {
  var id: Int
  var name: String
  var sets: Int
  var reps: String
  var break_t: String?
  var style: String
}


class SplitsViewModel: ObservableObject {
    @Published var upper1: [Upper1] = []
    @Published var upper2: [Upper1] = []
    @Published var upper3: [Upper1] = []
    @Published var upper4: [Upper1] = []
    @Published var isLoading = false
    
    func fetchUpper1() {
        isLoading = true
        guard let url = URL(string: "http://localhost:3000/upper1.json") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self]data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let exercises = try JSONDecoder().decode([Upper1].self, from: data)
                DispatchQueue.main.async {
                    self?.upper1 = exercises
                }
            }
            catch {
                print(error)
            }
        }
        
        task.resume()
        isLoading = false
    }
    
    struct SplitsView: View {
        @ObservedObject var SplitsviewModel: SplitsViewModel
        
        var body: some View {
            NavigationView {
                VStack {
                    Text("Upper1")
                        .font(.largeTitle)
                        .padding()
                    List(SplitsviewModel.upper1, id: \.self) { upper1 in
                        VStack(alignment: .leading) {
                            Text("Name: \(upper1.name)")
                            Text("Sets: \(upper1.sets)")
                            Text("Reps: \(upper1.reps)")
                            Text("Break Time: \(upper1.break_t ?? "Default Value")")
                            Text("Style: \(upper1.style)")
                        }
                        .padding()
                    }
                    
                    // Similar blocks for upper2, upper3, and upper4
                }
                .navigationTitle("Splits")
                .onAppear {
                    SplitsviewModel.fetchUpper1()
                    // Call other fetch functions
                }
            }
        }
    }
    
    struct SplitsView_Previews: PreviewProvider {
        static var previews: some View {
            SplitsView(SplitsviewModel: SplitsViewModel())
        }
    }
}
