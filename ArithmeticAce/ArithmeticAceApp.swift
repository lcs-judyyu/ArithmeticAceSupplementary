//
//  ArithmeticAceApp.swift
//  ArithmeticAce
//
//  Created by Russell Gordon on 2022-02-07.
//

import SwiftUI

@main
struct ArithmeticAceApp: App {
    var body: some Scene {
        WindowGroup {
            
            TabView {
                AdditionView()
                    .tabItem {
                        Image(systemName: "plus.circle")
                        Text("Add")
                    }

                SubtractionView()
                    .tabItem {
                        Image(systemName: "minus.circle")
                        Text("Subtract")
                    }
                
                MultiplicationView()
                    .tabItem {
                        Image(systemName: "multiply.circle")
                        Text("Multiply")
                    }
                
                DivisionView()
                    .tabItem {
                        Image(systemName: "divide.circle")
                        Text("Divide")
                    }
            }
        }
    }
}
