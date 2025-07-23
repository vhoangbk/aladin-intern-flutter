import 'package:flutter/material.dart';

void main()
{
  runApp(MyApp());
}

class MyApp extends StatelessWidget
{
  @override
  Widget build (BuildContext context)
  {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget
{
  @override
  State<HomeScreen> createState() => _StateHomeScreen();
}

class CreateAccountScreen extends StatefulWidget
{
  @override
  State<CreateAccountScreen> createState() => _StateCreateAccountScreen();

}

class ProfileScreen extends StatefulWidget
{
  @override
  State<ProfileScreen> createState() => _StateProfileScreen();
}

class GoalScreen extends StatefulWidget
{
  @override
  State<GoalScreen> createState() => _StateGoalScreen();
}

class WelcomeScreen extends StatefulWidget
{
  @override
  State<WelcomeScreen> createState() => _StateWelcomeScreen();
}

class MainScreen extends StatefulWidget
{
  @override
  State<MainScreen> createState() => _StateMainScreen();
}

// Giao dien Home Screen
class _StateHomeScreen extends State<HomeScreen> {
  @override
  void initState(){
    // Chan khong cho ban phim xuat hien
    super.initState();
    Future.delayed(Duration.zero,(){
      FocusScope.of(context).unfocus();
    });
  }
  
  
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // 👈 đẩy nút xuống
          children: [
            SizedBox(), // chừa trống trên

            // Phần chữ ở giữa
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Fitnest",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "X",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.deepPurpleAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text("Everybody can train"),
              ],
            ),

            // Nút ở dưới cùng
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                onPressed: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => CreateAccountScreen()),
                  ); 
                },
                child: Text("Get Started", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Thong tin o nhap tao account
Widget _buildInput({required Icon icon, required String hint, required TextEditingController controller, bool obscure = false}){
  return StatefulBuilder(
    builder: (context, setState) {
      bool _obscureText = obscure;
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: TextField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
            prefixIcon: icon,
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none
            ),

            // Xu li tao con mat cho o password
            suffixIcon: obscure
            ? IconButton(
                onPressed: (){}, 
                icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey, 
                )
              )
            : null,
          ),
        )
      );
    }
  ); 
}


// Giao dien tao account
class _StateCreateAccountScreen extends  State<CreateAccountScreen> 
{
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  
  @override
  Widget build (BuildContext context)
  {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
    
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Phan chu
                        Text("Hey there,", style: TextStyle(fontSize: 15),),
                        Text("Create an account", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),

                        SizedBox(height: 20),

                        // Phan o nhap thong tin
                        _buildInput(icon: Icon(Icons.person_outline),hint: "First name", controller: _firstNameController),
                        _buildInput(icon: Icon(Icons.person_outline),hint: "Last name", controller: _lastNameController),
                        _buildInput(icon: Icon(Icons.email), hint: "Email", controller: _emailController),
                        _buildInput(icon: Icon(Icons.lock), hint:"Password", controller: _passwordController, obscure: true),
                        
                        // Dong y dieu khoan
                        Row(
                          children: [
                            Checkbox(value: false, onChanged: (value){}),
                            const Expanded(
                              child: Text.rich(
                                TextSpan(
                                  text: "By continuing your accept our ",
                                  style: TextStyle(fontSize: 12, color: Colors.grey),
                                  children: [
                                    TextSpan(
                                      text: "Privacy Policy",
                                      style: TextStyle(decoration: TextDecoration.underline, fontSize: 12, color: Colors.black)
                                    ),
                                    TextSpan(
                                      text: " and ",
                                      style: TextStyle(fontSize: 12, color: Colors.grey),
                                    ),
                                    TextSpan(
                                      text: "Term of use",
                                      style: TextStyle(decoration: TextDecoration.underline, fontSize: 12, color: Colors.black)
                                    ),
                                  ],
                                )
                              )
                            )
                          ],
                        ),

                        Spacer(),
                        
                        // Nut Register
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),

                            onPressed: () {
                              Navigator.push(
                                context, 
                                MaterialPageRoute(builder: (context) => ProfileScreen()),
                              ); 
                            },
                            child: Text("Register", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                          ),
                        ),

                        SizedBox(height: 10),
                        // Ngan cach dau ke va chu Or
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 1,
                                color: Colors.grey,
                              )
                            ),
                            Padding(
                              padding: const EdgeInsetsGeometry.symmetric(horizontal: 8.0),
                              child: Text(" Or ", style: TextStyle(fontSize: 14))
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 1,
                                color: Colors.grey,
                              )
                            ),
                          ],
                        ),
                        SizedBox(height: 8),

                        // Tao Button neu dang ki tai khoan gg hoac facebook
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              child: ElevatedButton(
                                onPressed: (){},
                                child: Image.asset("assets/google.png"),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero
                                  )
                                )
                              ),                   
                            ),

                            SizedBox(width: 60),

                            Container(
                              height: 50,
                              width: 50,
                              child: ElevatedButton(
                                onPressed: (){},
                                child: Text("f", style: TextStyle(color: Colors.indigo, fontSize: 20, fontWeight: FontWeight.bold),),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero
                                  )
                                )
                              ),
                            )
                          ],
                        ),

                        SizedBox(height: 10),

                        // Neu co tai khoan an vao chu Login
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account? ", style: TextStyle(fontSize: 15)),
                            Text("Login", style: TextStyle(fontSize: 15, color: Colors.purpleAccent))
                          ],
                        )
                      ],
                    )
                  )
                ),
              ),
            );
          },
        )         
      )
    );
  }
}


//Giao dien nhap profile
class _StateProfileScreen extends State<ProfileScreen> {
  String? _selectedGender;
  DateTime? _selectedDate;
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false, 
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // Phần hình nền cố định
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                width: double.infinity,
                child: Image.asset(
                  "assets/DNA_BLUE_2103.png",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),

              // Phần chữ cố định
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Text(
                      "Let's complete your profile",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 3),
                    Text(
                      "It will help us to know more about you!",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),

              // Phần nhập liệu cuộn khi bàn phím xuất hiện
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        // Phần nhập liệu (Gender, Date of Birth, Weight, Height)

                        // Chon gioi tinh
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person_outline),
                            hintText: "Choose Gender",
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          value: _selectedGender,
                          items: ['Male', 'Female', 'Other']
                              .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                              .toList(),
                          onChanged: (val) => setState(() => _selectedGender = val),
                        ),

                        SizedBox(height: 10),

                        // Chon ngay sinh
                        GestureDetector(
                          onTap: () => _pickDate(context),
                          child: AbsorbPointer(
                            child: TextField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.calendar_today),
                                hintText: _selectedDate == null
                                    ? "Date of Birth"
                                    : "${_selectedDate!.toLocal()}".split(' ')[0],
                                filled: true,
                                fillColor: Colors.grey[100],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),

                        // O nhap lieu can nang
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _weightController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.monitor_weight_outlined),
                                  hintText: "Your Weight",
                                  filled: true,
                                  fillColor: Colors.grey[100],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            _buildUnitChip("KG"),
                          ],
                        ),
                        SizedBox(height: 10),

                        //O nhap lieu chieu cao
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _heightController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.height),
                                  hintText: "Your Height",
                                  filled: true,
                                  fillColor: Colors.grey[100],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            _buildUnitChip("CM"),
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),

              // Nút Next không cuộn, cố định dưới cùng
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => GoalScreen()));
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Next", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),)                   
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUnitChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.blueAccent, Colors.purpleAccent]),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        label,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}


// Giao dien keo anh
class _StateGoalScreen extends State<GoalScreen>
{
  final PageController _controller = PageController();
  int currentIndex = 0;

  final List<Map<String, String>> pages = [
    {
      "image": "assets/bong_da.jpeg",
      "title": "Improve Shape",
      "description": "I have a low amount of body fat",
      "description2": "and need / want to build more",
      "description3": "muscle"
    },
    {
      "image": "assets/bong_ro.jpeg",
      "title": "Lean & Tone",
      "description": "I'm 'skinny fat', look thin but have",
      "description2": "no shape. I want to learn to build",
      "description3": "muscle in the right way"
    },

    {
      "image": "assets/cau_long.jpeg",
      "title": "Lose a Fat",
      "description": "I have over 20 lbs to lose. I want to", 
      "description2": "drop all this fat and gain muscle",
      "description3": "mass",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Phan Text tren cung
            const Text(
              "What is your goal ?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "It will help us to choose a best program for you",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),

            // Phần ảnh va chu kéo qua lại
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  final page = pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blue.shade100, Colors.blue.shade200],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.asset(
                              page["image"]!,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            page["title"]!,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            page["description"]!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.black54),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            page["description2"]!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.black54),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            page["description3"]!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Nut Confirm
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen())
                    );
                  },
                  child: const Text(
                    "Confirm",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// Giao dien Welcome Back
class _StateWelcomeScreen extends State<WelcomeScreen>
{
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build (BuildContext context){
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(
          builder: (context, constrains){
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constrains.maxHeight),
                child: IntrinsicHeight(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          // Phan Text tren cung
                          SizedBox(),
                          Text("Hey there", style: TextStyle(fontSize: 20),),
                          Text("Welcome back", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),

                          // Phan o nhap lieu email va password neu co tai khoan
                          _buildInput(icon: Icon(Icons.email), hint: "Email", controller: _emailController),
                          SizedBox(height: 10),
                          _buildInput(icon: Icon(Icons.lock), hint:"Password", controller: _passwordController, obscure: true),
                          SizedBox(height: 5),

                          //Forgot the Password
                          Text("Forgot your password?", style: TextStyle(decoration: TextDecoration.underline, fontSize: 12, color: Colors.grey)),
                          Spacer(),
                          
                          //Nut login o phia duoi
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context, 
                                    MaterialPageRoute(builder: (context) => MainScreen()),
                                  ); 
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:[
                                    Icon(Icons.login, color: Colors.white),  
                                    SizedBox(width: 10),                         
                                    Text("Login", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),                                  
                                  ] 
                                ),
                              ),
                            )
                          ),
                          
                          // Phan duong ke ngan cach kem chu Or
                          SizedBox(height: 3),
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 1,
                                  color: Colors.grey,
                                )
                              ),
                              Padding(
                                padding: const EdgeInsetsGeometry.symmetric(horizontal: 8.0),
                                child: Text(" Or ", style: TextStyle(fontSize: 14))
                              ),
                              Expanded(
                                child: Divider(
                                  thickness: 1,
                                  color: Colors.grey,
                                )
                              ),
                            ],
                          ),
                          SizedBox(height: 3),

                          // Button gg va facebook
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                child: ElevatedButton(
                                  onPressed: (){},
                                  child: Image.asset("assets/google.png"),
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero
                                    )
                                  )
                                ),                   
                              ),  

                              SizedBox(width: 60),

                              Container(
                                height: 50,
                                width: 50,
                                child: ElevatedButton(
                                  onPressed: (){},
                                  child: Text("f", style: TextStyle(color: Colors.indigo, fontSize: 20, fontWeight: FontWeight.bold),),
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero
                                    )
                                  )
                                ),
                              )
                            ],
                          ),

                          SizedBox(height: 10),

                          // Phan text phia duoi 
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don’t have an account yet? ", style: TextStyle(fontSize: 15)),
                              Text("Register", style: TextStyle(fontSize: 15, color: Colors.purpleAccent))
                            ],
                          )
                        ],
                      )
                    )
                  )
                )
              )
            );
          }
        )
      ),      
    );
  }
}


// Giao dien Man hinh chinh
class _StateMainScreen extends State<MainScreen>
{
  @override
  Widget build (BuildContext context)
  {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
              // Phan anh co dinh
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
                child: Image.asset("assets/psg.jpeg"),
              ),
              
              // Phan Text o duoi
              SizedBox(height: 16),
              Text("Welcome, Stefani", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
              Text("You are all set now, let’s reach your"),
              Text("goals together with us"),

              Spacer(),

              // Button "Go to Home"
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: (){
                    Navigator.pop(context);
                  }, 
                  child: Text("Go to home", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)))
              )
            ],
          ),
        )
      )
    );
  }
}


