//
//  QuestionPresentationVIew.swift
//  ArithmeticAce
//
//  Created by Judy Yu on 2022-02-14.
//

import SwiftUI

struct QuestionPresentationVIew: View {
    //MARK: Stored Properties
    let operation: String
    let firstValue: Int
    let secondValue: Int
    
    //MARK: Computed Properties
    
    var body: some View {
        HStack {
            Text("\(operation)")
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("\(firstValue)")
                Text("\(secondValue)")
            }
        }
    }
}

struct QuestionPresentationVIew_Previews: PreviewProvider {
    static var previews: some View {
        QuestionPresentationVIew(operation: "+",
                                 firstValue: 5,
                                 secondValue: 11)
    }
}
