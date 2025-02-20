//
//  EditProfile.swift
//  FoodDelivery
//
//  Created by student on 12/02/25.
//

import SwiftUI

struct EditProfile: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var mainVM = MainViewModel.shared;
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    EditProfile()
}
