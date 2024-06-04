//
//  NetworkResult.swift
//  Todo_list
//
//  Created by 이예나 on 5/28/24.
//

import Foundation

enum NetworkResult<T> {
    case success(T) //서버 통신 성공
    case requestErr(T) //요청 에러 발생
    case pathErr //경로 에러
    case serverErr //서버 내부 에러
    case networkFail //네트워크 연결 실패
}
