//
//  EditProfileView.swift
//  Hubble
//
//  Created by Salvatore Scaravalle on 19/02/26.
//

import SwiftUI

struct EditProfileView: View {
    @State var userName: String
    var body: some View {
        VStack{
            TextField("Inserisci il nuovo userName")
                .font(.system(size: 20))
                .padding()
            
            
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color(.systemGray6))
        )
        .padding()
        
    }
}

#Preview {
    EditProfileView(userName: "salvo")
}
