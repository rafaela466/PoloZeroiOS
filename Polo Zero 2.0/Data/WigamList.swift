//
//  WigamList.swift
//  Polo Zero 2.0
//
//  Created by Rafaela Santos on 01/07/2021.
//

import SwiftUI
import WKView

let getUrlWigam = "https://api.npoint.io/194fa7704b10ed5b91c1"
let postUrlWigam = "https://jsonplaceholder.typicode.com/posts"

//JSON FILE
struct PrecosWigamList: Decodable, Identifiable{
    let id: Int
    let marca: String
    let imageUrl: String
    let ano: String
    let link: String
}

struct PostWigamList: Decodable, Identifiable{
    let id: Int
    let marca: String
    let imageUrl: String
    let ano: String
    let link: String
    let body: String
}

//ViewModelWigam
class ViewModelWigam: ObservableObject{
    @Published var items = [PrecosWigamList]()
    
    func loadData(){
        guard let url = URL(string: getUrlWigam) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            do{
                if let data = data{
                    let result = try JSONDecoder().decode([PrecosWigamList].self, from: data)
                    
                    DispatchQueue.main.async {
                        self.items = result
                    }
                }else{
                    print("empty!")
                }
            }catch(let error){
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func postData(){
        guard let url = URL(string: postUrlWigam) else { return }

        let marca = "default"
        let link = "default"
        let ano = "default"
        let id = 1
        
        let body: [String: Any] = ["title": marca, "link": link, "id": id, "ano": ano]
        
        let finalData = try! JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalData
        request.setValue("application/JSON", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: url){(data, res, err) in
            do{
                if let data = data{
                    let result = try JSONDecoder().decode(PostWigamList.self, from: data)
                print(result)
                }else{
                    print("no data")
                }
            }catch(let error){
                print(error.localizedDescription)
            }
        }.resume()
    }
}

struct WigamList: View {
    @ObservedObject var viewModel = ViewModelWigam()
    @State var selectedItem: PrecosWigamList?
    var body: some View {
        NavigationView{
            ScrollView{
                HStack {
                Text("Wigam")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, -40)
                Spacer()
            }.padding(.leading)
                LazyVGrid(columns: gridLayout,spacing: 15, content: {
                    ForEach(viewModel.items, id: \.id) { item in
                        VStack(){
                           Button(action: { selectedItem = item }, label: {
                                   Image(item.imageUrl)
                                       .resizable()
                                       .scaledToFit()
                                       .padding(10)
                               })
                           
                           Text(item.marca)
                               .fontWeight(.semibold)
                        }//:VSTACK
                        .scaledToFit()
                        .padding()
                        .background(Color.white.cornerRadius(12))
                        .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 1))
                    }//: LOOP
                }).padding(5)
                .onAppear(perform: {
                viewModel.loadData()
                viewModel.postData()
                })
                .sheet(item: $selectedItem, content: { selectedItem in
                    WebView(url: selectedItem.link)
                })
            }.navigationBarHidden(true)
        }//: NAV VIEW
    }//: BODY
}

struct WigamList_Previews: PreviewProvider {
    static var previews: some View {
        WigamList()
            .previewDevice("iPhone 12 Pro")
            .previewLayout(.sizeThatFits)
    }
}
