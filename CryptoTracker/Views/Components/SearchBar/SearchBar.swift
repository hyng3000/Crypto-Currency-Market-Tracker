//
//  SearchBar.swift
//  CryptoTracker
//
//  Created by Hamish Young on 27/3/2023.


import SwiftUI

struct SearchBar: View {

    @Binding var searchtext: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                searchtext.isEmpty ?
                Color.theme.secondaryTextColor : Color.theme.accent)
            TextField("Search..", text: $searchtext)
                .disableAutocorrection(true)
                .overlay(
                Image(systemName: "xmark.circle.fill")
                .foregroundColor(Color.theme.accent)
                .opacity(searchtext.isEmpty ? 0.0 : 1.0 )
                .onTapGesture {
                    UIApplication.shared.appDismissKeyboard()
                    searchtext = ""
                }, alignment: .trailing)
                
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 20)
            .fill(Color.theme.background)
            .shadow(
            color: Color.theme.accent.opacity(0.5),
            radius: 10))
            .padding()
        }
    }

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchtext: .constant(""))
    }
}
