//
//  BannerCard.swift
//  MyAssets
//
//  Created by woo0 on 2022/05/19.
//

import SwiftUI

struct BannerCard: View {
    var banner: AssetBanner
    var body: some View {
        // ZStack을 활용해도 무방하다. 다양한 방법이 있으니 고민해보는게 좋다.
        Color(banner.backgroundColor)
            .overlay(
                VStack {
                    Text(banner.title)
                        .font(.title)
                    Text(banner.descruption)
                        .font(.subheadline)
                }
            )
    }
}

struct BannerCard_Previews: PreviewProvider {
    static var previews: some View {
        let banner0 = AssetBanner(title: "공지사항", descruption: "추가된 공지사항을 확인하세요.", backgroundColor: .red)
        BannerCard(banner: banner0)
    }
}
