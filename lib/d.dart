class FileManager{
FileManager._();
static late FileManager _instance;

static get instance {
if (_instance == null)
{
_instance=FileManager._();
 }
return _instance;
}


}

void main()
{
  final singleton = FileManager.instance;
}

class Singleton {
  static Singleton _instance;
  static get instance {
    if (_instance == null) {
      _instance = Singleton._internal();
    }
    
    return _instance;
  }
  
  Singleton._internal();
}
