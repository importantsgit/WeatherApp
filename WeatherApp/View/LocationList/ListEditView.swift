//
//  ListEditView.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/10.
//

import SwiftUI

struct ListEditView: View {
    @EnvironmentObject var manager: CoreDataManager
    @State private var title = ""
    @State private var phoneNumber = ""
    @State private var address = ""
    @State private var description = ""
    @State private var tag = ""
    @State private var showInputAlert = false
    
    var placeMark: PlaceMarkEntity? = nil
    
    /**MapView에서 dismiss됐을 때, 다시 onAppear를 호출하는 문제를 해결하기 위한 대책*/
    @State private var isFirstAppear: Bool = false
    
    @Environment(\.dismiss) var dismiss
    
    enum FieldType: Int, Hashable {
        case title = 0
    }
    
    @FocusState private var focusedField: FieldType?
    
    var body: some View {
        Form {
            Section {
                TextField("제목을 입력하세요", text: $title)
                    .focused($focusedField, equals: .title)

            } header: {
                Text("제목")
            }
            
            Section {
                TextField("전화번호를 입력하세요 (- 제외)", text: $phoneNumber)
                    .keyboardType(.numberPad)
                
                NavigationLink {
                    DetailMapView(address: $address)
                } label: {
                    Text(address == "" ? "위치 선택" : address)
                }
            } header: {
                Text("상세정보 (선택사항)")
            }

            Section {
                TextEditor(text: $description)
                    .frame(height: 200)
            } header: {
                Text("설명을 입력하세요")
            }
            
            Section {
                TextField("태그 뒤에 , 를 붙여주세요", text: $tag)
                    .submitLabel(.done)
            } header: {
                Text("태그를 입력하세요")
            }
            

        }
        .onAppear {
            if isFirstAppear == false,
               let placeMark = placeMark {
                title = placeMark.title ?? ""
                phoneNumber = placeMark.phoneNumber ?? ""
                description = placeMark.body ?? ""
                tag = placeMark.tag ?? ""
                address = placeMark.address ?? ""
                
                isFirstAppear = true
            }
        }
        .autocorrectionDisabled(true)
        .navigationTitle(placeMark == nil ? "새로운 장소 생성" : "장소 편집")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                
                Button("done") {
                    hideKeyBoard()
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Text("뒤로가기")
                            .font(.system(size: 16, weight: .medium))
                            .frame(width: 132, height: 32)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color.secondary)
                    
                    Button {
                        let content = PlaceMark(title: self.title, phoneNumber: self.phoneNumber, address: self.address, description: self.description, tag: self.tag)
                        
                        if title != "" {
                            if let placeMark = placeMark { // 원래 있다면 (수정)
                                manager.update(placeMark: placeMark, content: content)
                            } else { // 없다면 (수정x)
                                manager.addPlaceMark(content: content)
                            }
                            
                            dismiss()
                        } else {
                            showInputAlert = true
                        }

                    } label: {
                        Text(placeMark == nil ? "추가하기" : "수정하기")
                            .font(.system(size: 16, weight: .medium))
                            .frame(width: 132, height: 32)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color.black)
                    .alert("경고", isPresented: $showInputAlert) {
                        Button {
                            
                            focusedField = .title
                        } label: {
                            Text("제목입력")
                        }
                    } message: {
                        Text("제목을 입력해야 합니다.")
                    }
                }
                
            }
        }
    }
}

struct ListEditView_Previews: PreviewProvider {
    static var previews: some View {
        ListEditView()
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyBoard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif


struct NumberTextField<Value: BinaryInteger>: UIViewRepresentable {
    @Binding var value: Value
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.delegate = context.coordinator
        textField.inputAccessoryView = createToolbar()
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = "\(value)"
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(value: $value)
    }
    
    private func createToolbar() -> UIToolbar {
        // if you want behavior other than "dismiss", put it in action:
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(UIApplication.dismissKeyboard))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.items = [spacer, doneButton]

        // you may want to check the locale for right-to-left orientation,
        // if it doesn't automatically re-orient the sequence of items.

        return toolbar
    }

    // I don't recall where I got this code, its purpose is mostly to
    // filter out non-numeric values from the input, it may be suboptimal
    class Coordinator: NSObject, UITextFieldDelegate {
        var value: Binding<Value>
        
        init(value: Binding<Value>) {
            self.value = value
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            // if you use a different protocol than BinaryInteger
            // you will most likely have to change this behavior
            guard let text = textField.text else { return }
            guard let integer = Int(text) else { return }
            value.wrappedValue = Value(integer)
        }
    }
}

extension UIApplication {
    @objc
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
