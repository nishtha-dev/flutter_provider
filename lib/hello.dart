
class ImageCropper {
  //static void cropImage({required String imageUrl}) {}
  ImageCropper get cropImage ({required String imageUrl}) {}
}

class PngImageProcessor { 
final String imageUrl;
PngImageProcessor (this.imageUrl);



void cropImage() {

ImageCropper.cropImage(imageUrl: imageUrl);

resizeImage();

downloadImage();
}


void downloadImage() {
  print("Hello");
}

void resizeImage() {
  print("Hi");
}

}



