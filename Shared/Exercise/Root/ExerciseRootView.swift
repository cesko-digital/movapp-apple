//
//  ExerciseRootView.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 26.05.2023.
//

import SwiftUI

struct ExerciseRootView<ViewModel: ExerciseRootViewModeling>: View {

    @StateObject var viewModel: ViewModel

    var body: some View {
        Text("Hello, World!")
    }
}

struct ExerciseRootView_Previews: PreviewProvider {

    class MockViewModel: ExerciseRootViewModeling {

    }

    static var previews: some View {
        ExerciseRootView(viewModel: MockViewModel())
    }
}
