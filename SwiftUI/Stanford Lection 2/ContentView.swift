//
//  ContentView.swift
//  Memorize
//
//  Created by Никита Волков on 25.12.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var emojis = ["👻", "🎃", "🕷️", "👿", "👻", "🎃", "🕷️", "👿",
                         "🕸️", "🕸️", "🧟", "🧟", "🧛‍♀️", "🧛‍♀️", "⛄️", "⛄️",
                         "🦇", "🦇", "🐦‍⬛", "🐦‍⬛"].shuffled()
    @State var selectedTheme = "Halloween"
    let themeEmojis = [
        "Halloween" : ["👻", "🎃", "🕷️", "👿", "🕸️", "🧟", "🧛‍♀️", "⛄️", "🦇", "🐦‍⬛"],
        "Vehicles"  : ["🏎️", "🚑", "🚔", "🚙", "🚕", "🚎", "🚓", "🚒", "🛻", "🚚"],
        "Sport"     : ["⛷️", "🤾‍♀️", "🥊", "🏀", "⚽️", "🏈", "⚾️", "🎾", "🏐", "🥋"]
    ]
    
    var body: some View {
        VStack {
            title
            ScrollView {
                cards
            }
            Spacer()
            themeButtons
        }
        .padding()
    }
    
    var title: some View {
        Text("Memorize!")
            .font(.largeTitle)
            .fontWeight(.bold)
    }
    
    var cards: some View {
        let themeColor: [String: Color] = [
            "Halloween" : .orange,
            "Vehicles"  : .red,
            "Sport"     : .green
        ]
        
        return LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) { // // Сетка со столбцами GridItem
            ForEach(0..<emojis.count, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(themeColor[selectedTheme]!)
    }
    
    var themeButtons: some View {
        HStack {
            Spacer()
            halloweenTheme
            Spacer()
            vehiclesTheme
            Spacer()
            sportTheme
            Spacer()
        }
    }
    
    func selectTheme(_ theme: String) -> some View {

        let imageNames = [
            "Halloween" : "door.left.hand.open",
            "Vehicles"  : "car",
            "Sport"     : "figure.run"
        ]
        
        return Button(action: {
            selectedTheme = theme
            emojis = {
                let themeEmoji = themeEmojis[theme]!.shuffled()
                let randomNumber = Int.random(in: 1..<10)
                let resultArray = Array(themeEmoji[...randomNumber] + themeEmoji[...randomNumber]).shuffled()
                return resultArray
            }()
        }, label: {
            VStack {
                Image(systemName: imageNames[theme]!)
                    //.imageScale(.large)
                    .font(.largeTitle)
                Text(theme)
                    .font(.caption)
            }
        })
        //.disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    var halloweenTheme: some View {
        selectTheme("Halloween")
    }
    
    var vehiclesTheme: some View {
        selectTheme("Vehicles")
    }
    
    var sportTheme: some View {
        selectTheme("Sport")
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = true
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 5)
                Text(content).font(.largeTitle)
            }
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
            // Чтобы не было ошибки - пишем @State у isFaceUp
            // @State создает указатель на isFaceUp
        }
    }
    
}

#Preview {
    ContentView()
}
