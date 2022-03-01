//
//  ReactionAnimationView.swift
//  ArithmeticAce
//
//  Created by Judy Yu on 2022-02-14.
//

import SwiftUI

struct ReactionAnimationView: View {
    //MARK: Stored Properties
    //These properties stay the same (constant)
    let answerChecked: Bool
    let answerCorrect: Bool
    
    //MARK: Computed Properties
    
    var body: some View {
        ZStack {
            LottieView(animationNamed: "51926-happy", selectedLoopMode: .loop)
                .opacity(answerCorrect == true ? 1.0 : 0.0)
                .padding()

            LottieView(animationNamed: "91726-sad-guy-is-walking", selectedLoopMode: .loop)
                .opacity(answerChecked == true && answerCorrect == false ? 1.0 : 0.0)
                .padding()
        }
    }
}

struct ReactionAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        ReactionAnimationView(answerChecked: true,
                              answerCorrect: true)
    }
}
