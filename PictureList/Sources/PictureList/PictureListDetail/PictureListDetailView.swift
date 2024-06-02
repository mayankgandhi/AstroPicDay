//
//  PictureListDetailView.swift
//
//
//  Created by Mayank Gandhi on 01/06/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct PictureListDetailView: View {
    
    let pictureListItem: PictureListItem
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading, spacing: 12) {
                Text(pictureListItem.title)
                    .font(.headline)
                
                AsyncImage(url: pictureListItem.hdurl) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text(pictureListItem.explanation)
                    Text(pictureListItem.date)
                        .font(.footnote)
                }
            }
            .padding(.all, 12)
            .navigationTitle(Text(verbatim: pictureListItem.date))
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
}
