//
//  PricesList.swift
//  Polo Zero 2.0
//
//  Created by Rafaela Santos on 29/06/2021.
//

import SwiftUI
import WebKit
import WKView

let getUrl = "https://api.npoint.io/20ce2aa1e547b10e734a"
let postUrl = "https://jsonplaceholder.typicode.com/posts"

//Model
struct PrecosLista: Decodable, Identifiable{
    let id: Int
    let marca: String
    let imageUrl: String
    let ano: String
    let link: String
}

struct PostPrecos: Decodable, Identifiable{
    let id: Int
    let marca: String
    let imageUrl: String
    let link: String
    let ano: String
    let body: String
}


//ViewModel
class ViewModel: ObservableObject{
    @Published var items = [PrecosLista]()
    
    func loadData(){
        guard let url = URL(string: getUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            do{
                if let data = data {
                    let result = try JSONDecoder().decode([PrecosLista].self, from: data)
                    
                    DispatchQueue.main.async {
                        self.items = result
                    }
                }else {
                    print("No Data")
                }
                
            } catch (let error) {
                print(error.localizedDescription)
            }
        }.resume()
    }
    func postData(){
        guard let url = URL(string: postUrl) else { return }
        
        let marca = "default"
        let link = "default"
        let ano = "default"
        let id = 1
        
        let body: [String: Any] = ["title": marca, "link": link,"id": id, "ano": ano]
        
        let finalData = try! JSONSerialization.data(withJSONObject: body)
        
        // Requesting Method for JSON File
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") 
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            do{
                if let data = data {
                    
                    let result = try JSONDecoder().decode(PostPrecos.self, from: data)
                    print(result)
                
                }else {
                    print("No Data")
                }
                
            } catch (let error) {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

struct PricesList: View{
    @ObservedObject var viewModel = ViewModel()
    @State var selectedItem: PrecosLista?
    var body: some View{
        NavigationView{
        ScrollView {
            LazyVGrid(columns: gridLayout, spacing: 15, content:  {
                ForEach(viewModel.items, id: \.id) { item in
                    VStack(alignment: .leading, spacing: 5){
                    
                       Button(action: { selectedItem = item }, label: {
                            Image(item.imageUrl)
                                .resizable()
                                .scaledToFit()
                                .padding(10)
                        })
                    
                    //Navigation Link not working with .sheet (WebView) 
                  /* NavigationLink(destination: WebView(url: item.link, tintColor: .blue, titleColor: .blue, backText: Text("Voltar")),
                                    label: {
                                            Image(item.imageUrl)
                                                .resizable()
                                                .scaledToFit()
                                                .padding(10)
                                            })
                         */
                    }//: VSTACK
                    .scaledToFit()
                    .padding()
                    .background(Color.white.cornerRadius(12))
                    .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 1))
                }//: LOOP FOR EACH
            }).padding(5)
                .onAppear(perform: {
                viewModel.loadData()
                viewModel.postData()
                }).sheet(item: $selectedItem, content: { selectedItem in
               WebView(url: selectedItem.link)
            })
            }   .navigationBarHidden(true)
        }//: NAVIGATION VIEW
    } //: BODY
}

struct PricesList_Previews: PreviewProvider{
    static var previews: some View{
        PricesList()
            .previewDevice("iPhone 12 Pro")
            .previewLayout(.sizeThatFits)
    }
}
