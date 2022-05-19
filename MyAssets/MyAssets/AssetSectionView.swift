//
//  AssetSectionView.swift
//  MyAssets
//
//  Created by woo0 on 2022/05/19.
//

import SwiftUI

struct AssetSectionView: View {
    @ObservedObject var assetSection: Asset
    var body: some View {
        VStack(spacing: 20) {
            AssetSectionHeaderView(title: assetSection.type.title)
            ForEach(assetSection.data) { asset in
                HStack {
                    Text(asset.title)
                        .font(.title)
                        .foregroundColor(Color.secondary)
                    Spacer()
                    Text(asset.amount)
                        .font(.title2)
                        .foregroundColor(Color.primary)
                }
                Divider()
            }
        }
        .padding()
    }
}

struct AssetSectionView_Previews: PreviewProvider {
    static var previews: some View {
        let asset = Asset(
            id: 0,
            type: .bankAccount,
            data: [
                AssetData(id: 0, title: "신한은행", amount: "5,213,124"),
                AssetData(id: 1, title: "국민은행", amount: "73,423,547"),
                AssetData(id: 2, title: "우리은행", amount: "1,453,641")
            ]
        )
        AssetSectionView(assetSection: asset)
    }
}
