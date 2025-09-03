//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Siddarth Bhura on 03/09/25.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var score = 0
    
    @State private var numberOfQuestions = 1
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(spacing: 15) {
                Spacer()
                VStack {
                    Text("Tap the flag of")
                        .foregroundStyle(.white)
                        .font(.subheadline.weight(.heavy))
                    Text(countries[correctAnswer])
                        .foregroundStyle(.white)
                        .font(.largeTitle.weight(.semibold))
                }
                ForEach(0..<3) { number in
                    Button {
                        if numberOfQuestions < 8 {
                            flagTapped(number)
                        } else {
                            showingScore = true
                            scoreTitle = "Game Over"
                            scoreMessage = "Your score is \(score)"
                        }
                    } label: {
                        Image(countries[number])
                            .clipShape(.capsule)
                            .shadow(radius: 5)
                    }
                }
                Spacer()
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button(numberOfQuestions < 8 ? "Continue" : "Restart", action: numberOfQuestions < 8 ? askQuestion : restartGame)
        }
        message: {
            Text(scoreMessage)
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            scoreMessage = "Your score is \(score)"
        } else {
            scoreTitle = "Wrong"
            scoreMessage = "That's the flag of \(countries[number])"
        }
        
        showingScore = true
        numberOfQuestions += 1
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func restartGame() {
        score = 0
        numberOfQuestions = 1
        askQuestion()
    }
}

#Preview {
    ContentView()
}
