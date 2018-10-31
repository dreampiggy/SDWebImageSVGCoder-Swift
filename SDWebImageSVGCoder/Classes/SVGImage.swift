//
//  SVGImage.swift
//  SDWebImageSVGCoder
//
//  Created by lizhuoli on 2018/10/31.
//

import Foundation
import SDWebImage
import Macaw

@objcMembers
final class SVGImage : UIImage, SDAnimatedImageProtocol {
    let node: Node?
    
    required convenience init?(data: Data, scale: CGFloat, options: [SDImageCoderOption : Any]? = nil) {
        guard let svgString = String(data: data, encoding: .utf8) else {
            return nil
        }
        guard let node = try? SVGParser.parse(text: svgString) else {
            return nil
        }
        
        self.init(node: node)
    }
    
    init(node: Node) {
        self.node = node
        super.init()
    }
    
    required init?(animatedCoder: SDAnimatedImageCoder, scale: CGFloat) {
        return nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var animatedImageData: Data? = nil
    
    var animatedImageFrameCount: UInt = 0
    
    var animatedImageLoopCount: UInt = 0
    
    func animatedImageFrame(at index: UInt) -> UIImage? {
        return nil
    }
    
    func animatedImageDuration(at index: UInt) -> TimeInterval {
        return 0
    }
}

// MARK: - UIImage Extension
extension UIImage : _ExpressibleByImageLiteral {
    private convenience init!(failableImageLiteral name: String) {
        self.init(named: name)
    }
    
    public convenience init(imageLiteralResourceName name: String) {
        self.init(failableImageLiteral: name)
    }
}
