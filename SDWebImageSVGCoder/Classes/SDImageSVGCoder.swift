//
//  SDImageSVGCoder.swift
//  SwiftSVG
//
//  Created by lizhuoli on 2018/9/27.
//

import Foundation
import SDWebImage
import SwiftSVG

@objcMembers
open class SDImageSVGCoder : NSObject, SDImageCoder {
    @objc(sharedCoder) public static let shared = SDImageSVGCoder()
    
    public func canDecode(from data: Data?) -> Bool {
        return true
    }
    
    public func decodedImage(with data: Data?, options: [SDImageCoderOption : Any]? = nil) -> UIImage? {
        guard let data = data else {
            return nil
        }
        let parser = NSXMLSVGParser(SVGData: data)
        var SVGLayer: SVGLayer?
        
        // Async operation to sync because we're already in global queue
        let group = DispatchGroup()
        group.enter()
        parser.completionBlock = { (layer) in
            group.leave()
            SVGLayer = layer
        }
        parser.startParsing()
        _ = group.wait(timeout: .distantFuture)
        guard let layer = SVGLayer else {
            return nil
        }
        
        UIGraphicsBeginImageContextWithOptions(layer.boundingBox.size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        layer.render(in: context)
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
    
}

