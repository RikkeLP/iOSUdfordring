//
//  iOSUdfordringApp.swift
//  iOSUdfordring
//
//  Created by dmu mac 26 on 09/10/2023.
//

import SwiftUI

@main
struct iOSUdfordringApp: App {
    var body: some Scene {
        WindowGroup {
            StartQuizView().environmentObject(CategoryController())
        }
    }
}
