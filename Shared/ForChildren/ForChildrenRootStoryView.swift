//
//  ForChildrenRootStoryView.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 05.11.2022.
//

import SwiftUI

struct ForChildrenRootStoryView: View {
    let item: ForChildrenRootStoriesSectionItem
    let selectedLanguage: SetLanguage

    var body: some View {
        NavigationLink {
            StoryView(viewModel: StoryViewModel(slug: item.slug,
                                                selectedLanguage: selectedLanguage))
                .navigationTitle(item.title)
        } label: {
            // TODO: Finish the card
            VStack {
                Image(item.image)
                Text(item.title)
            }
        }
    }
}

struct ForChildrenRootStoryView_Previews: PreviewProvider {
    static var previews: some View {
        ForChildrenRootStoryView(item: .mock, selectedLanguage: .csUk)
    }
}
