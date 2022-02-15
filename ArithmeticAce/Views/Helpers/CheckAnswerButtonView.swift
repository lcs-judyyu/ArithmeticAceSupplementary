//
//  CheckAnswerButtonView.swift
//  ArithmeticAce
//
//  Created by Judy Yu on 2022-02-14.
//

import SwiftUI

struct CheckAnswerButtonView: View {
    
    //MARK: Stored Properties
    //These properties stay the same (constant)
    @Binding var answerChecked: Bool
    @Binding var answerCorrect: Bool
    @Binding var inputGiven: String
    var correctAnswer: Int
    
    //MARK: Computed Properties
    
    
    var body: some View {
        Button(action: {
            
            // Answer has been checked!
            answerChecked = true
            
            // Convert the input given to an integer, if possible
            guard let answerGiven = Int(inputGiven) else {
                // Sadness, not a number
                answerCorrect = false
                return
            }
            
            // Check the answer!
            if answerGiven == correctAnswer {
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
    }
}

struct CheckAnswerButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CheckAnswerButtonView(answerChecked: .constant(true),
                              answerCorrect: .constant(true),
                              inputGiven: .constant("20"),
                              correctAnswer: 20)
    }
}
