//
//  CategoriasPzGridView.swift
//  Polo Zero 2.0
//
//  Created by Rafaela Santos on 20/09/2021.
//

import SwiftUI
import WKView
import WebKit

let getUrlPZ = "https://api.npoint.io/a1adb5001aa703718a6b"
let postUrlPZ = "https://jsonplaceholder.typicode.com/posts"

struct ListaCatalogosPz: Decodable, Identifiable{
    let id: Int
    let name: String
    let image: String
    let link: String
}

struct PostListaCatalogosPz: Decodable, Identifiable{
    let id: Int
    let name: String
    let image: String
    let link: String
}

class ViewModelCatPz: ObservableObject{
     @Published var items = [ListaCatalogosPz]()
    
    func loadDataPz(){
        guard let url = URL(string: getUrlPZ) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            do{
                if let data = data{
                    let result = try JSONDecoder().decode([ListaCatalogosPz].self, from: data)
                    
                    DispatchQueue.main.async {
                        self.items = result
                    }
                }else{
                    print("no data")
                }
            }catch(let error){
                print(error.localizedDescription)
            }
        }  .resume()
    }
    
    func postDataPz(){
        guard let url = URL(string: postUrlPZ) else { return }
      
        let id = 1
        let name = "deafult"
        let link =  "defult"
    
        let body: [String: Any] = ["name": name, "link": link, "id": id]
        
        let finalData = try! JSONSerialization.data(withJSONObject: body)
        
        // Requesting Method for JSON File
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            do{
                if let data = data {
                    
                    let result = try JSONDecoder().decode(PostListaCatalogosPz.self, from: data)
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

struct CategoriasPzGridView: View {
    @ObservedObject var viewModel = ViewModelCatPz()
    @State var selectedItem: ListaCatalogosPz?
    
    var body: some View {
   
        ScrollView(.horizontal, showsIndicators: false, content: {
            LazyHGrid(rows: gridLayout,alignment: .center, spacing: columnSpacing, pinnedViews: [],content:{
                Section(
                    header: SectionView(rotateClockwise: false),
                    footer: SectionView(rotateClockwise: true)
                ){
                ForEach(viewModel.items, id: \.id){ item in
              //      CategoryItemView(category: category)
                    VStack(alignment: .leading, spacing: 5){
                    Button(action: {selectedItem = item }, label: {
                        Image(item.image)
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30, alignment: .center)
                            .foregroundColor(.gray)
                        
                        Text(item.name.uppercased())
                            .fontWeight(.light)
                            .foregroundColor(.gray)
                        
                        Spacer()
                    })
                }//: VSTACK
                    .padding()
                    .background(Color.white.cornerRadius(12))
                    .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 1))
               }//: FOREACH
              }
            })//: LazyHGrid
            .frame(height: 140)
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .onAppear(perform: {
                viewModel.loadDataPz()
                viewModel.postDataPz()
                }).sheet(item: $selectedItem, content: { selectedItem in
               WebView(url: selectedItem.link)
            })
        })//:ScrollView
    }
}

struct CategoriasPzGridView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriasPzGridView()
            .previewLayout(.sizeThatFits)
            .padding()
            .background(colorBackground)
    }
}
