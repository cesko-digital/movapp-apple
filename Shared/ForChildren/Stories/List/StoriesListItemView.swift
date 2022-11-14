//
//  ForChildrenRootStoryView.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 05.11.2022.
//

import SwiftUI

struct StoriesListItemView: View {
    let item: StoriesSectionItem
    let selectedLanguage: SetLanguage

    var body: some View {
        NavigationLink {
            StoryView(viewModel: StoryViewModel(metadata: item,
                                                selectedLanguage: selectedLanguage))
                .navigationTitle(item.title)
                .navigationBarTitleDisplayMode(.inline) // TODO: check if it doesn't make any issue
        } label: {
            ZStack(alignment: .bottomTrailing) {
                HStack(spacing: 0) {
                    Image(item.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                        .padding(.leading, 12)
                        .padding(.trailing, 6)
                        .frame(width: 198, height: 140)

                    VStack(alignment: .leading, spacing: 6) {
                        Text(item.title)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(Color("colors/primary"))
                        Text(item.subtitle)
                            .font(.body)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.gray)
                        Text(item.duration)
                            .font(.footnote)
                            .foregroundColor(.black)
                    }
                    .padding(.leading, 6)

                    Spacer()
                }

                SoundStateButtonView(isPlaying: false, onTap: { })
                    .padding(12)
            }
            .background(Color.white)
            .cornerRadius(10)
        }
    }
}

struct StoriesListItemView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            StoriesListItemView(item: .mock(), selectedLanguage: .csUk)
        }
        .frame(width: 390, height: 800)
        .background(Color("colors/item"))
    }
}
