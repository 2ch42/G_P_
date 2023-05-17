import SwiftUI

struct ImageView: View {
    @State private var images: [Image] = []
    @State private var selectedIndices: [Int] = []
    let urls = [
        URL(string: "https://i.ytimg.com/vi/X6VrQZhr5hQ/maxresdefault.jpg")!,
        URL(string: "https://www.seriouseats.com/thmb/xw1krLC9Yh85qx1wl5jw0BPCWHk=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/__opt__aboutcom__coeus__resources__content_migration__serious_eats__seriouseats.com__2015__07__20210324-SouthernFriedChicken-Andrew-Janjigian-21-cea1fe39234844638018b15259cabdc2.jpg")!,
        URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqq0ErtHeryWJ-lLCyv_wkat9nOxpcQ_5kQw&usqp=CAU")!,
        URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5mxcZ3FPO11i0wVhnOgKMZuP8DYTHO6gn6w&usqp=CAU")!,
        URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXpM99hKD4FnN6JBfFlnoX-QzkaTuE84w3Zg&usqp=CAU")!,
        URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxFb5MKHORq9KHFaNjn_b3nigdobmR83yOuw&usqp=CAU")!,
        URL(string:
           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTCxQOlTs5GaMbg5_DvbU0SZj-EjMjAgL0e6Q&usqp=CAU")!,
        URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXmGSFdDfA-iyKb6Y5RHLzZNEwg4J3bEk1uw&usqp=CAU")!
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                HStack(spacing: 16) {
                    ForEach(selectedIndices, id: \.self) { index in
                        Button(action: {
                            self.changeImage(at: index)
                        }, label: {
                            images[index]
                                .resizable()
                                .scaledToFit()
                                .frame(width: 180, height: 180) // 이미지 뷰의 크기를 조정합니다.
                        })
                    }
                }
                HStack{
                    Spacer()
                        .frame(width: 300)
                    Button("reset") {
                        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                    }
                }
                Spacer()
                Button("commit") {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                }
                Spacer()
                    .frame(height: 50)
            }
            .navigationTitle("Select Menu")
        }
        .onAppear {
            self.loadImages()
        }
    }
    
    private func loadImages() {
        for url in urls {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                let image = Image(uiImage: UIImage(data: data)!)
                DispatchQueue.main.async {
                    self.images.append(image)
                }
            }
            task.resume()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let randomIndices = (0..<self.images.count).shuffled().prefix(2)
            self.selectedIndices = Array(randomIndices)
            
            for index in randomIndices {
                let filteredImages = self.images.filter { $0 != self.images[index] }
                guard let randomImage = filteredImages.randomElement() else { return }
                self.images[index] = randomImage
            }
        }
    }
    
    private func changeImage(at index: Int) {
        let filteredImages = self.images.filter { $0 != self.images[index] }
        guard let randomImage = filteredImages.randomElement() else { return }
        images[index] = randomImage
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}
