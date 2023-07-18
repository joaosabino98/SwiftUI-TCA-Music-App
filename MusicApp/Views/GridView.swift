//
//  GridView.swift
//  MusicApp
//
//  Created by Sabino, Joao Gabriel on 21/06/2023.
//

import SwiftUI

struct GridView: View {
    
    private let images = ["previewImage1", "previewImage2", "previewImage3", "previewImage4"]
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 170))
    ]
    private let numberColumns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    ZStack {
                        Text("Classes")
                            .font(.title2)
                            .fontWeight(.bold)
                        Image(images[0])
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width/2 - 10, height: geometry.size.width/2 - 10)
                            .opacity(0.6)
                            .cornerRadius(16)
                            .clipped()
                        NavigationLink(destination: ClassListView()) {
                            EmptyView()
                        }.buttonStyle(.plain)
                            .opacity(0)
                    }
                    .padding([.trailing], 20)
                    
                    ZStack {
                        Text("Instruments")
                            .font(.title2)
                            .fontWeight(.bold)
                        Image(images[1])
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width/2 - 10, height: geometry.size.width/2 - 10)
                            .opacity(0.6)
                            .cornerRadius(16)
                            .clipped()
                        NavigationLink(destination: ClassListView()) {
                            EmptyView()
                        }.buttonStyle(.plain)
                            .opacity(0)
                    }
                }
                .padding([.bottom], 10)
                HStack {
                    ZStack {
                        Text("Artists")
                            .font(.title2)
                            .fontWeight(.bold)
                        Image(images[2])
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width/2 - 10, height: geometry.size.width/2 - 10)
                            .opacity(0.6)
                            .cornerRadius(16)
                            .clipped()
                        NavigationLink(destination: ClassListView()) {
                            EmptyView()
                        }.buttonStyle(.plain)
                            .opacity(0)
                    }
                    .padding([.trailing], 20)
                    
                    ZStack {
                        Text("Songs")
                            .font(.title2)
                            .fontWeight(.bold)
                        Image(images[3])
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width/2 - 10, height: geometry.size.width/2 - 10)
                            .opacity(0.6)
                            .cornerRadius(16)
                            .clipped()
                        NavigationLink(destination: ClassListView()) {
                            EmptyView()
                        }.buttonStyle(.plain)
                            .opacity(0)
                    }
                }
            }
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
    }
}
