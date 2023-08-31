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
            languageButton(languages: content.languages)
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

    func languageButton(languages: (selected: Languages, second: Languages)) -> some View {
            Button {
                buttonAction(.language(selected: languages.second))
            } label: {
                ZStack {
                    flagView(flag: languages.second.flag)
                        .padding(.trailing, 20)
                    flagView(flag: languages.selected.flag)
                }
            }
            .padding(.bottom, 8)
            .padding(.trailing, 8)
    }

    private func flagView(flag: Flags) -> some View {
        Image("icons/flags/\(flag.rawValue)")
            .resizable()
            .frame(width: 25, height: 25)
            .clipShape(Circle())
            .shadow(radius: 8)
            .overlay(Circle().stroke(Color.black.opacity(0.5), lineWidth: 1))
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
                                  languages: (selected: .cs, second: .uk))) { _ in }

        PlayerView(content: .init(timer: .init(currentTime: 30, maxTime: 180),
                                  state: .playing,
                                  languages: (selected: .uk, second: .cs))) { _ in }
    }
}
