//
//  MainView.swift
//  flutter_swiftui_test
//
//  Created by Konrad Feiler on 05.08.24.
//

import SwiftUI

struct MainView: View {

    var onButtonPressed: () -> Void

    var body: some View {
        VStack {
            Text("SwiftUI Test View")

            Button("Press me") {
                print("Button pressed")
                onButtonPressed()
            }
        }
        .padding()
    }
}

#Preview {
    MainView(onButtonPressed: {
        log.debug("Button pressed")
    })
}
