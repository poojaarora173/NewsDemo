//
//  ImageViewerVC.swift
//  NewsDemo
//
//  Created by Pooja Arora on 27/03/22.
//

import UIKit

class ImageViewerVC: UIViewController , UIScrollViewDelegate{
    
    // MARK: - ======== Init ========
    static func initFromStoryboard() -> ImageViewerVC {
        let controller = CommonUtility.mainStoryboard.instantiateViewController(withIdentifier: "ImageViewerVC") as! ImageViewerVC
        return controller
    }
    
    var imageView: UIImageView!
    var scrollImg: UIScrollView!
    var imageURL = ""
    
    //MARK: View Life cycle methos
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        
    }
    func initialSetup()  {
        let vWidth = self.view.frame.width
        let vHeight = self.view.frame.height
        
        scrollImg = UIScrollView()
        scrollImg.delegate = self
        scrollImg.frame = CGRect(x: 0, y: 0, width: vWidth, height: vHeight)
        scrollImg.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        scrollImg.alwaysBounceVertical = false
        scrollImg.alwaysBounceHorizontal = false
        //scrollImg.showsVerticalScrollIndicator = true
        scrollImg.flashScrollIndicators()
        
        scrollImg.minimumZoomScale = 1.0
        scrollImg.maximumZoomScale = 10.0
        
        let doubleTapGest = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTapScrollView(recognizer:)))
        doubleTapGest.numberOfTapsRequired = 2
        scrollImg.addGestureRecognizer(doubleTapGest)
        
        self.view.addSubview(scrollImg)
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: vWidth, height: vHeight))
        imageView.contentMode = .scaleAspectFit
        imageView!.clipsToBounds = false
        scrollImg.addSubview(imageView!)
        
        imageView.setSDImage(imageURL)
    }
    @objc func handleDoubleTapScrollView(recognizer: UITapGestureRecognizer) {
        if scrollImg.zoomScale == 1 {
            scrollImg.zoom(to: zoomRectForScale(scale: scrollImg.maximumZoomScale, center: recognizer.location(in: recognizer.view)), animated: true)
        } else {
            scrollImg.setZoomScale(1, animated: true)
        }
    }
    
    func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = imageView.frame.size.height / scale
        zoomRect.size.width  = imageView.frame.size.width  / scale
        let newCenter = imageView.convert(center, from: scrollImg)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
}
