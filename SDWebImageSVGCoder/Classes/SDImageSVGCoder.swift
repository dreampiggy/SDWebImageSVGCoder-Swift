//
//  SDImageSVGCoder.swift
//  SwiftSVG
//
//  Created by lizhuoli on 2018/9/27.
//

import Foundation
import SDWebImage
import Macaw

@objcMembers
open class SDImageSVGCoder : NSObject, SDImageCoder {
    @objc(sharedCoder) public static let shared = SDImageSVGCoder()
    private let kSVGTagEnd = "</svg>"
    
    public func canDecode(from data: Data?) -> Bool {
        return isSVGFormat(data)
    }
    
    public func decodedImage(with data: Data?, options: [SDImageCoderOption : Any]? = nil) -> UIImage? {
        guard let data = data else {
            return nil
        }
        guard let svgString = String(data: data, encoding: .utf8) else {
            return nil
        }
        guard let node = try? SVGParser.parse(text: svgString) else {
            return nil
        }
        
        let imageSize = node.bounds?.size().toCG() ?? UIScreen.main.bounds.size
        
        let svgView = SVGView(node: node, frame: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        
        UIGraphicsBeginImageContextWithOptions(imageSize, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        svgView.layer.draw(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    public func canEncode(to format: SDImageFormat) -> Bool {
        return false
    }
    
    public func encodedData(with image: UIImage?, format: SDImageFormat, options: [SDImageCoderOption : Any]? = nil) -> Data? {
        return nil
    }
    
    private func isSVGFormat(_ data: Data?) -> Bool {
        guard let data = data else {
            return false
        }
        if (data.count <= 100) {
            return false
        }
        // Check end with SVG tag
        guard let testString = String(data: data.subdata(in: data.count-100..<data.count), encoding: .ascii) else {
            return false
        }
        if (testString.range(of: kSVGTagEnd) == nil) {
            return false
        }
        return true
    }
}

