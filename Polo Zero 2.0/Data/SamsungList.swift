//
//  SamsungList.swift
//  Polo Zero 2.0
//
//  Created by Rafaela Santos on 01/07/2021.
//

import SwiftUI
import UIKit
import WKView

let getUrlSamsung = "https://api.npoint.io/7717943195672c8bfd94"
let postUrlSamsung = "https://jsonplaceholder.typicode.com/posts"

//Model
struct PrecosSamsungList: Decodable, Identifiable {
    let id: Int
    let marca: String
    let imageUrl: String
    let ano: String
    let link: String
}

struct PostSamsungList: Decodable, Identifiable {
    let id: Int
    let marca: String
    let imageUrl: String
    let ano: String
    let link: String
    let body: String
}

//ViewModelSamsung
class ViewModelSamsung: ObservableObject{
    @Published var items = [PrecosSamsungList]()
    
    func loadData(){
        guard let url = URL(string: getUrlSamsung) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            do{
                if let data = data {
                    let result = try JSONDecoder().decode([PrecosSamsungList].self, from: data)
                    
                    DispatchQueue.main.async {
                        self.items = result
                    }
                }else {
                    print("NO DATA")
                }
            }catch (let error){
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func postData(){
        guard let url = URL(string: postUrlSamsung) else { return }
    
    let marca = "default"
    let link = "default"
    let ano = "default"
    let id = 1
        
        let body: [String: Any] = ["title": marca,"link": link, "id": id, "ano": ano]
        
        let finalData = try! JSONSerialization.data(withJSONObject: body)
        
    var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalData
        request.setValue("application/JSON", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: url){ (data, res, err) in
            do{
                if let data =  data{
                    let result = try JSONDecoder().decode(PostSamsungList.self, from: data)
                    print(result)
                }else{
                    print("No data!")
                }
            } catch(let error){
                print(error.localizedDescription)
            }
        }.resume()
    }
}
// -------------------------------------------------------------------------
struct SamsungList: View {
    @ObservedObject var viewModel = ViewModelSamsung()
    @State var selectedItem: PrecosSamsungList?
    
    
    var body: some View {
        NavigationView{
            ScrollView{
                HStack {
                Text("Samsung")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, -40)
                Spacer()
            }.padding(.leading)
                LazyVGrid(columns: gridLayout,spacing: 15, content: {
                    ForEach(viewModel.items, id: \.id) { item in
                        VStack(alignment: .leading, spacing: 5){
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
            }
            .navigationBarHidden(true)
            .navigationBarTitle("Voltar")
        }//: NAVIGATION VIEW
    }//: BODY
}


struct SamsungList_Previews: PreviewProvider {
    static var previews: some View {
        SamsungList()
            .previewDevice("iPhone 12 Pro")
            .previewLayout(.sizeThatFits)
            
    }
}
