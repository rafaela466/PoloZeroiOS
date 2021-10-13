//
//  DaikinList.swift
//  Polo Zero 2.0
//
//  Created by Rafaela Santos on 01/07/2021.
//

import SwiftUI
import WKView

let getUrlDaikin = "https://api.npoint.io/b26e88846f53bea86446"
let postUrlDaikin = "https://jsonplaceholder.typicode.com/posts"

//JSON VARIABLES
struct PrecosDaikinList: Decodable, Identifiable{
    let id: Int
    let marca: String
    let imageUrl: String
    let ano: String
    let link: String
}

struct PostDaikinList: Decodable, Identifiable{
    let id: Int
    let marca: String
    let imageUrl: String
    let ano: String
    let link: String
    let body: String
}


//ViewModelDaikin
class ViewModelDaikin: ObservableObject{
    @Published var items = [PrecosDaikinList]()
    
    func loadData(){
        guard let url = URL(string: getUrlDaikin) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, res, err ) in
            do{
                if let data = data {
                    let result = try JSONDecoder().decode([PrecosDaikinList].self, from: data)
                    
                    DispatchQueue.main.async{
                            self.items = result
                        }
                    }else{
                        print("NO DATA")
                }
            }catch (let error) {
                print(error.localizedDescription)
            }
        }.resume()
    }

    func postData(){
        guard let url = URL(string: postUrlDaikin) else { return }
        
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
        
        URLSession.shared.dataTask(with: url) {(data, res ,err) in
            do{
                if let data = data{
                    let result = try JSONDecoder().decode(PostDaikinList.self, from: data)
                    print(result)
                }else{
                    print("No Data!")
                }
            }catch (let error){
                print(error.localizedDescription)
            }
        }.resume()
    }
}

struct DaikinList: View {
    @ObservedObject var viewModel = ViewModelDaikin()
    @State var selectedItem: PrecosDaikinList?
    
    var body: some View {
        NavigationView{
            ScrollView{
                HStack {
                Text("Daikin")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, -40)
                Spacer()
            }.padding(.leading)
                LazyVGrid(columns: gridLayout, spacing: 15, content: {
                    ForEach(viewModel.items, id: \.id) { item in
                        VStack(spacing: 15){
                            
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
                    } //:FOREACH LOOP
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

struct DaikinList_Previews: PreviewProvider {
    static var previews: some View {
        DaikinList()
            .previewDevice("iPhone 12 Pro")
            .previewLayout(.sizeThatFits)
    }
}
