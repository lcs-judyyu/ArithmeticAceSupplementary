//
//  SubtractionView.swift
//  ArithmeticAce
//
//  Created by Russell Gordon on 2022-02-09.
//

import SwiftUI

struct SubtractionView: View {
    
    // MARK: Stored properties
    @State var minuend = Int.random(in: 1...144)
    @State var subtrahend = 0
    
    // This string contains whatever the user types in
    @State var inputGiven = ""
    
    // Has an answer been checked?
    @State var answerChecked = false
    
    // Was the answer given actually correct?
    @State var answerCorrect = false
    
    // MARK: Computed properties
    // What is the correct difference?
    var correctDifference: Int {
        return minuend - subtrahend
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            HStack {
                Text("-")
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("\(minuend)")
                    Text("\(subtrahend)")
                }
            }
            
            Divider()
            
            HStack {
                ZStack {
                    Image(systemName: "checkmark.circle")
                        .foregroundColor(.green)
                    //        CONDITION      true  false
                        .opacity(answerCorrect == true ? 1.0 : 0.0)
                    
                    Image(systemName: "x.square")
                        .foregroundColor(.red)
                    //        CONDITION1         AND     CONDITION2         true  false
                    //       answerChecked = true     answerCorrect = false
                        .opacity(answerChecked == true && answerCorrect == false ? 1.0 : 0.0)
                }
                
                Spacer()
                
                TextField("",
                          text: $inputGiven)
                    .multilineTextAlignment(.trailing)
            }
            
            ZStack {
                
                Button(action: {
                    
                    // Answer has been checked!
                    answerChecked = true
                    
                    // Convert the input given to an integer, if possible
                    guard let differenceGiven = Int(inputGiven) else {
                        // Sadness, not a number
                        answerCorrect = false
                        return
                    }
                    
                    // Check the answer!
                    if differenceGiven == correctDifference {
                        // Celebrate! 👍🏼
                        answerCorrect = true
                    } else {
                        // Sadness, they gave a number, but it's correct 😭
                        answerCorrect = false
                    }
                }, label: {
                    Text("Check Answer")
                        .font(.largeTitle)
                })
                    .padding()
                    .buttonStyle(.bordered)
                // Only show this button when an answer has not been checked
                    .opacity(answerChecked == false ? 1.0 : 0.0)
                
                Button(action: {
                    // Generate a new question
                    minuend = Int.random(in: 1...144)
                    subtrahend = Int.random(in: 1...minuend)
                    
                    // Reset properties that track what's happening with the current question
                    answerChecked = false
                    answerCorrect = false
                    
                    // Reset the input field
                    inputGiven = ""
                }, label: {
                    Text("New question")
                        .font(.largeTitle)
                })
                    .padding()
                    .buttonStyle(.bordered)
                // Only show this button when an answer has been checked
                    .opacity(answerChecked == true ? 1.0 : 0.0)
                
            }
            
            // Reaction animation
            ZStack {
                LottieView(animationNamed: "51926-happy")
                    .opacity(answerCorrect == true ? 1.0 : 0.0)
                    .padding()

                LottieView(animationNamed: "91726-sad-guy-is-walking")
                    .opacity(answerChecked == true && answerCorrect == false ? 1.0 : 0.0)
                    .padding()
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .font(.system(size: 72))
        // Closure (block of code) will run once when the view is loaded
        .task {
            subtrahend = Int.random(in: 1...minuend)
        }
        
        
    }
}

struct SubtractionView_Previews: PreviewProvider {
    static var previews: some View {
        SubtractionView()
    }
}
