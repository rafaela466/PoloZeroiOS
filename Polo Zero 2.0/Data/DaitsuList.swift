//
//  DaitsuList.swift
//  Polo Zero 2.0
//
//  Created by Rafaela Santos on 01/07/2021.
//

import SwiftUI
import WKView

let getUrlDaitsu = "https://api.npoint.io/989d957def9aab6fbfbc"
let postUrlDaitsu =  "https://jsonplaceholder.typicode.com/posts"

//JSON VARIABLES
struct PrecosDaitsuList: Decodable, Identifiable{
    let id: Int
    let marca: String
    let imageUrl: String
    let ano: String
    let link: String
}

struct PostDaitsuList: Decodable, Identifiable{
    let id: Int
    let marca: String
    let imageUrl: String
    let ano: String
    let link: String
    let body: String
}

//ViewModelDaitsu
class ViewModelDaitsu: ObservableObject{
    @Published var items = [PrecosDaitsuList]()
    
    func loadData(){
        guard let url = URL(string: getUrlDaitsu) else { return }
        
        URLSession.shared.dataTask(with: url){(data, res, err) in
            do{
                if let data = data {
                    let result = try JSONDecoder().decode([PrecosDaitsuList].self, from: data)
                    
                    DispatchQueue.main.async {
                        self.items = result
                    }
                }else{
                    print("no data...")
                }
            }catch (let error){
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func postData(){
        guard let url = URL(string: postUrlDaitsu) else { return }
        
        let marca = "default"
        let link = "default"
        let ano = "default"
        let id = 1
        
        let body: [String: Any] = ["title": marca, "link":link, "id": id, "ano":ano]
        
        let finalData = try! JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalData
        request.setValue("application/JSON", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: url){ (data, res, err) in
            do{
                if let data = data {
                    let result = try JSONDecoder().decode(PostDaitsuList.self, from: data)
                    print(result)
                }else{
                    print("no data!")
                }
            }catch(let error){
                print(error.localizedDescription)
            }
        }.resume()
    }
}

struct DaitsuList: View {
    @ObservedObject var viewModel = ViewModelDaitsu()
    @State var selectedItem: PrecosDaitsuList?
    var body: some View {
        NavigationView{
            ScrollView{
                HStack {
                Text("Daitsu")
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
                            
                        } //:VSTACK
                        .scaledToFit()
                        .padding()
                        .background(Color.white.cornerRadius(12))
                        .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 1))
                    } //: LOOP
                }).padding(5)
                .onAppear(perform: {
                viewModel.loadData()
                viewModel.postData()
                })
                .sheet(item: $selectedItem, content: { selectedItem in
                    WebView(url: selectedItem.link)
                })
            }.navigationBarHidden(true)
        }//: NAVIGATION VIEW
    }//: BODY
}

struct DaitsuList_Previews: PreviewProvider {
    static var previews: some View {
        DaitsuList()
            .previewDevice("iPhone 12 Pro")
            .previewLayout(.sizeThatFits)
    }
}
