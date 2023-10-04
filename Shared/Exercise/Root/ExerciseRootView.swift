//
//  ExerciseRootView.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 26.05.2023.
//

import Combine
import SwiftUI

struct ExerciseRootView<ViewModel: ExerciseRootViewModeling>: View {

    @StateObject var viewModel: ViewModel
    @State private var selectedSize: Int = 10

    var body: some View {
        Group {
            switch viewModel.state {
            case .error:
                errorState
            case .loading:
                loadingState
            case let .loaded(content):
                loadedContent(for: content)
            }
        }
    }

    private func loadedContent(for content: ExerciseRootContent) -> some View {
        VStack {
            Text("exercise.configuration.title")
                .font(.title2)

            Text("exercise.configuration.categories")
                .font(.title3)
                .padding(.vertical)

            let gridLayout = [GridItem(.adaptive(minimum: 100))]

            LazyVGrid(columns: gridLayout) {
                ForEach(Array(content.categories.enumerated()), id: \.offset) { _, item in
                    Button(item.name) {
                        viewModel.selectCategory(id: item.id)
                    }
                    .buttonStyle(CategoryButtonStyle(selected: item.selected))
                }
            }
            .padding(.vertical)

            Text("exercise.configuration.size")
                .font(.title3)

            HStack {
                HStack(spacing: 16) {
                    ForEach(content.configuration.sizeList, id: \.self) { size in
                        HStack {
                            RadioButton(isSelected: selectedSize == size)
                            Text("\(size)")
                        }
                        .onTapGesture {
                            withAnimation { selectedSize = size }
                        }
                    }
                }
            }
            .padding()

            Button("exercise.configuration.startButton") {
                // TODO: start the flow
                print("start")
            }
            .buttonStyle(.borderedProminent)
            .tint(Color("colors/primary"))
            .padding(.top, 16)
            .disabled(content.categories.contains(where: { $0.selected }) == false)
        }
        .padding()

        .onAppear {
            selectedSize = content.configuration.sizeDefault
        }
    }

    private var loadingState: some View {
        VStack {
            Text("Loading...")
        }
        .onAppear(perform: viewModel.viewAppeared.send)
    }

    private var errorState: some View {
        VStack {
            Text("Error")
        }
    }
}

struct ExerciseRootView_Previews: PreviewProvider {

    class MockViewModel: ExerciseRootViewModeling {
        let state: ExerciseRootState
        let viewAppeared = PassthroughSubject<Void, Never>()

        init(state: ExerciseRootState) {
            self.state = state
        }

        func selectCategory(id: String) { }
        func selectSize(_ size: Int) { }
    }

    static var previews: some View {
        ExerciseRootView(viewModel: MockViewModel(state: .loading))
            .previewDisplayName("Loading")

        ExerciseRootView(viewModel: MockViewModel(state: .error))
            .previewDisplayName("Error")

        ExerciseRootView(
            viewModel: MockViewModel(
                state: .loaded(
                    .init(
                        categories:
                            [
                                .init(id: "id1", name: "Category1", selected: true),
                                .init(id: "id2", name: "Category2", selected: false),
                                .init(id: "id3", name: "Category3", selected: false),
                                .init(id: "id4", name: "Category4", selected: false),
                                .init(id: "id5", name: "Category5", selected: false)
                            ],
                        configuration: .init(sizeList: [10, 20, 30], sizeDefault: 10))
                )
            )
        )
        .previewDisplayName("Configuration")
    }
}
