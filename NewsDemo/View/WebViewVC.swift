//
//  WebViewVC.swift
//  Daily Positive Me
//
//  Created by Pooja Arora on 26/08/21.
//  Copyright © 2021 Aamil Silawat. All rights reserved.
//

import UIKit
import WebKit


class WebViewController: UIViewController {
    
    // MARK: - ======== Init ========
    static func initFromStoryboard() -> WebViewController {
        let controller = CommonUtility.mainStoryboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        return controller
    }
    
    //MARK:- Outlets
    @IBOutlet var webview: WKWebView!
    var url =  ""
   
    //MARK:- View Life cycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    //MARK:- Custom method
    func initialSetup()  {
        let link = URL(string:url)!
        let request = URLRequest(url: link)
        webview.load(request)
    }
}

//MARK:- Action
extension WebViewController{
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
