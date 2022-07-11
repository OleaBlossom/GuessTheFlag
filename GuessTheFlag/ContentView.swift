//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Olea Blossom on 06.06.22.
//

import SwiftUI

struct ContentView: View {
	@State private var scoreTitle = ""
	@State private var score = 0
	@State private var round = 0
	
	@State private var buttonsEnabled = [true, true, true]
	@State private var gameIsOver = false
	
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
				
				Text("Score: \(score)")
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
						.disabled(!buttonsEnabled[number])
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
			guard let primaryButton = alertItem.primaryButton, let secondaryButton = alertItem.secondaryButton else {
				return Alert(title: alertItem.title, message: alertItem.message, dismissButton: .default(Text("Next round!"), action: askQuestion))
			}
			return Alert(title: alertItem.title, message: alertItem.message, primaryButton: primaryButton, secondaryButton: secondaryButton)
		}
		
	}
	
	func flagTapped(_ number: Int) {
		if gameIsOver {
			self.alertItem = generateGameOverAlert(title: "Game Over!")
		} else {
			if number == correctAnswer {
				scoreTitle = "You got it 😄"
				score += 1
			} else {
				scoreTitle = "Oops! 😵"
				buttonsEnabled[number] = false
			}
			
			scoreTitle += "\nThat's the flag for \(countries[number])"
			round += 1
			
			if round < 8 {
				self.alertItem = generateRoundOverAlert(title: scoreTitle, userWonRound: number == correctAnswer)
			} else {
				gameIsOver = true
				self.alertItem = generateGameOverAlert(title: scoreTitle)
			}
		}
	}
	
	func reset() {
		score = 0
		round = 0
		gameIsOver = false
		askQuestion()
	}
	
	func askQuestion() {
		countries.shuffle()
		correctAnswer = Int.random(in: 0...2)
		buttonsEnabled = [true, true, true]
	}
	
	func generateGameOverAlert(title: String) -> AlertItem {
		return AlertItem(
			title: Text(title),
			message: Text("Your final score is \(score) of \(round)"),
			primaryButton: .default(Text("Play again!"), action: reset),
			secondaryButton: .cancel())
	}
	
	func generateRoundOverAlert(title: String, userWonRound: Bool) -> AlertItem {
		var alertItem = AlertItem(
			title: Text(scoreTitle),
			message: Text("Your score is \(score)"),
			primaryButton: .default(Text("Try a new country"), action: askQuestion))
		
		if (!userWonRound) {
			alertItem.secondaryButton = .cancel(Text("Try this country again"))
		}
		
		return alertItem
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
