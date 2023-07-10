//
//  ListEditView.swift
//  WeatherApp
//
//  Created by 이재훈 on 2023/07/10.
//

import SwiftUI

struct ListEditView: View {
    @ObservedObject var service: DetailListService
    @State private var title = ""
    @State private var phoneNumber = ""
    @State private var address = ""
    @State private var description = ""
    @State private var tag = ""
    @State private var showInputAlert = false
    
    @Environment(\.dismiss) var dismiss
    
    enum FieldType: Int, Hashable {
        case title = 0
        case phoneNumber = 1
        case address = 2
        case description = 3
        case tag = 4
    }
    
    @FocusState private var focusedField: FieldType?
    
    var body: some View {
        NavigationStack {
            
            Form {
                Section {
                    TextField("제목을 입력하세요", text: $title)
                        .focused($focusedField, equals: .title)
                        .submitLabel(.next)
                        .onSubmit {
                            focusedField = .phoneNumber
                        }
                } header: {
                    Text("제목")
                }
                
                Section {
                    TextField("전화번호를 입력하세요 (- 제외)", text: $phoneNumber)
                        .keyboardType(.numberPad)
                        .focused($focusedField, equals: .phoneNumber)
                    
                    TextField("주소를 입력하세요", text: $address)
                        .submitLabel(.next)
                        .focused($focusedField, equals: .address)
                        .onSubmit {
                            focusedField = .description
                        }
                } header: {
                    Text("상세정보")
                }

                Section {
                    TextEditor(text: $description)
                        .focused($focusedField, equals: .description)
                        .frame(height: 200)
                        .onSubmit {
                            focusedField = .tag
                        }
                } header: {
                    Text("설명을 입력하세요")
                }
                
                TextField("태그", text: $tag)
                    .submitLabel(.done)
                    .focused($focusedField, equals: .tag)
                    .onSubmit {
                        hideKeyBoard()
                    }
            }
            .autocorrectionDisabled(true)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    focusedField = .title
                }
            }
            .navigationTitle("새로운 장소 생성")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    if focusedField == .description {
                        Button("next") {
                            focusedField = .tag
                        }
                    } else if focusedField == .phoneNumber {
                        Button("next") {
                            focusedField = .address
                        }
                    }
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
                            if phoneNumber.count == 11 {
                                let place = PlaceMark(id: UUID(), title: title, phoneNumber: phoneNumber, address: address, placePhoto: Image(systemName: "hand.thumbsup"), description: description, tag: tag)
                                service.placeMark.append(place)
                                dismiss()
                            } else {
                                showInputAlert = true
                            }

                        } label: {
                            Text("추가하기")
                                .font(.system(size: 16, weight: .medium))
                                .frame(width: 132, height: 32)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(Color.black)
                        .alert("경고", isPresented: $showInputAlert) {
                            Button {
                                focusedField = .phoneNumber
                            } label: {
                                Text("전화번호 다시 입력하기")
                            }
                        } message: {
                            Text("전화번호를 11자리로 입력해주세요")
                        }
                    }
                    
                }
            }
        }


    }
}

struct ListEditView_Previews: PreviewProvider {
    static var previews: some View {
        ListEditView(service: DetailListService())
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
