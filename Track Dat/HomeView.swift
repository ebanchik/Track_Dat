//
//  HomeView.swift
//  Track Dat
//
//  Created by Eli Banchik on 12/22/23.
//

import SwiftUI

    struct HomeView: View {
    var body: some View {
        VStack(spacing: 20) {
                    VStack {
                        Text("Hello, Elias!")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .offset()

                        Text("Current Split:")
                            .font(.title3)
                            .fontWeight(.regular)
                            .foregroundColor(.black)
                    }

                    VStack(spacing: 10) {
                        Group {
                            Text("Monday:")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.green)

                            Text("Upper 1")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(.black)
                                .offset(y:-5)
                            Divider()
                                .background(Color.black)
                                .offset(y:-5)
                        
                            

                            Text("Tuesday:")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.cyan)
                                .offset(y: 10)

                            Text("Shoulders")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(.black)
                                .offset(y: 5)
                            Divider()
                                .background(Color.black)
                                .offset(y:5)
                            
                            

                            Text("Wednesday:")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.orange)
                                .offset(y: 20)

                            Text("Legs")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(.black)
                                .offset(y: 10)
                            Divider()
                                .background(Color.black)
                                .offset(y:5)
                            
                            

                            Text("Thursday:")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.mint)
                                .offset(y: 20)

                            Text("Rest")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(.black)
                                .offset(y: 10)
                            Divider()
                                .background(Color.black)
                                .offset(y:5)
                            
                            

                            Text("Friday:")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                                .offset(y: 20)

                            Text("Cardio of choice")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(.black)
                                .offset(y: 10)
                            Divider()
                                .background(Color.black)
                                .offset(y:5)
                            
                            

                            Text("Saturday:")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.yellow)
                                .offset(y: 20)

                            Text("Rest")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(.black)
                                .offset(y: 10)
                            Divider()
                                .background(Color.black)
                                .offset(y:5)
                            
                            

                            Text("Sunday:")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.purple)
                                .offset(y: 15)

                            Text("Rest")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(.black)
                                .offset(y: 5)
                        }
                    }
                    .offset(y:-15)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 20)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 1)
                            .offset(y:-8)
                    )
                }
                .padding()
                .offset(y:-20)
                
            }
        }

struct HomeView_Previews: PreviewProvider {
static var previews: some View {
    HomeView()
}
}
