import 'package:flutter/material.dart';
import 'package:my_map/pages/api_connection/supabase_service.dart';
import 'package:my_map/pages/constants/constants.dart';
import 'package:my_map/pages/display/passwordfiel_layout.dart';
import 'package:my_map/pages/display/textfield_layout.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _signUpLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
            : formHeight / 10; // Adjust the textheight

    return Scaffold(
      backgroundColor: whiteColor,
      //AppBar
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(appBarHeight -
            screenPaddingTop), // Height of the AppBar with added space
        child: AppBar(
          centerTitle: true,
          title: Text(
            'Sign Up',
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
              // Top part with text
              SizedBox(
                height: textFieldHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: textFieldHeight / 5.0,
                    ),
                    //Header
                    Text(
                      'REGISTER',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w400,
                        color: userPageColor,
                        letterSpacing: isMobile ? 1.5 : 4.5,
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    //Small header
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: isMobile
                              ? heightScreen / 18.0
                              : heightScreen / 10.0),
                      child: Text(
                        'Complete your details to create account',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: greyColor,
                          letterSpacing: isMobile ? 0 : 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Form field for sign up
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
                      child: Column(children: [
                        //Name
                        TextfieldLayout(
                          controller: _nameController,
                          label: 'Name',
                          icon: Icons.person_outline,
                          validatorMessage: "Please enter your name",
                          height: textFormHeight,
                        ),
                        SizedBox(
                          height: isMobile
                              ? formHeight / 25.0
                              : isRotate
                                  ? formHeightRotate / 30.0
                                  : formHeight / 20.0,
                        ),

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
                        SizedBox(
                          height: isMobile
                              ? formHeight / 25.0
                              : isRotate
                                  ? formHeightRotate / 30.0
                                  : formHeight / 20.0,
                        ),
                        PasswordfielLayout(
                          controller: _confirmPasswordController,
                          label: 'Confirm Password',
                          validatorMessage: 'Please confirm your password',
                          height: textFormHeight,
                          isPasswordVisible: _isConfirmPasswordVisible,
                          onVisibilityChanged: (isVisible) {
                            setState(() {
                              _isConfirmPasswordVisible = isVisible;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                      ]),
                    ),

                    // Sign up button
                    Padding(
                      padding: EdgeInsets.only(
                          top: isMobileRotate ? formHeightRotate / 50.0 : 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _signUpLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: myMainColor,
                                  ),
                                )
                              : TextButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        _signUpLoading = true;
                                      });
                                      try {
                                        final response =
                                            await client.auth.signUp(
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                        );

                                        if (response.user != null) {
                                          final userId = response.user!.id;

                                          // Add the name of the user profile
                                          try {
                                            await client
                                                .from('profiles')
                                                .insert({
                                              'user_id': userId,
                                              'username':
                                                  _nameController.text.trim(),
                                              'email': _emailController.text,
                                              'profile_image_url': '',
                                            });
                                          } catch (e) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content: Center(
                                                child: Text(
                                                    'Failed to add this profile!!'),
                                              ),
                                              backgroundColor: ScaffoldColor,
                                            ));
                                            return;
                                          }

                                          //Enter the home page
                                          Navigator.pushNamed(context, '/home');

                                          //welcome message
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content:
                                                Center(child: Text('Welcome')),
                                            backgroundColor: successColor,
                                          ));
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Center(
                                                child: Text('Sign Up Failed')),
                                            backgroundColor: ScaffoldColor,
                                          ));
                                        }
                                        // Enter the home page
                                        // Navigator.pushNamed(context, '/home');
                                      } catch (e) {
                                        print(e);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Center(
                                              child: Text(
                                                  'Invalid email format or less than 6 characters password!')),
                                          backgroundColor: ScaffoldColor,
                                        ));
                                      }
                                      setState(() {
                                        _signUpLoading = false;
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
                                    'Sign Up',
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

                    // Last text
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Already have an account?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: userPageColor,
                              fontSize: 12.0,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/signIn');
                            },
                            child: const Text(
                              'Login',
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
