//
//  homeSlider.swift
//  E4 Patient
//
//  Created by mohab on 14/04/2021.
//

import Foundation
import FSPagerView
extension HomeVC : FSPagerViewDelegate , FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return homeResponse?.message?.slider?.count ?? 0
  
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cellSlider", at: index)
        let imgURL = URL(string: "\(Constants.baseURLImage)\(homeResponse?.message?.slider?[index].sliderImagePath ?? "")")
        cell.imageView?.kf.indicatorType = .activity
        cell.imageView?.kf.setImage(with: imgURL)
        cell.imageView?.contentMode = .scaleToFill
        cell.textLabel?.text = homeResponse?.message?.slider?[index].sliderTitle ?? ""
        return cell
    }
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
    }
   
}
