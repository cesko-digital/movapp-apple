//
//  PlayerView.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 12.11.2022.
//

import SwiftUI

struct PlayerView: View {

    let content: PlayerContent
    let buttonAction: (PlayerButton) -> Void

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack {
                timeline(content.timer.currentTime, maxTime: content.timer.maxTime)

                HStack {

                    buttonBackward

                    switch content.state {
                    case .paused, .none:
                        buttonPlay
                    case .playing:
                        buttonPause
                    }

                    buttonForward
                }
            }
            languageButton(languages: content.languages, selected: content.selectedLanguage)
        }
    }

    func timeline(_ currentTime: TimeInterval, maxTime: TimeInterval) -> some View {
        VStack {
            Slider(value: .constant(currentTime), in: 0...maxTime)
                .accentColor(Color("colors/primary"))
                .disabled(true)

            HStack {
                Text(formatTimeInterval(currentTime))
                Spacer()
                Text(formatTimeInterval(maxTime))
            }
        }
    }

    var buttonPlay: some View {
        Button {
            buttonAction(.play)
        } label: {
            Image(systemName: "play.circle.fill")
                .resizable()
                .foregroundColor(Color("colors/primary"))
                .frame(width: 56, height: 56)
        }
    }

    var buttonPause: some View {
        Button {
            buttonAction(.pause)
        } label: {
            Image(systemName: "pause.circle.fill")
                .resizable()
                .foregroundColor(Color("colors/primary"))
                .frame(width: 56, height: 56)
        }
    }

    var buttonForward: some View {
        Button {
            buttonAction(.forward)
        } label: {
            Image(systemName: "goforward.10")
                .resizable()
                .foregroundColor(Color("colors/primary"))
                .frame(width: 40, height: 40)
        }
    }

    var buttonBackward: some View {
        Button {
            buttonAction(.backward)
        } label: {
            Image(systemName: "gobackward.10")
                .resizable()
                .foregroundColor(Color("colors/primary"))
                .frame(width: 40, height: 40)
        }
    }

    func languageButton(languages: [Languages], selected: Languages) -> some View {
        HStack {
            ForEach(languages, id: \.self) { item in
                Button("\(item.flag.rawValue) \(item == selected ? "✅" : "")") {
                    buttonAction(.language(selected: item))
                }
            }
        }
    }

    private func formatTimeInterval(_ value: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.second, .minute]

        return formatter.string(from: value) ?? "h: \(value)"
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(content: .init(timer: .init(currentTime: 0, maxTime: 180),
                                  state: .paused,
                                  languages: [.cs, .uk],
                                  selectedLanguage: .cs)) { _ in }

        PlayerView(content: .init(timer: .init(currentTime: 30, maxTime: 180),
                                  state: .playing,
                                  languages: [.cs, .uk],
                                  selectedLanguage: .cs)) { _ in }
    }
}
