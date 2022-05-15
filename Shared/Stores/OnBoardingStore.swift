//
//  OnBoardingStore.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 07.05.2022.
//

import SwiftUI

class OnBoardingStore: ObservableObject {
    
    let userDefaultsStore: UserDefaultsStore
    
    @Published var isBoardingCompleted: Bool {
        didSet {
            userDefaultsStore.storeOnBoardingComplete(isBoardingCompleted)
            print("Set boarding state \(isBoardingCompleted)")
        }
    }
    
    init(userDefaultsStore: UserDefaultsStore) {
        self.userDefaultsStore = userDefaultsStore
        self.isBoardingCompleted = userDefaultsStore.getOnBoardingComplete()
        
        print("Boarding state \(self.isBoardingCompleted)")
        
    }
    
}
