//
//  ProfileView.swift
//  
//
//  Created by Daniele Giammarresi on 18/02/26.
//

import SwiftUI

struct ProfileView: View {
    @State var user : User?
    @State var showView = false
    var body: some View {
        VStack{
            
            Text("My Profile")
                .padding()
                .font(.system(size: 20))
            NavigationStack{
                VStack{
                    VStack{
                        HStack{
                            Spacer()
                            VStack{
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .colorMultiply(.blue)
                                    .padding()
                                    .aspectRatio(contentMode: .fill)
                                Text("sss")
                                    .font(.system(size: 30))
                                Text("ss")
                                    .padding()
                                    .font(.system(size: 20))
                                    .foregroundColor(.blue)
                            }
                            Spacer()
                        }
                        
                        
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color(.systemGray6))
                    )
                }
                NavigationLink(destination: MyGroupView()){
                    Text("Edit Profile")
                        .padding()
                        .frame(maxWidth: .infinity)
                }.background(
                    RoundedRectangle(cornerRadius: 30)
                    .fill(Color(.systemGray6))
                )
                Button(action: {
                    showView = true
                }){
                    Text("Logout")
                        .foregroundColor(.red)
                        .padding()
                    
                        
                }.frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                        .fill(Color(.systemGray6))
                    )
                Spacer()
                
                if showView {
                    
                    VStack{
                        Text("Tap me!")
                        Button("Show Modal") {
                            self.showView.toggle()
                        }.frame(width: 300, height: 200)
                            .background(.red)
                    }
                }
                            
                
                
                
                    
                    
                       
            }
            
            
        }
        .padding()
    }
}
#Preview {
    ProfileView()
}
