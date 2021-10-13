//
//  BtuCalculator.swift
//  Polo Zero 2.0
//  Created by Rafaela Santos on 29/09/2021.
//

import SwiftUI

struct BtuCalculator: View {
    @Binding var isPresented: Bool
    @State private var temSol = false
    @State private var temElectro = false
    
    @State var areaA: String = ""
    @State var janelasB: String = ""
    @State var paredesC: String = ""
    @State var resultD: String = ""
    @State var temSolE: String = ""
    @State var pessoasF: String = ""
    @State var resultadoF: String = ""
    @State var sliderValG: String = ""
    @State var btusHora: String = ""
    @State var resultIs: String = ""
    @State var resultFinal: String = ""
    @State var mostrarD: Double
    @State var mostrarE: Int
    @State var mostrarF: Int
    @State var mostrarG: Int
    @State var mostrarResultado: Int
    
    
    
    
    var body: some View {
        VStack{
            NavigationBarBtuCalc()
                .padding(.horizontal, 15)
                .padding(.bottom)
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5 )
            VStack{
                VStack{
            
                    Text("Calculadora de BTUs")
                        .font(.system(size: 20, weight: .semibold))
                        .padding(.top, -60)
                    
                    HStack {
                        Image(systemName: "house")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24)
                            .foregroundColor(.blue)
                        TextField("Área em m2", text: $areaA)
                            .font(Font.system(size: 20))
                            .frame(width: UIScreen.main.bounds.width * 0.8)
                            .background(Color.clear)
                            .keyboardType(.numberPad)
                    }
                    Divider()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
                        .padding(.horizontal)
                    
                    HStack {
                        Image(systemName: "uiwindow.split.2x1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24)
                            .foregroundColor(.blue)
                        TextField("Superfície janela em m2", text: $janelasB)
                            .font(Font.system(size: 20))
                            .frame(width: UIScreen.main.bounds.width * 0.8)
                            .keyboardType(.numberPad)
                    }
                    Divider()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
                        .padding(.horizontal)
                    
                    
                    HStack {
                        Image(systemName: "tv")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24)
                            .foregroundColor(.blue)
                        TextField("Comprimento das paredes", text: $paredesC)
                            .font(Font.system(size: 20))
                            .frame(width: UIScreen.main.bounds.width * 0.8)
                            .background(Color.clear)
                            .keyboardType(.numberPad)
                    }
                    Divider()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
                        .padding(.horizontal)
                    
                    HStack {
                        Image(systemName: "person")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24)
                            .foregroundColor(.blue)
                        TextField("Número de pessoas", text: $pessoasF)
                            .font(Font.system(size: 20))
                            .frame(width: UIScreen.main.bounds.width * 0.8)
                            .background(Color.clear)
                            .keyboardType(.numberPad)
                    }
                    Divider()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
                        .padding(.horizontal)
                
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 400, maxHeight: .infinity)
                
                VStack{
                    HStack {
                        Image(systemName: "sun.max")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24)
                            .foregroundColor(.blue)
                          Toggle("Tem luz solar?", isOn: $temSol)
                              .font(Font.system(size: 17))
                              .frame(width: UIScreen.main.bounds.width * 0.8)
                              .toggleStyle(SwitchToggleStyle(tint: .blue))
                          }
                          Divider()
                              .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
                              .padding(.horizontal)
                    HStack {
                        Image(systemName: "tv.and.hifispeaker.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24)
                            .foregroundColor(.blue)
                          Toggle("Tem muitos eletrodomésticos?", isOn: $temElectro)
                              .font(Font.system(size: 17))
                              .frame(width: UIScreen.main.bounds.width * 0.8)
                              .toggleStyle(SwitchToggleStyle(tint: .blue))
                          }
                          Divider()
                              .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
                              .padding(.horizontal)
                }.padding(.top,-113)
                
                VStack {
                    Text("\(mostrarResultado)")
                        .font(.title)
                        .foregroundColor(Color(red: 0.04, green: 0.05, blue: 0.13))

                    Text(resultIs)
                        .font(.largeTitle)
                        .foregroundColor(Color(red: 0.04, green: 0.05, blue: 0.13))
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .padding()
            }
          
        HStack{
            Button(action: {
                let numArea = Int(self.areaA)
                let numJanelas = Int(self.janelasB)
                let numParedes = Int(self.paredesC)
                let numPessoas = Int(self.pessoasF)
               
                if numArea != nil, numJanelas != nil, numPessoas != nil {
                    let resultadoD = Double((numArea! * 100) + (numJanelas! * 1040) + (numParedes! * 200))
                    // self.resultD = "\(resultadoD)"
                    self.mostrarD = resultadoD
                    
                    let resultF = Int(numPessoas! * 600)
                     //  self.resultadoF = "\(resultF)"
                     self.mostrarF = resultF
                    
                    
                    
                        if temSol {
                            let resultadoE = Int(resultadoD * 1.3)
                        //  self.temSolE = "\(resultadoE)"
                            self.mostrarE = resultadoE
                        }else if temSol == false  {
                     
                        let resultadoE = mostrarD
                         self.mostrarE = Int(resultadoE)
                            
                        
                        /*     let resultadoE = Int(resultadoD * 0)
                        //  self.temSolE = "\(resultadoE)"
                            self.mostrarE = resultadoE */
                        }
                   
                    
                        if temElectro {
                            let resultG = 2000
                            self.mostrarG = resultG
                          //  self.sliderValG = "\(resultG)"
                        }else if temElectro == false {
                            let resultG = 0
                            self.mostrarG = resultG
                          //  self.sliderValG = "\(resultG)"
                        }
                    
                   let resultadoFinal = (mostrarE + mostrarF + mostrarG)
                   self.mostrarResultado = resultadoFinal
                // self.resultFinal = String(resultadoFinal)
                   
                  self.resultIs = "BTUs/hora"
                    
                }else {
                    print("Preencher tudo")
                    print(mostrarResultado)
                }
            }){ Text("Calcular")
                .font(.system(.title2, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(15)
                .background(Color(red: sampleProduct.red, green: sampleProduct.green, blue: sampleProduct.blue)).clipShape(Capsule())
            }
        }
    }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color(.white))
        .edgesIgnoringSafeArea(.all)
        .padding(.bottom)
       
    }// some VIEW
}//VIEW

struct BtuCalculator_Previews: PreviewProvider {
    static var previews: some View {
        BtuCalculator(isPresented: .constant(false), mostrarD: 0, mostrarE: 0, mostrarF: 0, mostrarG: 0, mostrarResultado: 0)
            
    }
}
