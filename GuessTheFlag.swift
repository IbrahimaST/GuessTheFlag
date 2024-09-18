//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Ibrahima Toure on 9/16/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["France",
                         "Estonia",
                         "US",
                         "UK",
                         "Italy",
                         "Monaco",
                         "Germany",
                         "Ireland",
                         "Nigeria",
                         "Poland",
                         "Spain",
                     "Ukraine"].shuffled() // List of Countries
    @State private var correctAnswer = Int.random(in: 0...2) // Integer storing which country Image is correct
    @State private var showScore = false
    @State private var alertTitle = ""
    @State private var userScore: Int = 0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: .green, location: 0.5),
                .init(color: .red, location: 0.5),
            ],
                           center: .bottom,
                           startRadius: 100,
                           endRadius: 750)
            .ignoresSafeArea()
            
            VStack {
                Text("Guess The Flag:")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                
                Spacer()
                
                    VStack(spacing: 15) {
                        Text("Tap the flag of:")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                        
                        ForEach(0..<3) { num in
                            Button {
                                tappedFlag(num)
                                if num == correctAnswer {
                                    userScore += 1
                                } else if userScore == 0 {
                                    userScore = 0
                                } else {
                                    userScore -= 1
                                }
                            } label: {
                                Image(countries[num])
                                    .clipShape(.capsule)
                                    .shadow(radius: 5)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(.rect(cornerRadius: 20))
                    .padding(.horizontal, 20)
                
                Spacer()
                Spacer()
                
                Text("Score: \(userScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
            .alert(alertTitle, isPresented: $showScore) {
                Button("Move On", action: {
                    askUserAQuestion()
                })
            } message: {
                Text("The correct answer was: \(countries[correctAnswer])!")
            }
        }
    }

    func tappedFlag(_ num: Int) {
        if num == correctAnswer {
            alertTitle = "Thats Correct!"
        } else {
            alertTitle = "Wrong! Thats the flag of \(countries[num])!"
        }
        
        showScore = true
    }
    
    func askUserAQuestion() {
        countries.shuffle() // Different from .shuffled() as it shuffles the list in place.
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
