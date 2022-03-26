import Foundation
import NVActivityIndicatorView
import UIKit
import Photos

//Loading Indecater View
//--------------------------------------------------
// MARK: - UIViewController
//--------------------------------------------------
extension UIViewController : NVActivityIndicatorViewable {
    
    func startAnimateLoader(){
        self.startAnimating(CGSize.init(width: 60, height: 60), message: nil, messageFont: nil, type: .ballSpinFadeLoader, color: UIColor.white, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil, textColor: nil)
    }
    
    func stopAnimatorLoader() {
        stopAnimating()
    }
}

//--------------------------------------------------
// MARK: - Date
//--------------------------------------------------
extension Date {
    func string(format: String) -> String {
          let formatter = DateFormatter()
          formatter.dateFormat = format
          return formatter.string(from: self)
      }
    
    
  
}
