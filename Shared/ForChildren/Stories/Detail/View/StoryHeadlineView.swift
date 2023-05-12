//
//  StoryHeadlineView.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 12.11.2022.
//

import SwiftUI

struct StoryHeadlineView: View {

    let content: StoryHeadline

    var body: some View {
        HStack(spacing: 0) {
            Image(content.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
                .padding(.leading, 12)
                .padding(.trailing, 6)
                .frame(maxWidth: 110)

            VStack(alignment: .leading, spacing: 6) {
                Text(content.title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color("colors/primary"))
                Text(content.subtitle)
                    .font(.body)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.gray)
            }
            .padding(.leading, 6)
        }
    }
}

struct StoryHeadlineView_Previews: PreviewProvider {
    static var previews: some View {
        StoryHeadlineView(content: .init(image: "stories/cervena-karkulka/thumbnail",
                                         title: "O perníkové chaloupce",
                                         subtitle: "Прянична хатинка"))
    }
}
