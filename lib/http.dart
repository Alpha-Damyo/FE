import 'package:http/http.dart' as http;
import 'dart:convert';
import 'secret.dart';

Future<String> GetAddress(String coords) async {
  const String sourcecrs = 'epsg:4326';
  const String orders = 'addr';
  const String output = 'json';

  var url = Uri.parse(
    "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?coords=$coords&sourcecrs=$sourcecrs&orders=$orders&output=$output",
  );
  var response = await http.get(url, headers: {
    'X-NCP-APIGW-API-KEY-ID': secretNaverCloudId,
    'X-NCP-APIGW-API-KEY': secretNaverCloudSecret,
  });

  // 성공
  if (response.statusCode == 200) {
    var json = jsonDecode(response.body);
    var status = json['status'];
    var code = status['code'];
    if (code == 3) {
      return '지번 주소가 존재하지 않는 구역입니다'; // 지번 주소가 존재하지 않음
    }

    var region = json['results'][0]['region'];
    var area1 = region['area1']['name'];
    var area2 = region['area2']['name'];
    var area3 = region['area3']['name'];
    var area4 = region['area4']['name'];
    var land = json['results'][0]['land'];
    var landNum1 = land['number1'];
    var landNum2 = land['number2'];
    List<String> areaList = [area1, area2, area3, area4];
    String address = '';
    for (int i = 0; i < areaList.length; i++) {
      if (areaList[i] != '') {
        address += '${areaList[i]} ';
      }
    }
    if (landNum1 != '') {
      address += landNum1;
    }
    if (landNum2 != '') {
      address += '-$landNum2';
    }
    return address;
  }
  // 실패
  else {
    return '에러: ${response.statusCode}, 주소를 불러올 수 없습니다.';
  }
}

// void Inform() async {
//   var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
//   var response = await http.post(
//     url,
//     body: {

//     },
//   );
// }

// http://ec2-3-37-0-59.ap-northeast-2.compute.amazonaws.com:8080/auth/signup
// {
//     "email" : "abcde@gmail.com",
//     "name": "hi",
//     "profileUrl" : "sdfsdf",
//     "gender" : "male",
//     "age" : 12
// }

// test용 지환 - 창연 서버 연결 확인(로그인 관련)
// Future<void> sendData() async {
//   //http.post는 리턴값이 Future이기 떄문에 async 함수 내에서 await로 호출할 수 있다.
//   var test = Uri.parse("http://ec2-3-37-0-59.ap-northeast-2.compute.amazonaws.com:8080/auth/signup",);
//   http.Response res = await http.post(
//     test,
//     headers: {"Content-Type":"application/json"},
//     body: json.encode({
//       "email" : "chage@gmail.com",
//       "name": "hi",
//       "profileUrl" : "sdfsdf",
//       "gender" : "male",
//       "age" : 12
//     })
//   );
//   print(res.body);
//   //여기서는 응답이 객체로 변환된 res 변수를 사용할 수 있다.
//   //여기서 res.body를 jsonDecode 함수로 객체로 만들어서 데이터를 처리할 수 있다.

//   return; //작업이 끝났기 때문에 리턴
// }