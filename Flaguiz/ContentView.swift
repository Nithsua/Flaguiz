//  ContentView.swift
//  Flaguiz
//
//  Created by Nivas Muthu M G on 27/06/21.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.green, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
            VStack {
                Text("Tap the flag of")
                    .foregroundColor(.white)
                Text(countries[correctAnswer])
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .foregroundColor(.white)
                
                VStack(spacing: 30) {
                    ForEach(0..<3) { number in
                        Button(action: {
                            self.flagTapped(number)
                        }){
                            Image(self.countries[number])
                                .renderingMode(.original)
                                .clipShape(RoundedRectangle(cornerRadius: 20.0))
                                .overlay(RoundedRectangle(cornerRadius: 20.0).stroke(Color.black, lineWidth: 1))
                                .shadow(color: .black, radius: 2)
                        }
                    }
                }
                Text("Your score is \(score)")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                Spacer()
            }
        }
        .alert(isPresented: $showingScore, content: {
            Alert(title: Text(scoreTitle), dismissButton: .default(Text("Continue")){
                self.askQuestion()
            })
        })
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong, That flag belongs to \(countries[number])"
            score -= 1
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
