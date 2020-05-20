//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Toshiki Ichibangase on 2020/05/16.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//

import UIKit

class ImageSaver: NSObject {
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
    
    //Photo albumに書き込むメソッド
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
    
    //Photo albumへの書き込み後のエラー処理のメソッド
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contentInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
}
