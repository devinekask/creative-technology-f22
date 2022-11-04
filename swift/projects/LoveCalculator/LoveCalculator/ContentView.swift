//
//  ContentView.swift
//  LoveCalculator
//
//  Created by Wouter Verweirder on 04/11/2022.
//

import SwiftUI

func generateUniqueRandomInt(range:ClosedRange<Int>) -> Int {
    let random = Int.random(in: range)
    return random
}

func generateUniqueRandomInt(range:ClosedRange<Int>, except: Int) -> Int {
    var random:Int
    repeat {
        random = generateUniqueRandomInt(range: range)
    } while (random == except)
    return random
}

struct ContentView: View {
    @State var collega1Index:Int
    @State var collega2Index:Int
    @State var percentage:Int
    
    var body: some View {
        ZStack {
            Image("background_2")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                
                Image("logo_love_calculator")
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 100)
                
                HStack {
                    Image("collega\(collega1Index)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Image("collega\(collega2Index)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                
                Text("\(percentage)% match")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                Button("Shuffle") {
                    collega1Index = generateUniqueRandomInt(range: 1...13)
                    collega2Index = generateUniqueRandomInt(range: 1...13, except: collega1Index)
                    percentage = generateUniqueRandomInt(range: 0...100)
                }
                .padding()
                .background(.black)
                .foregroundColor(.white)
                .bold()
            }.padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(collega1Index: 1, collega2Index: 2, percentage: 50)
    }
}
