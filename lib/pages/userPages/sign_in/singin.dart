import 'package:flutter/material.dart';
import 'package:my_map/pages/api_connection/supabase_service.dart';
import 'package:my_map/pages/constants/constants.dart';
import 'package:my_map/pages/display/passwordfiel_layout.dart';
import 'package:my_map/pages/display/textfield_layout.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  bool _isPasswordVisible = false;
  bool _signInLoarding = false;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Take the screen sizes
    final Size deviceSize = MediaQuery.of(context).size;
    final double widthScreen = deviceSize.width;
    final double heightScreen = deviceSize.height;

    // variable for mobile and tablet
    final isMobile = widthScreen < 600; // Adjust for tablet or mobile
    final isMobileRotate = heightScreen < 600;
    final isRotate =
        isMobileRotate && widthScreen > heightScreen; // Adjust for rotate
    final appBarHeight = isRotate ? widthScreen / 10 : heightScreen / 10;
    final textFieldHeight = isRotate ? widthScreen / 4.5 : heightScreen / 4.5;
    final screenPaddingTop =
        MediaQuery.of(context).padding.top; // Take the elevation size
    final formHeight = heightScreen - appBarHeight - textFieldHeight;
    final formHeightRotate = widthScreen - (screenPaddingTop * 5);
    final textFormHeight = isMobile
        ? formHeight / 9
        : isRotate
            ? formHeightRotate / 10
            : formHeight / 10; // Adjust for textheight

    return Scaffold(
      backgroundColor: whiteColor,
      //Appbar
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(appBarHeight -
            screenPaddingTop), // Height of the AppBar with added space
        child: AppBar(
          centerTitle: true,
          title: Text(
            'Login',
            style: TextStyle(
              color: greyColor,
              fontSize: 15.0,
              fontWeight: FontWeight.w400,
              letterSpacing: isMobile ? 0 : 0.5,
            ),
          ),
          backgroundColor: transparentColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: greyColor),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),

      //Body
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: widthScreen / 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //Text Part
              SizedBox(
                height: textFieldHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: textFieldHeight / 5.0,
                    ),
                    //Header
                    Text('WELCOME BACK',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w400,
                          color: userPageColor,
                          letterSpacing: isMobile ? 1.5 : 4.5,
                        )),
                    const SizedBox(
                      height: 5.0,
                    ),
                    //Small header
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: isMobile
                              ? heightScreen / 13.0
                              : heightScreen / 12.0),
                      child: Text(
                        'Processed with your Login to use this App',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: greyColor,
                          letterSpacing: isMobile ? 0 : 1,
                        ),
                      ),
                    )
                  ],
                ),
              ),

              // Form fiel for sign in
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical:
                            isRotate ? textFieldHeight / 2 : formHeight / 10,
                      ),
                      //Form
                      child: Column(
                        children: [
                          //Email
                          TextfieldLayout(
                            controller: _emailController,
                            label: 'Email',
                            icon: Icons.mail_outline,
                            validatorMessage: "Please enter your email",
                            height: textFormHeight,
                          ),

                          SizedBox(
                            height: isMobile
                                ? formHeight / 25.0
                                : isRotate
                                    ? formHeightRotate / 30.0
                                    : formHeight / 20.0,
                          ),

                          //Password
                          PasswordfielLayout(
                            controller: _passwordController,
                            label: 'Password',
                            validatorMessage: 'Please enter your password',
                            height: textFormHeight,
                            isPasswordVisible: _isPasswordVisible,
                            onVisibilityChanged: (isVisible) {
                              setState(() {
                                _isPasswordVisible = isVisible;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    //Sigin Buttton
                    Padding(
                      padding: EdgeInsets.only(
                          top: isMobileRotate
                              ? formHeightRotate / 50.0
                              : formHeight / 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _signInLoarding
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: myMainColor,
                                  ),
                                )
                              : TextButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        _signInLoarding = true;
                                      });
                                      try {
                                        await client.auth.signInWithPassword(
                                            email: _emailController.text,
                                            password: _passwordController.text);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Center(
                                              child: Text(
                                            'Welcome Back',
                                          )),
                                          backgroundColor: successColor,
                                        ));
                                        Navigator.pushNamed(context, '/home');
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Center(
                                              child: Text('Sign In Failed')),
                                          backgroundColor: ScaffoldColor,
                                        ));
                                      }
                                      setState(() {
                                        _signInLoarding = false;
                                      });
                                    }
                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      vertical: isRotate
                                          ? formHeightRotate / 40.0
                                          : formHeight / 25.0,
                                    ),
                                    backgroundColor: whiteColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                    ),
                                    side: const BorderSide(
                                      color: myMainColor,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: const Text(
                                    'Login',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: myMainColor,
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),

                    //Last Text
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Not a member?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: userPageColor,
                              fontSize: 12.0,
                            ),
                          ),
                          //Login button
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/signUp');
                            },
                            child: const Text(
                              'Sign up',
                              style: TextStyle(
                                color: myMainColor,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
