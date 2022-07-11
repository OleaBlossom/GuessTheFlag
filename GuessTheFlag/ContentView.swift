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
	@State private var scoreTotal = 0
	@State private var gamesPlayed = 0
	@State var alertItem : AlertItem?
	@State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "the UK", "the US"]
		.shuffled()
	@State private var correctAnswer = Int.random(in: 0...2)
	var body: some View {
		ZStack {
			RadialGradient(stops: [
				.init(color: Color(red: 1, green: 0.2, blue: 0.45, opacity: 0.8), location: 0.3),
				.init(color: Color(red: 0.76, green: 0.15, blue: 1, opacity: 0.4), location: 0.3),
			], center: .top, startRadius: 200, endRadius: 400)
			.ignoresSafeArea()
			
			VStack() {
				Spacer()
				Text("Guess the Flag")
					.font(.largeTitle.bold())
					.foregroundColor(.white)
								
				Text("Score: " + String(scoreTotal))
					.foregroundColor(.white)
					.font(.title.bold())
				
				Spacer()
				Spacer()
				
				VStack(spacing: 15) {
					VStack {
						Text("Tap the flag of")
							.font(.subheadline.weight(.heavy))
							.foregroundColor(.secondary)
						Text(countries[correctAnswer])
							.font(.largeTitle.weight(.semibold))
							.foregroundColor(.secondary)
					}
					
					ForEach(0..<3) { number in
						Button {
							flagTapped(number)
						} label: {
							Image(countries[number])
								.renderingMode(.original)
								.clipShape(Capsule())
								.overlay(
									Capsule(style: .circular)
										.stroke(.white, lineWidth: 4)
								)
						}
					}
				}
				.frame(maxWidth: .infinity)
				.padding(.vertical, 25)
				.background(.ultraThinMaterial)
				.clipShape(RoundedRectangle(cornerRadius: 20))
				
				Spacer()
			}
			.padding()
		}
		.alert(item: $alertItem) { alertItem in
			guard let primaryButton = alertItem.primaryButton, let secondaryButton = alertItem.secondaryButton else{
				return Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
			}
			return Alert(title: alertItem.title, message: alertItem.message, primaryButton: primaryButton, secondaryButton: secondaryButton)
		}
		
	}
	
	func flagTapped(_ number: Int) {
		if number == correctAnswer {
			scoreTitle = "You got it 😄"
			scoreTotal += 1
		} else {
			scoreTitle = "Oops! 😵"
		}
		
		scoreTitle += "\nThat's the flag for " + countries[number]
		
		showingScore = true
		gamesPlayed += 1
		
		if gamesPlayed < 8 {
			let alertMessage = Text("Your score is " + String(scoreTotal))
			self.alertItem = AlertItem(title: Text(scoreTitle), message: alertMessage, primaryButton: .default(Text("Continue"), action: askQuestion), secondaryButton: .cancel())
		} else {
			let alertMessage = Text("Your final score is " + String(scoreTotal) + " of 8")
			self.alertItem = AlertItem(title: Text(scoreTitle), message: alertMessage, primaryButton: .default(Text("Play again!"), action: {
				scoreTotal = 0
				gamesPlayed = 0
				askQuestion()
			}), secondaryButton: .cancel())
		}
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

struct AlertItem: Identifiable {
	var id = UUID()
	var title = Text("")
	var message: Text?
	var dismissButton: Alert.Button?
	var primaryButton: Alert.Button?
	var secondaryButton: Alert.Button?
}
