//
//  ScrollablePageViewController.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 7/31/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class ScrollablePageViewController: BaseViewController {
    var pages: [UIView]?
    let scrollView = UIScrollView()
    let pageControl = UIPageControl()
    override init() {
        super.init()
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        pageControl.currentPage = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pages = buildPages()
        view.addSubview(scrollView)
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view).offset(-10)
        }
        scrollView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(view)
            make.bottom.equalTo(pageControl.snp.top)
        }
        layoutPagesOnScrollView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    // override this!
    func buildPages() -> [UIView]? {
        return nil
    }
    
    func layoutPagesOnScrollView() {
        scrollView.contentSize = CGSize(width: view.width * CGFloat(pages?.count ?? 1),
                                        height: scrollView.contentSize.height)
        var index: CGFloat = 0
        pages?.forEach({ (page) in
            page.frame.origin = CGPoint(x: index * scrollView.width, y: 0)
            page.size = scrollView.size
            index += 1
        })
    }
}

extension ScrollablePageViewController: UIScrollViewDelegate {
    
}
