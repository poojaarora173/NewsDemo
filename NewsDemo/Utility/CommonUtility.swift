//
//  CommonUtility.swift
//  LabelXChange
//
//  Created by Intelivita-MacMini on 16/02/21.
//

import Foundation
import NVActivityIndicatorView
import SDWebImage

class CommonUtility {
    static let sharedInstance = CommonUtility()
    static let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)

    func setTableViewWithNoRecords(tblView:UITableView,ary:NSArray,strMessage: String)  {
        
        let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tblView.bounds.size.width, height: tblView.bounds.size.height))
        noDataLabel.text = strMessage
        noDataLabel.textColor = UIColor.darkGray
        noDataLabel.textAlignment = .center
    
        if ary.count == 0 {
            tblView.backgroundView = noDataLabel
        }else{
            tblView.backgroundView = nil
            noDataLabel.text = ""
            
        }
    }
}

extension UIViewController {
    var currentWindow: UIWindow? {
        return self.view.window
    }
}
extension UIImageView {
    func setSDImage(_ urlstring: String, placeholderName: String = "ic_placeholder", completion: (() -> Void)? = nil) {
        self.sd_imageTransition = .fade(duration: 2.0)
        sd_setImage(with: URL(string: urlstring), placeholderImage: UIImage(named: placeholderName)) { (_, _, _, _) in
            completion?()
        }
    }
}
