////
////  SignupService.swift
////  Todo_list
////
////  Created by 이예나 on 5/28/24.
////
//
//import Foundation
//import UIKit
////(1) 라이브러리 추가
//
////베이스 url 따로 빼고, endpoint 
//
//class SignupService{
//    //(2)싱글통 객체를 선언해서 앱 어디에서든지 접근가능하도록 한다
//    static let shared = SignupService()
////
//    private init() {}
//    
//    func signup(userId : String, userPw: String, confirmUserPw: String, completion: @escaping(NetworkResult<Any>) -> Void)
//    {
//        // 통신할 api 주소
//        guard let url = URL(string: "http://na2ru2.me:5151/member/sign-up") else {
//            print("Error: cannot create URL")
//            return
//        }
//        
//        //요청 바디
//        let body : Parameters = [
//            "userId" : userId,
//            "userPw" : userPw,
//            "confirmUserPw" : confirmUserPw
//        ]
//        
//        //요청서 //Request 생성
//        //통신할 주소, HTTP메소드, 요청방식, 인코딩방식, 요청헤더
//        let dataRequest = .request(url,
//                                    method: .post,
//                                    parameters: body,
//                                    encoding: JSONEncoding.default,
//                                    headers: header)
//                                    
//        //request 시작 ,responseData를 호출하면서 데이터 통신 시작
//        dataRequest.responseData{
//            response in //데이터 통신의 결과가 response에 담기게 된다
//            switch response.result {
//            case .success: //데이터 통신이 성공한 경우에
//                guard let statusCode = response.response?.statusCode else {return}
//                guard let value = response.value else {return}
//                
//                let networkResult = self.judgeStatus(by: statusCode, value)
//                completion(networkResult)
//            case .failure:
//                completion(.networkFail)
//            }
//        }
//    }
//    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
//        switch statusCode {
//        case ..<300 : return isVaildData(data: data)
//        case 400..<500 : return .pathErr
//        case 500..<600 : return .serverErr
//        default : return .networkFail
//        }
//    }
//    //통신이 성공하고 원하는 데이터가 올바르게 들어왔을때 처리하는 함수
//    private func isVaildData(data: Data) -> NetworkResult<Any> {
//        let decoder = JSONDecoder() //서버에서 준 데이터를 Codable을 채택
//        guard let decodedData = try? decoder.decode(SignupResponse.self, from: data)
//        //데이터가 변환이 되게끔 Response 모델 구조체로 데이터를 변환해서 넣고, 그 데이터를 NetworkResult Success 파라미터로 전달
//        else { return .pathErr }
//        
//        return .success(decodedData as Any)
//    }
//}
