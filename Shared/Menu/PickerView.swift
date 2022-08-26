//
//  PickerView.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 26.08.2022.
//

import SwiftUI

struct PickerView: View {

    @State var selectedItem: Languages
    var items: [Languages]
    var titleKeyPath: KeyPath<Languages, String>
    var onItemSelected: (Languages) -> Void

    var body: some View {
        List {
            ForEach(items, id: \.self) { item in
                Button {
                    itemSelected(item: item)
                } label: {
                    HStack {
                        Text(LocalizedStringKey(item[keyPath: titleKeyPath]))
                            .foregroundColor(Color("colors/text"))
                            .tag(item)
                        if item == selectedItem {
                            Spacer()
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
        }
    }

    private func itemSelected(item: Languages) {
        withAnimation {
            selectedItem = item
        }
        onItemSelected(item)
    }
}

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        PickerView(
            selectedItem: Languages.uk,
            items: Languages.allCases,
            titleKeyPath: \.title)  { _ in }
    }
}

