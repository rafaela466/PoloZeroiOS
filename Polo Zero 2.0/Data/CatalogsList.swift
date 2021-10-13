import SwiftUI
import WebKit
import WKView

let getUrlCatalogs = "https://api.npoint.io/538cb891b1d10f50fc16"
let postUrlCatalogs = "https://jsonplaceholder.typicode.com/posts"

struct CatalogsLista: Decodable, Identifiable{
    let id: Int
    let marca: String
    let imageUrl: String
    let ano: String
    let link: String
}

struct CatalogsPrecos: Decodable, Identifiable{
    let id: Int
    let marca: String
    let imageUrl: String
    let link: String
    let ano: String
    let body: String
}

class ViewModelCatalogs: ObservableObject{
    @Published var items = [CatalogsLista]()
    
    func loadData(){
        guard let url = URL(string: getUrlCatalogs) else { return }
    
        URLSession.shared.dataTask(with: url) {(data, res, err) in
            do{
                if let data = data {
                    let result = try JSONDecoder().decode([CatalogsLista].self, from: data)
                    
                    DispatchQueue.main.async {
                        self.items = result
                    }
                    
                }else{
                    print("NO DATA")
                }
            } catch (let error){
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func postData(){
        guard let url = URL(string: postUrlCatalogs) else { return }
        
        let marca = "default"
        let link = "deafult"
        let ano = "default"
        let id = 1
        
        let body: [String: Any] = ["title": marca,"link": link,"id": id, "ano": ano]
        
        let finalData = try! JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            do{
                if let data =  data {
                    let result = try JSONDecoder().decode(CatalogsPrecos.self, from: data)
                    print(result)
                }else{
                    print("NO DATA")
                }
            }catch( let error ){
                print(error.localizedDescription)
            }
        }.resume()
    }
}

struct CatalogsList: View {
    @ObservedObject var viewModelCatalogs = ViewModelCatalogs()
    @State var selectedItem: CatalogsLista?
    
  
    
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVGrid(columns: gridLayout, spacing: 15, content: {
                    ForEach(viewModelCatalogs.items, id: \.id) { item in
                        VStack(alignment: .leading, spacing: 0){
                          
                            if(item.id == 1 ){
                                NavigationLink(destination: SamsungList()) {
                                    Image(item.imageUrl)
                                        .resizable()
                                        .scaledToFit()
                                        .padding(10)
                                }
                            }else if (item.id == 4 || item.id == 7 || item.id == 8 || item.id == 9 || item.id == 10 || item.id == 11 || item.id == 12 || item.id == 13 || item.id == 14 || item.id == 15 || item.id == 16){
                                Button(action: { selectedItem = item}, label: {
                                Image(item.imageUrl)
                                    .resizable()
                                    .scaledToFit()
                                    .padding(10)
                                })
                            }
                          
                            NavigationLink(destination: DaikinList()) {
                                if(item.id == 2){
                                Image(item.imageUrl)
                                    .resizable()
                                    .scaledToFit()
                                    .padding(10)
                                }
                            }
                            
                            NavigationLink(destination: DaitsuList()) {
                                if(item.id == 3){
                                Image(item.imageUrl)
                                    .resizable()
                                    .scaledToFit()
                                    .padding(10)
                                }
                            }
                            
                            NavigationLink(destination: MitsubishiList()) {
                                if(item.id == 5){
                                Image(item.imageUrl)
                                    .resizable()
                                    .scaledToFit()
                                    .padding(10)
                                }
                            }
                            
                            NavigationLink(destination: HTWList()) {
                                if(item.id == 6){
                                Image(item.imageUrl)
                                    .resizable()
                                    .scaledToFit()
                                    .padding(10)
                                }
                            }
                            
                            NavigationLink(destination: WigamList()) {
                                if(item.id == 17){
                                Image(item.imageUrl)
                                    .resizable()
                                    .scaledToFit()
                                    .padding(10)
                                }
                            }
                        }//:VSTACK
                        .scaledToFit()
                        .padding()
                        .background(Color.white.cornerRadius(12))
                        .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 1))
                    } //: LOOP
                })//: GRID
                    .padding(5)
                    .onAppear(perform: {
                    viewModelCatalogs.loadData()
                    viewModelCatalogs.postData()
                    }).sheet(item: $selectedItem, content: { selectedItem in
                        WebView(url: selectedItem.link)
                    })
                
            }//:SCROLL
            .navigationBarHidden(true)
            .navigationBarTitle("Voltar")
        }//: NAV VIEW
    } //:body
}

struct CatalogsList_Previews: PreviewProvider {
    static var previews: some View {
        CatalogsList()
            .previewDevice("iPhone 12 Pro")
            .previewLayout(.sizeThatFits)
    }
}
