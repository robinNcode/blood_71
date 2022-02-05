// import 'package:blood_71/src/controllers/url_constants.dart';
//
// class Auth{
//   Future<void> checkAuthentication() async {
//     Map loginInfo = {
//       "email" : _emailController.text,
//       "password" : _passwordController.text
//     };
//
//     var url = Uri.parse(UrlConstants.loginAttemptUrl);
//     var response = await http.post(url, body: loginInfo);
//     var userInfo = jsonDecode(response.body);
//
//
//     if(userInfo != null){
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => HomePage(userInfo: userInfo),
//         ),
//       );
//     }
//     else{
//
//     }
//   }
// }
