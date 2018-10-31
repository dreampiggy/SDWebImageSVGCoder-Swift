//
//  ViewController.swift
//  SDWebImageSVGCoder
//
//  Created by lizhuoli1126@126.com on 09/27/2018.
//  Copyright (c) 2018 lizhuoli1126@126.com. All rights reserved.
//

import UIKit
import SDWebImage
import SDWebImageSVGCoder
import Macaw

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let coder = SDImageSVGCoder.shared
        SDImageCodersManager.shared.addCoder(coder)
        let svgURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/e/e8/Svg_example3.svg")!
        let svgURL2 = URL(string: "https://upload.wikimedia.org/wikipedia/commons/2/2d/Sample_SVG_file%2C_signature.svg")!
        
        let screenSize = UIScreen.main.bounds.size
        
        let imageView1 = SVGView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height / 2))
        imageView1.backgroundColor = UIColor.white
        let imageView2 = UIImageView(frame: CGRect(x: 0, y: screenSize.height / 2, width: screenSize.width, height: screenSize.height / 2))
        
        self.view.addSubview(imageView1)
        self.view.addSubview(imageView2)
        
        imageView1.sd_setImage(with: svgURL) { (image, error, cacheType, url) in
            if image != nil {
                print("SVGView SVG load success")
            }
        }
        imageView2.sd_setImage(with: svgURL2) { (image, error, cacheType, url) in
            if image != nil {
                print("UIImageView SVG load success")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

