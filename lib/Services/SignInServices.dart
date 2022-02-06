import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reward_app/Services/DatabaseServices.dart';

class SignInServies {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  DatabaseServices databaseServices = new DatabaseServices();

  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final authResult = await _auth.signInWithCredential(credential);

    if (authResult.additionalUserInfo.isNewUser) {
      databaseServices.createUser(email: authResult.user.email);
    }

    final User user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = await _auth.currentUser;
    assert(user.uid == currentUser.uid);

    return currentUser;
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();

    print("User Sign Out");
  }
}
