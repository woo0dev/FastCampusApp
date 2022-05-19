//
//  AssetBannerView.swift
//  MyAssets
//
//  Created by woo0 on 2022/05/19.
//

import SwiftUI

struct AssetBannerView: View {
    let bannerList: [AssetBanner] = [
        AssetBanner.init(title: "공지사항", descruption: "추가된 공지사항을 확인하세요.", backgroundColor: .red),
        AssetBanner.init(title: "주말 이벤트", descruption: "주말 이벤트 놓치지마세요.", backgroundColor: .yellow),
        AssetBanner.init(title: "깜짝 이벤트", descruption: "엄청난 이벤트에 놀라지마세요.", backgroundColor: .blue),
        AssetBanner.init(title: "가을 프로모션", descruption: "가을.......", backgroundColor: .brown)
    ]
    @State private var currentPage = 0
    
    var body: some View {
        let bannerCards = bannerList.map {
            BannerCard(banner: $0)
        }
        
        ZStack(alignment: .bottomTrailing) {
            PageViewController(pages: bannerCards, currentPage: $currentPage)
            PageControl(numberOfPages: bannerList.count, currentPage: $currentPage)
                .frame(width: CGFloat(bannerCards.count * 18), height: 30)
                .padding(.trailing)
        }
    }
}

struct AssetBannerView_Previews: PreviewProvider {
    static var previews: some View {
        AssetBannerView()
            .aspectRatio(contentMode: .fit)
    }
}
