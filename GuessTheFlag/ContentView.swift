//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Olea Blossom on 06.06.22.
//

import SwiftUI

struct ContentView: View {
	@State private var showingScore = false
	@State private var scoreTitle = ""
	@State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
		.shuffled()
	@State private var correctAnswer = Int.random(in: 0...2)
	var body: some View {
		ZStack {
			LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .top, endPoint: .bottom)
				.ignoresSafeArea()
			
			VStack(spacing: 30) {
				VStack {
					Text("Tap the flag of")
						.font(.subheadline.weight(.heavy))
						.foregroundColor(.white)
					Text(countries[correctAnswer])
						.font(.largeTitle.weight(.semibold))
						.foregroundColor(.white)
				}
				
				ForEach(0..<3) { number in
					Button {
						flagTapped(number)
					} label: {
						Image(countries[number])
							.renderingMode(.original)
					}
				}
			}
		}
		.alert(scoreTitle, isPresented: $showingScore) {
			Button("Continue", action: askQuestion)
		} message: {
			Text("Your score is ???")
		}
	}
	
	func flagTapped(_ number: Int) {
		if number == correctAnswer {
			scoreTitle = "You got it 😄"
		} else {
			scoreTitle = "That's not it 😵"
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
