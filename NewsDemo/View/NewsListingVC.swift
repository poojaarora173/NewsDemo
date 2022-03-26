//
//  ViewController.swift
// NewsDemo
//
//  Created by Pooja Arora on 26/03/22.
//

import UIKit

class NewsListingVC: UIViewController {
    
    // MARK: - ======== Init ========
    static func initFromStoryboard() -> NewsListingVC {
        let controller = CommonUtility.mainStoryboard.instantiateViewController(withIdentifier: "NewsListingVC") as! NewsListingVC
        return controller
    }
    
    //MARK:- View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
}
