//const String SERVER_GO_URL = 'http://192.168.199.128:3000';
const String SERVER_GO_URL = 'http://192.168.202.128:3000';
//const String SERVER_GO_URL = 'https://servidorseminariogo2.herokuapp.com/';
const String SERVER_NAMESPACE = '/';
const String SERVER_QUERY = '';
//const String SERVER_SIAA_URL = 'http://192.168.199.128:4000';
const String SERVER_SIAA_URL = 'http://192.168.202.128:4000';
//const String SERVER_SIAA_URL = 'https://siaasimulador2.herokuapp.com';
const String SERVER_SIAA_PERSON_PICTURE_URL = '$SERVER_SIAA_URL/getpersonpicture';

String getJsonString(String data) {
  if (data[0] == '[') {
    return data.substring(1, data.length - 1);
  } else {
    return data;
  }
}
