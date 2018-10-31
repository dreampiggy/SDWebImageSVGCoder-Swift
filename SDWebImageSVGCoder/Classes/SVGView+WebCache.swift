//
//  SVGView+WebCache.swift
//  SDWebImageSVGCoder
//
//  Created by lizhuoli on 2018/10/31.
//

import Foundation
import SDWebImage
import Macaw

extension SVGView {
    /**
     * Set the imageView `image` with an `url`, placeholder, custom options and context.
     *
     * The download is asynchronous and cached.
     *
     * @param url            The url for the image.
     * @param placeholder    The image to be set initially, until the image request finishes.
     * @param options        The options to use when downloading the image. @see SDWebImageOptions for the possible values.
     * @param context        A context contains different options to perform specify changes or processes, see `SDWebImageContextOption`. This hold the extra objects which `options` enum can not hold.
     * @param progressBlock  A block called while image is downloading
     *                       @note the progress block is executed on a background queue
     * @param completedBlock A block called when operation has been completed. This block has no return value
     *                       and takes the requested UIImage as first parameter. In case of error the image parameter
     *                       is nil and the second parameter may contain an NSError. The third parameter is a Boolean
     *                       indicating if the image was retrieved from the local cache or from the network.
     *                       The fourth parameter is the original image url.
     */
    open func sd_setImage(with url: URL?, placeholderImage placeholder: UIImage? = nil, options: SDWebImageOptions = [], context: [SDWebImageContextOption : Any]? = nil, progress progressBlock: SDImageLoaderProgressBlock? = nil, completed completedBlock: SDExternalCompletionBlock? = nil) {
        var mutableContext: [SDWebImageContextOption : Any] = context ?? [:]
        mutableContext[.animatedImageClass] = SVGImage.self
        let context = mutableContext
        self.sd_internalSetImage(with: url, placeholderImage: placeholder, options: options, context: context, setImageBlock: { [weak self](image, data, cacheType, url) in
            guard let image = image as? SVGImage else {
                return
            }
            guard let node = image.node else {
                return
            }
            self?.node = node
        }, progress: progressBlock) { (image, data, error, cacheType, finished, url) in
            if let completedBlock = completedBlock {
                completedBlock(image, error, cacheType, url)
            }
        }
    }
}
