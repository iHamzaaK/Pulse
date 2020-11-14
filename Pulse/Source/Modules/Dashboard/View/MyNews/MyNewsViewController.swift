//
//  MyNewsViewController.swift
//  Pulse
//
//  Created by Hamza Khan on 11/11/2020.
//

import UIKit

class MyNewsViewController: SegmentedPagerTabStripViewController {
    
    var isReload = false
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // change segmented style
        settings.style.segmentedControlColor = .white
        

    }
    
    
    // MARK: - PagerTabStripDataSource
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        

        guard isReload else {
            return [DashboardBuilder.InterestBuild(), DashboardBuilder.BookmarkBuild()]
        }

        var childViewControllers =  [DashboardBuilder.InterestBuild(), DashboardBuilder.BookmarkBuild()]
        let count = childViewControllers.count

        for index in childViewControllers.indices {
            let nElements = count - index
            let n = (Int(arc4random()) % nElements) + index
            if n != index {
                childViewControllers.swapAt(index, n)
            }
        }
        let nItems = 1 + (arc4random() % 4)
        return Array(childViewControllers.prefix(Int(nItems)))
    }

    @IBAction func reloadTapped(_ sender: UIBarButtonItem) {
        isReload = true
        pagerBehaviour = .common(skipIntermediateViewControllers: arc4random() % 2 == 0)
        reloadPagerTabStripView()
    }
}
