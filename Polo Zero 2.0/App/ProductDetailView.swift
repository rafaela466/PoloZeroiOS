//
//  ProductDetailView.swift
//  Polo Zero 2.0
//
//  Created by Rafaela Santos on 12/05/2021.
//

import SwiftUI

struct ProductDetailView: View {
    // MARK: - PROPERTY
    
    @EnvironmentObject var shop: Shop
    
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .leading, spacing: 5, content: {
            // NAVBAR
            NavigationBarDetailView()
                .padding(.horizontal)
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
            // HEADER
            HeaderDetailView()
                .padding(.horizontal)
            // DETAIL TOP PART
            TopPartDetailView()
                .padding(.horizontal)
                .zIndex(1)
         
// ------------------------------------- DETAIL BOTTOM PART --------------------------------------------
            // LazyVGrid(columns: gridLayout, spacing: 15, content:
            VStack(alignment: .center, spacing: 5, content: {
                
                if(shop.selectedProduct?.id == 1){             // Tabelas de Preços
                    PricesList()
                        .zIndex(1)
                }else if(shop.selectedProduct?.id == 2){       // Catálogos
                    CatalogsList()
                        .zIndex(1)
                }else if(shop.selectedProduct?.id == 3){       // Contactos
                    ContactosDetailView()
                         .zIndex(1)
                }else if(shop.selectedProduct?.id == 4){       // Promoções
                    PromocoesDetailView()
                         .zIndex(1)
                 }
                else if(shop.selectedProduct?.id == 5){        // Lojas
                    LocationButtonView()
                         .zIndex(1)
                }
                else if(shop.selectedProduct?.id == 7){        // Vídeos
                    VideosDetailView()
                        .zIndex(1)
                }
                

                
 // ------------------------------------- :DETAIL BOTTOM PART --------------------------------------------
               
                //FAVORITAR
                //   QualityFavouriteDetailView()
         
            })//:VSTACK
            .padding(.horizontal)
            .background(
             Color.white
                .clipShape(CustomShape())
                .padding(.top, -105)
            )
        
        })//:VSTACK
        .zIndex(0)
        .ignoresSafeArea(.all, edges: .all)
        .background(
            Color(red: shop.selectedProduct?.red ?? sampleProduct.red,
                  green: shop.selectedProduct?.green ?? sampleProduct.green,
                  blue: shop.selectedProduct?.blue ?? sampleProduct.blue) .ignoresSafeArea(.all, edges: .all))
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView()
            .previewDevice("iPhone 12 Pro")
            .environmentObject(Shop())
            .previewLayout(.fixed(width: 375, height: 812))
    }
}
