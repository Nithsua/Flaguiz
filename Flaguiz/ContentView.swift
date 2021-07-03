//  ContentView.swift
//  Flaguiz
//
//  Created by Nivas Muthu M G on 27/06/21.
//

import SwiftUI

struct ImageView: View {
    let imageName: String
    
    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .clipShape(RoundedRectangle(cornerRadius: 20.0))
            .overlay(RoundedRectangle(cornerRadius: 20.0).stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var angle = 0.0
    @State private var opacity = 1.0
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.green, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
            VStack {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                }
                .padding(.vertical)
                
                VStack(spacing: 50) {
                    ForEach(0..<3) { number in
                        Button(action: {
                            flagTapped(number)
                        }){
                            ImageView(imageName: self.countries[number])
                        }
                        .rotation3DEffect(.degrees(number == correctAnswer ? angle : 0), axis: (x: 0.0, y: 1.0, z: 0.0))
                        .opacity(number != correctAnswer ? opacity : 1.0)
                        .scaleEffect(number == correctAnswer ? animationAmount : 1)
                    }
                }
                Text("Your score is \(score)")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(50)
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
            withAnimation {
                angle = 360
                opacity = 0.25
            }
            scoreTitle = "Correct"
            score += 1
        } else {
            withAnimation {
                animationAmount = 1.25
            }
            scoreTitle = "Wrong, That flag belongs to \(countries[number])"
            score -= 1
        }
        showingScore = true
    }
    
    func askQuestion() {
        opacity = 1
        angle = 0
        animationAmount = 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
