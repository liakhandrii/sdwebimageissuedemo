//
//  ViewController.swift
//  SDWebImageDemo
//
//  Created by Andrew on 2/9/18.
//  Copyright © 2018 Andrew Liakh. All rights reserved.
//

import UIKit
import FLAnimatedImage
import SDWebImage

class ViewController: UIViewController {

    @IBOutlet weak var animatedImageView: FLAnimatedImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func refreshTapped(_ sender: Any) {
        refresh()
    }
    
    private func refresh() {
        let url = URL(string: "https://media0.giphy.com/media/l0MYNB04rBb51QNtC/200.gif")!
        SDWebImageManager.shared().loadImage(with: url, options: [.cacheMemoryOnly, .queryDataWhenInMemory], progress: nil, completed: { (loadedImage, data, error, cacheType, success, _) in
            // This always contains some data
            let memoryImageData = loadedImage?.sd_imageData()
            // This is nil in all situations
            let gifFromUiimage = FLAnimatedImage(animatedGIFData: memoryImageData) ?? loadedImage?.sd_FLAnimatedImage
            // This is ok only when the image is loaded from disk or web
            let gifFromData = FLAnimatedImage(animatedGIFData: data)
            
            self.animatedImageView.animatedImage = gifFromUiimage ?? gifFromData
        })
    }
    
}

