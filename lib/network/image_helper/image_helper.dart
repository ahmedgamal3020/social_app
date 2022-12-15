
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageHelper{
  static ImagePicker? imagePicker;
  static ImageCropper? imageCropper;


 static Future<List<XFile>> pickImage({
    ImageSource source = ImageSource.gallery,
    int imageQuality =100,
    bool multiple =false
})async{
    if(multiple){
      return await imagePicker!.pickMultiImage(imageQuality: imageQuality);
    }
   final file= await imagePicker!.pickImage(
      source: source,
      imageQuality: imageQuality
    );
    if(file!=null) return [file];
    return [];
  }
  static Future<CroppedFile?>crop({
  required XFile file,
    CropStyle cropStyle=CropStyle.rectangle
})async{
    return await imageCropper!.cropImage(
      cropStyle: cropStyle,
      sourcePath:file.path,
      compressQuality: 100,
    );

  }

}