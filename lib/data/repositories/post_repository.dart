import 'package:dio/dio.dart';
import 'package:flutter_blog/_core/constants/http.dart';
import 'package:flutter_blog/data/dtos/response_dto.dart';
import 'package:flutter_blog/data/models/post.dart';
import 'package:logger/logger.dart';

import '../dtos/poset_request.dart';

class PostRepository {
  static final PostRepository _instance = PostRepository._single(); // (1) _instance

  factory PostRepository() {
    // (2) PostRepository
    return _instance;
  }

  PostRepository._single(); // (3) PostRepository._single()

  // 목적 : 통신 + 파싱
  Future<ResponseDTO> fetchPostList(String jwt) async {
    try {
      // 통신
      Response response = await dio.get("/post", options: Options(headers: {"Authorization": "$jwt"}));

      // 응답 받은 데이터 파싱
      ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);

      // 응답 데이터가 Post 객체인지 확인 후 처리
      if (responseDTO.success && responseDTO.data is List<dynamic>) {
        List<Post> postList = (responseDTO.data as List<dynamic>).map((e) => Post.fromJson(e)).toList();
        responseDTO.data = postList;
      }

      return responseDTO;
    } catch (e) {
      return ResponseDTO(errorMessage: "실패 : ${e}", success: false, status: -1);
    }
  }

  Future<ResponseDTO> fetchPost(String jwt, int id) async {
    try {
      // 통신
      Response response = await dio.get("/post/$id", options: Options(headers: {"Authorization": "$jwt"}));

      // 응답 받은 데이터 파싱
      ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);

      // 응답 데이터가 Post 객체인지 확인 후 처리
      if (responseDTO.success) {
        responseDTO.data = Post.fromJson(responseDTO.data);
      }

      return responseDTO;
    } catch (e) {
      return ResponseDTO(errorMessage: "실패 : ${e}", success: false, status: -1);
    }
  }

  Future<ResponseDTO> savePost(String jwt, PostSaveReqDTO postSaveReqDTO) async {
    try {
      // 통신
      Response response = await dio.post("/post", options: Options(headers: {"Authorization": "$jwt"}), data: postSaveReqDTO.toJson());

      // 응답 받은 데이터 파싱
      ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);

      // 응답 데이터가 Post 객체인지 확인 후 처리
      if (responseDTO.success) {
        responseDTO.data = Post.fromJson(responseDTO.data);
      }

      return responseDTO;
    } catch (e) {
      return ResponseDTO(errorMessage: "실패 : ${e}", success: false, status: -1);
    }
  }

  Future<ResponseDTO> updatePost(String jwt, int id, PostUpdateReqDTO postUpdateReqDTO) async {
    try {
      // 통신
      Response response = await dio.put(
        "/post/$id",
        options: Options(headers: {"Authorization": "$jwt"}),
        data: postUpdateReqDTO.toJson(),
      );

      // 응답 받은 데이터 파싱
      ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);

      // 응답 데이터가 Post 객체인지 확인 후 처리
      if (responseDTO.success) {
        responseDTO.data = Post.fromJson(responseDTO.data);
      }

      return responseDTO;
    } catch (e) {
      return ResponseDTO(errorMessage: "실패 : ${e}", success: false, status: -1);
    }
  }

  Future<ResponseDTO> fetchDelete(String jwt, int id) async {
    try {
      // 통신
      Response response = await dio.delete("/post/$id", options: Options(headers: {"Authorization": "$jwt"}));

      // 응답 받은 데이터 파싱
      ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);

      return responseDTO;
    } catch (e) {
      return ResponseDTO(errorMessage: "실패 : ${e}", success: false, status: -1);
    }
  }

}