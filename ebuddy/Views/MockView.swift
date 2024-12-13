//
//  MockView.swift
//  ebuddy
//
//  Created by Rudy Suharyadi on 12/12/24.
//

import SwiftUI

struct MockView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    // Breakdown to smaller component as needed.
    var body: some View {
        VStack (alignment: .leading) {
            // Top View: Title, Online, VerifiedIcon, InstagramIcon
            HStack(spacing: 8) {
                Text("Zynx")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Spacer().frame(width: 4)
                
                Circle()
                    .fill(Color.online)
                    .frame(width: 16, height: 16)
                
                Spacer()
                
                Image("VerifiedImage")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .scaledToFit()
                
                Spacer().frame(width: 4)
                
                if (colorScheme == .dark) {
                    Image("InstagramImage")
                        .resizable()
                        .frame(width: 36, height: 36)
                        .scaledToFit()
                        .colorInvert()
                } else {
                    Image("InstagramImage")
                        .resizable()
                        .frame(width: 36, height: 36)
                        .scaledToFit()
                }
            }
            .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
            
            // Middle View: Image, Available Today, Circle Menu
            ZStack (alignment: .top) {
                // Image
                VStack {
                    ZStack {
                        Rectangle()
                            .fill(Color(.gray))
                                
                        Image("MockImage")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .layoutPriority(-1)
                    }
                    .cornerRadius(32)
                    .clipped()
      
                    Spacer().frame(height: 50)
                }
                
                VStack {
                    Spacer().frame(height: 16)
                    
                    // Available Today
                    HStack {
                        Spacer().frame(width: 16)
                        
                        HStack {
                            Image("LightningImage")
                                .resizable()
                                .frame(width: 36, height: 36)
                                .scaledToFit()
                            
                            Text("Available Today!")
                                .font(.title)
                                .foregroundColor(Color.white)
                        }
                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                        .background(.ultraThinMaterial
                            .opacity(0.8), in: RoundedRectangle(cornerRadius: 30))
                        
                        Spacer()
                    }
                    
                    Spacer()
                    
                    // Circle Menu
                    HStack {
                        Spacer().frame(width: 16)
                        
                        ZStack (alignment: .leading) {
                            Image("CODImage")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                            
                            HStack {
                                Spacer().frame(width: 80)
                                
                                ZStack {
                                    Image("MoleImage")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .clipShape(Circle())
                                        .brightness(colorScheme == .dark ? 0.4 : 0)
                                    
                                    Circle()
                                        .stroke(.white, lineWidth: 2)
                                        .fill(.ultraThinMaterial.opacity(colorScheme == .dark ? 0.2 : 0.6)
                                        )
                                        .frame(width: 100, height: 100)
                                    
                                    Text("+3")
                                        .font(.largeTitle)
                                        .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                                    
                                }
                                
                                Spacer()
                            }
                        }
                        
                        Spacer()
                        
                        Image(colorScheme == .dark ? "VoiceDarkImage" : "VoiceImage")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            
                        Spacer().frame(width: 16)
                    }
                }
                
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
            
            HStack {
                Image("StarImage")
                    .resizable()
                    .frame(width: 36, height: 36)
                    .scaledToFit()
                
                Spacer().frame(width: 16)
                
                Text("4.9")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("(61)")
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundColor(Color.gray)
            }
            .padding(EdgeInsets(top: 0, leading: 32, bottom: 16, trailing: 32))
            
            HStack {
                Image("FireImage")
                    .resizable()
                    .frame(width: 36, height: 36)
                    .scaledToFit()
                
                Spacer().frame(width: 16)
                
                HStack (alignment: .bottom, spacing: 0) {
                    Text("110")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(height: 30)
                    
                    Text(".00/1Hr")
                        .font(.body)
                        .frame(height: 30)
                        
                }
            }
            .padding(EdgeInsets(top: 0, leading: 32, bottom: 16, trailing: 32))
        }
    }
}


#Preview {
    MockView()
}
