//
//  ContentView.swift
//  Instafilter
//
//  Created by Toshiki Ichibangase on 2020/05/10.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//

import SwiftUI

import CoreImage
import CoreImage.CIFilterBuiltins

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
    
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
}


struct ContentView: View {
    @State private var blurAmount: CGFloat = 0
    
    @State private var showingActionSheet = false
    @State private var backgroundColor = Color.white
    
    @State private var image: Image?
    @State private var showingImagePicker = false
    
    @State private var inputImage: UIImage?
    
    var body: some View {
        let blur = Binding<CGFloat>(
            get: {
                self.blurAmount
            },
            set: {
                self.blurAmount = $0
                print("New value is \(self.blurAmount)")
            }
        )
        
        return VStack {
            VStack {
                image?
                    .resizable()
                    .scaledToFit()
                
                Button("Select Image") {
                    self.showingImagePicker = true
                }
            }
            .onAppear(perform: loadImage)
            .sheet(isPresented: $showingImagePicker, onDismiss: loadSelectedImage) {
                ImagePicker(image: self.$inputImage)
            }
            
            Text("Hello, world!")
                .blur(radius: blurAmount)
                .background(backgroundColor)
                .onTapGesture {
                    self.showingActionSheet = true
                }
                .actionSheet(isPresented: $showingActionSheet) {
                    ActionSheet(title: Text("Change background"), message: Text("Select a new color"), buttons: [
                        .default(Text("Red")) { self.backgroundColor = Color.red },
                        .default(Text("Green")) { self.backgroundColor = Color.green },
                        .default(Text("Blue")) { self.backgroundColor = Color.blue },
                        .default(Text("White")) { self.backgroundColor = Color.white },
                        .default(Text("Black")) { self.backgroundColor = Color.black },
                        .cancel()
                    ])
                }
            
            Slider(value: blur, in: 0...20)
        }
    }
    
    func loadImage() {
        guard let inputImage = UIImage(named: "cat47") else { return }
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
        let currentFilter = CIFilter.pixellate()
        
        currentFilter.inputImage = beginImage
        //currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        currentFilter.scale = 100
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
        }
    }
    
    func loadSelectedImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: inputImage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
