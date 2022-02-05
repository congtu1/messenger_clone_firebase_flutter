
class StringHelper {


  String compareStringForID(String id1,String id2){
    String id = "";
    if(id1.compareTo(id2) == 1) {
      return id= id1+id2;
    }
    else {
      return id = id2+id1;
    }
  }
}