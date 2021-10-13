//
//  MitsubishiList.swift
//  Polo Zero 2.0
//
//  Created by Rafaela Santos on 01/07/2021.
//

import SwiftUI
import WKView

let getUrlMistu = "https://api.npoint.io/685b0d04e3b09eadfaed"
let postUrlMitsu = "https://jsonplaceholder.typicode.com/posts"

//JSON Variables
struct PrecosMitsuList: Decodable, Identifiable {
    let id: Int
    let marca: String
    let imageUrl: String
    let ano: String
    let link: String
}

struct PostMitsuList: Decodable, Identifiable {
    let id: Int
    let marca: String
    let imageUrl: String
    let ano: String
    let link: String
    let body: String
}

class ViewModelMitsu: ObservableObject{
    @Published var items = [PrecosMitsuList]()
    
    func loadData(){
        guard let url = URL(string: getUrlMistu) else { return }
        
        URLSession.shared.dataTask(with: url){ (data, res, err) in
            do{
                if let data = data {
                    let result = try JSONDecoder().decode([PrecosMitsuList].self, from: data)
                
                    DispatchQueue.main.async {
                        self.items = result
                    }
                }else{
                    print("no data")
                }
            }catch(let error){
                print(error.localizedDescription)
            }
        }.resume()
    }
    
//Se houver algum erro no JSON ele não vai ser os dados e vai mostrar a página em branco  
    func postData(){
        guard let url = URL(string: postUrlMitsu) else { return }

        let marca = "default"
        let link = "deafult"
        let ano = "default"
        let id = 1
        
        let body: [String: Any] = ["title": marca, "link": link, "id": id, "ano": ano]
        
        let finalData = try! JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalData
        request.setValue("application/JSON", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            do{
                if let data = data{
                    let result = try JSONDecoder().decode(PostMitsuList.self, from: data)
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

struct MitsubishiList: View {
    @ObservedObject var viewModel = ViewModelMitsu()
    @State var selectedItem: PrecosMitsuList?
    
    var body: some View {
        NavigationView{
            ScrollView{
                HStack {
                Text("Mitsubishi")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, -40)
                Spacer()
            }.padding(.leading)
                LazyVGrid(columns: gridLayout, spacing: 15, content: {
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
                        }//:VSTACK
                        .scaledToFit()
                        .padding()
                        .background(Color.white.cornerRadius(12))
                        .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 1))
                    }//: LOOP FOR EACH
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

struct MitsubishiList_Previews: PreviewProvider {
    static var previews: some View {
        MitsubishiList()
            .previewDevice("iPhone 12 Pro")
            .previewLayout(.sizeThatFits)
    }
}
