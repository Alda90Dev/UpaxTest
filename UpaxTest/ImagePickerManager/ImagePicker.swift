//
//  ImagePicker.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 08/01/23.
//

import Foundation

import UIKit
import AVFoundation
import Photos

protocol ImagePickerDelegate: AnyObject {
    func imagePicker(_ imagePicker: ImagePicker, grantedAccess: Bool,
                     to sourceType: UIImagePickerController.SourceType)
    func imagePicker(_ imagePicker: ImagePicker, didSelect image: UIImage)
    func cancelButtonDidClick(on imageView: ImagePicker)
}

class ImagePicker: NSObject {

    private weak var controller: UIImagePickerController?
    weak var delegate: ImagePickerDelegate? = nil

    func dismiss() { controller?.dismiss(animated: true, completion: nil) }
    func present(parent viewController: UIViewController, sourceType: UIImagePickerController.SourceType) {
        DispatchQueue.main.async {
            let controller = UIImagePickerController()
            controller.delegate = self
            controller.allowsEditing = true
            controller.sourceType = sourceType
            self.controller = controller
            viewController.present(controller, animated: true, completion: nil)
        }
    }
}

