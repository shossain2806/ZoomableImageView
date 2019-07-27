//
//  ZoomableImageView.swift
//  ZoomableImageViewSample
//
//  Created by Saber Hossain on 27/7/19.
//  Copyright © 2019 Saber Hossain. All rights reserved.
//

import UIKit

class ZoomableImageView: UIScrollView {

    let imageView = UIImageView()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureScrollView()
        configureImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureScrollView()
        configureImageView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        centerImageViewIfNeeded()
    }
    
    private func configureScrollView(){
        alwaysBounceVertical = true
        alwaysBounceHorizontal = true
        contentInsetAdjustmentBehavior = .never
        super.delegate = self
    }
    
    private func configureImageView(){
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        NSLayoutConstraint.activate([

            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)

        ])
    }
    
    func setImage(image: UIImage?, animate : Bool = false){
        self.imageView.image = image
        setNeedsLayout()
        layoutIfNeeded()
        scaleImageView(animate: animate)
        
    }
    
    private func scaleImageView(animate : Bool){
        let imageSize = self.imageView.image?.size ?? CGSize.zero
        let boundsSize = self.bounds.size
        var scale : CGFloat = 1.0
        if imageSize.width > imageSize.height{//landscape image
            scale = boundsSize.width / imageSize.width
        }
        else{
            scale = boundsSize.height / imageSize.height
        }
        
        self.minimumZoomScale = scale
        self.maximumZoomScale = scale * 6.0
        self.setZoomScale(scale, animated: animate)
    }
    
    private func centerImageViewIfNeeded(){
        let topInset : CGFloat = max((self.bounds.size.height - self.imageView.frame.size.height) / 2.0 , 0.0)
        let leftInset : CGFloat = max((self.bounds.size.width - self.imageView.frame.size.width) / 2.0 , 0.0)
        self.contentInset = UIEdgeInsets(top: topInset, left: leftInset, bottom: 0, right: 0)
    }
}

extension ZoomableImageView : UIScrollViewDelegate{

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerImageViewIfNeeded()
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }

}
