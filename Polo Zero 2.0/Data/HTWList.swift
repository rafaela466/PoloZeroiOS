//
//  HTW List.swift
//  Polo Zero 2.0
//
//  Created by Rafaela Santos on 01/07/2021.
//

import SwiftUI
import WKView

let getUrlHtw = "https://api.npoint.io/c51a951784b84a05e086"
let postUrlHtw = "https://jsonplaceholder.typicode.com/posts"

struct PrecosHtwList: Decodable, Identifiable{
    let id: Int
    let marca: String
    let imageUrl: String
    let ano: String
    let link: String
}

struct PostHtwList: Decodable, Identifiable{
    let id: Int
    let marca: String
    let imageUrl: String
    let ano: String
    let link: String
    let body: String
}

class ViewModelHtw: ObservableObject{
    @Published var items = [PrecosHtwList]()
    
    func loadData(){
        guard let url = URL(string: getUrlHtw) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            do{
                if let data = data{
                    let result = try JSONDecoder().decode([PrecosHtwList].self, from: data)
                    
                    DispatchQueue.main.async {
                        self.items = result
                    }
                }else{
                    print("no data!")
                }
            }catch(let error){
                print(error.localizedDescription)
            }
        }.resume()
    }

    func postData(){
        guard let url = URL(string: postUrlHtw) else { return }
        
        let marca = "default"
        let link = "deafult"
        let ano = "default"
        let id = 1
    
        let body: [String: Any] = ["title": marca, "link": link, "id": id,"ano":ano]
        
        let finalData = try! JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalData
        request.setValue("application/JSON", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: url){ (data, res, err) in
            do{
                if let data = data{
                    let result = try JSONDecoder().decode(PostHtwList.self, from: data)
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

struct HTWList: View {
    @ObservedObject var viewModel = ViewModelHtw()
    @State var selectedItem: PrecosHtwList?
    
    var body: some View {
        NavigationView{
            ScrollView{
              HStack {
                Text("HTW")
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
                        }//: VSTACK
                        .scaledToFit()
                        .padding()
                        .background(Color.white.cornerRadius(12))
                        .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 1))
                    }//: LOOP
                }).padding(5)
                .onAppear(perform: {
                viewModel.loadData()
                viewModel.postData()
                }).sheet(item: $selectedItem, content: { selectedItem in
                    WebView(url: selectedItem.link)
                })
            }.navigationBarHidden(true)
        }//: NAV
    }//: BODY
}

struct HTWList_Previews: PreviewProvider {
    static var previews: some View {
        HTWList()
            .previewDevice("iPhone 12 Pro")
            .previewLayout(.sizeThatFits)
    }
}
