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

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.5
    @State private var filterScale = 0.5
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    @State private var showingFilterSheet = false
    
    @State private var processedImage: UIImage?
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        let intensity = Binding<Double>(
            get: {
                self.filterIntensity
            },
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
            }
        )
        
        let radius = Binding<Double>(
            get: {
                self.filterRadius
            },
            set: {
                self.filterRadius = $0
                self.applyProcessing()
            }
        )
        
        let scale = Binding<Double>(
            get: {
                self.filterScale
            },
            set: {
                self.filterScale = $0
                self.applyProcessing()
            }
        )
        
        return NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.gray)
                    
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to select image")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    self.showingImagePicker = true
                }
                
                HStack {
                    Text("Intensiry")
                        .frame(width: 70)
                    Slider(value: intensity)
                }.padding(.vertical)
                
                HStack {
                    Text("Radius")
                        .frame(width: 70)
                    Slider(value: radius)
                }.padding(.vertical)
                
                HStack {
                    Text("Scale")
                        .frame(width: 70)
                    Slider(value: scale)
                }.padding(.vertical)
                
                HStack {
                    Button("Filter: \(currentFilter.name)") {
                        self.showingFilterSheet = true
                    }
                    
                    Spacer()
                    
                    Button("Save") {
                        if self.image == nil {
                            self.alertTitle = "Error!"
                            self.alertMessage = "No image to save!"
                            self.showingAlert = true
                        }
                        guard let processedImage = self.processedImage else { return }
                        
                        let imageSaver = ImageSaver()
                        imageSaver.successHandler = {
                            print("Save Success!")
                            self.alertTitle = "Save successed!"
                            self.alertMessage = "Your filtered photo saved!"
                            self.showingAlert = true
                        }
                        imageSaver.errorHandler = {
                            print("Save Error: \($0.localizedDescription)")
                        }
                        
                        imageSaver.writeToPhotoAlbum(image: processedImage)
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
            .actionSheet(isPresented: $showingFilterSheet) {
                ActionSheet(title: Text("Select a filter"), buttons: [
                    .default(Text("Edges")) { self.setFilter(CIFilter.edges())},
                    .default(Text("Gaussian Blur")) { self.setFilter(CIFilter.gaussianBlur())},
                    .default(Text("Pixellate")) { self.setFilter(CIFilter.pixellate())},
                    .default(Text("Sepia Tone")) { self.setFilter(CIFilter.sepiaTone())},
                    .default(Text("Unsharp Mask")) { self.setFilter(CIFilter.unsharpMask())},
                    .default(Text("Vignette")) { self.setFilter(CIFilter.vignette())},
                    .cancel()
                ])
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)}
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterRadius * 100, forKey: kCIInputRadiusKey)}
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterScale * 50, forKey: kCIInputScaleKey)}
        
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
