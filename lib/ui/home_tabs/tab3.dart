import "dart:convert";
import "dart:io";
import "dart:typed_data";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:hello_flutter/data/model/user.dart";
import "package:hello_flutter/service/auth_service.dart";
import "package:image_picker/image_picker.dart";

import "../../data/repository/user_repo_impl.dart";

class ThirdTab extends StatefulWidget {
  const ThirdTab({
    Key? key,
  }) : super(key: key);

  @override
  State<ThirdTab> createState() => _ThirdTabState();
}

class _ThirdTabState extends State<ThirdTab> {
  final repo = UserRepoImpl();
  File? image;
  String base64ImageString = "";
  User? _user;

  Future fetchUser() async {
    final user = await AuthService.getUser();
    if (user != null) {
      final temp = await repo.getUserByEmail(user.email);
      setState(() {
        _user = temp;
      });
    }
  }

  Uint8List getImageBytes() {
    return base64Decode(base64ImageString);
  }

  Future safePic() async {
    if (_user != null && image != null) {
      final bytes = image!.readAsBytesSync();
      repo.updateProfilePic(_user!.id, bytes);
    }
  }

  Future _pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final imageFile = File(image.path);
      // final bytes = imageFile.readAsBytesSync();
      // repo.updateProfilePic(_user!.id, bytes);
      // final imageString = base64Encode(bytes);
      setState(() {
        this.image = imageFile;
        // this.base64ImageString = imageString;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeUserString();
    fetchUser();
  }


  Future<void> _initializeUserString() async {
    final user = await AuthService.getUser();
    _user = user!;
    setState(() {});
  }

  // void _updateImage(User user) async {
  //   debugPrint("$user");
  //   user = User(
  //       id: user.id,
  //       name: user.name,
  //       email: user.email,
  //       password: user.password,
  //       image: base64ImageString);
  //   await repo.updateProfilePic(user);
  //   // refresh();
  // }


  _onClickTask() {
    context.push("/contacts");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      child: Column(
        children: [
          Text(_user!.name),
          SizedBox(
            width: 350,
            height: 40,
            child: ElevatedButton(
              onPressed: () => _onClickTask(),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text("contact"),
            ),
          ),
          SizedBox(
            width: 350,
            height: 40,
            child: ElevatedButton(
              onPressed: () => _pickImage(),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(19),
                ),
              ),
              child: const Text("Pick Image"),
            ),
          ),
          Container(
            // child: image != null ? Image.file(image!) : Container()
            child: image != null
                ? Image.file(image!)
                : _user?.image != null
                    ? Image.memory(_user!.image!)
                    : Container(),
          ),
          SizedBox(
            width: 350,
            height: 40,
            child: ElevatedButton(
              onPressed: () => safePic(),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(19),
                ),
              ),
              child: const Text("Save"),
            ),
          ),
        ],
      ),
    );
  }
}
