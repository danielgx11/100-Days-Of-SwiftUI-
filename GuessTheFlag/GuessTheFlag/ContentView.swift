//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Daniel Gomes on 22/05/21.
//

import SwiftUI

struct ContentView: View {

    // MARK: - Properties
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    private var randomNumber: Int {
        Int.random(in: 0...2)
    }

    // MARK: - Life Cycle
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack(spacing: 16) {
                    Text("Tap the flag of").bold()
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                    ForEach(0 ..< 3) { number in
                        Button(action: {
                            self.didTapFlag(withNumber: number)
                        }) {
                            Image(self.countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                                .shadow(color: .black, radius: 2)
                        }
                    }
                    Spacer()
                }
            }
            .alert(isPresented: $showingScore) {
                Alert(title: Text(scoreTitle), message: Text("Your score is ???"), dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                })
            }
        }
    }
}

// MARK: - Methods
extension ContentView {
    
    private func didTapFlag(withNumber number: Int) {
        scoreTitle = number == correctAnswer ? "Correct" : "Wrong"
        showingScore = true
    }

    private func askQuestion() {
        countries.shuffle()
        correctAnswer = randomNumber
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
