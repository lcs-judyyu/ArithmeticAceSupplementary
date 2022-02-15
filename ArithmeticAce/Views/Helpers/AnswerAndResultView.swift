//
//  AnswerAndResultView.swift
//  ArithmeticAce
//
//  Created by Judy Yu on 2022-02-14.
//

import SwiftUI

struct AnswerAndResultView: View {
    
    //MARK: Stored Properties
    //These properties stay the same (constant)
    let answerChecked: Bool
    let answerCorrect: Bool
    
    //This property needs to be modified on this view which does not create the data
    //use @Binding to create a derived value
    @Binding var inputGiven: String
    
    
    //MARK: Computed Properties
    
    var body: some View {
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
    }
}

struct AnswerAndResultView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerAndResultView(answerChecked: true,
                            answerCorrect: false,
                            inputGiven: .constant("7"))
    }
}
