//
//  GridView_alt.swift
//  MusicApp
//
//  Created by Sabino, Joao Gabriel on 17/07/2023.
//

import SwiftUI

struct GridView_alt: View {
    @State private var selectedButtonIndex: Int?
    private let images = ["previewImage1", "previewImage2", "previewImage3", "previewImage4"]
    private let names = ["Classes", "Instruments", "Artists", "Songs"]
    
    var body: some View {
            VStack {
                HStack {
                    ForEach(0..<2) { index in
                        Button(action: {
                            selectedButtonIndex = index
                        }) {
                            ButtonView(imageName: images[index], text: names[index])
                        }
                        .buttonStyle(.borderless)
                    }
                }
                HStack {
                    ForEach(2..<4) { index in
                        Button(action: {
                            selectedButtonIndex = index
                        }) {
                            ButtonView(imageName: images[index], text: names[index])
                        }
                        .buttonStyle(.borderless)

                    }
                }
                NavigationLink(
                    destination: destinationView(),
                    isActive: Binding<Bool>(
                        get: { selectedButtonIndex != nil },
                        set: { _ in }
                    )
                ) {
                    EmptyView()
                }
                
                Spacer()
            }
            .onAppear {
                selectedButtonIndex = nil
            }
    }
    
    private func destinationView() -> some View {
        if let index = selectedButtonIndex {
            switch index {
            case 0:
                return AnyView(FirstView())
            case 1:
                return AnyView(SecondView())
            case 2:
                return AnyView(ThirdView())
            case 3:
                return AnyView(FourthView())
            default:
                return AnyView(EmptyView())
            }
        } else {
            return AnyView(EmptyView())
        }
    }
}

struct ButtonView: View {
    var imageName: String
    var text: String
    
    var body: some View {
        ZStack {
            Text(text)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.black)
            Image(imageName)
                .resizable()
                .scaledToFill()
                .opacity(0.6)
                .cornerRadius(16)
                .clipped()
        }
    }
}

struct FirstView: View {
    var body: some View {
        Text("First View")
    }
}

struct SecondView: View {
    var body: some View {
        Text("Second View")
    }
}

struct ThirdView: View {
    var body: some View {
        Text("Third View")
    }
}

struct FourthView: View {
    var body: some View {
        Text("Fourth View")
    }
}

struct GridView_alt_Previews: PreviewProvider {
    static var previews: some View {
        GridView_alt()
    }
}
