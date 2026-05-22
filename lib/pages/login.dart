import 'package:flutter/material.dart';
import 'package:finance_control/core/auth/auth_service.dart';
import 'package:finance_control/core/validators/validador_login_email.dart';
import 'package:go_router/go_router.dart';
import '../components/customTextField.dart'; 

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  Widget _buildIntroPane() {
    return Container(
      width: double.infinity,
      color: const Color(0xFFF7F6F3),
      padding: const EdgeInsets.symmetric(
        horizontal: 28,
        vertical: 36,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 8),
          const Text(
            'Seja bem-vindo\nde volta',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 41,
              height: 1.04,
              color: Color(0xFF111111),
              fontWeight: FontWeight.w400,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 50),
          Image.asset(
            'assets/logo.png',
            width: 290,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginPane() {
    return Container(
      width: double.infinity,
      color: const Color(0xFF363B43),
      padding: const EdgeInsets.symmetric(
        horizontal: 28,
        vertical: 28,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Login',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 34,
              color: Colors.white,
              fontWeight: FontWeight.w400,
              height: 1,
            ),
          ),
          const SizedBox(height: 22),
          const Text(
            'E-mail',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          const SizedBox(height: 10),
          CustomTextField(
            controller: _emailController,
            hintText: 'Digite seu e-mail',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 18),
          const Text(
            'Senha',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          const SizedBox(height: 10),
          CustomTextField(
            controller: _senhaController,
            hintText: 'Digite sua senha',
            isPassword: true,
          ),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: Colors.white70,
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'Esqueceu a senha?',
                style: TextStyle(fontSize: 13),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 38,
            child: ElevatedButton(
              onPressed: () {
                final emailError = validadorLoginEmail(_emailController.text);
                if (emailError != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(emailError)),
                  );
                  return;
                }

                authService.login(
                  context,
                  _emailController.text,
                  _senhaController.text,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF3A3A3A),
                elevation: 0,
                shape: const StadiumBorder(),
              ),
              child: const Text('Entrar'),
            ),
          ),
          const SizedBox(height: 16),
          const Divider(color: Colors.white54, thickness: 1),
          const SizedBox(height: 10),
          const Text(
            'Ou cadastra-se',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () => context.go('/cadastro'),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            child: const Text('Ir para cadastro'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Fundo.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.black.withValues(alpha: 0.18),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 880),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 720;

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.98),
                      borderRadius: BorderRadius.circular(2),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 28,
                          offset: Offset(0, 16),
                        ),
                      ],
                    ),
                    child: isWide
                        ? Row(
                            children: [
                              Expanded(flex: 5, child: _buildIntroPane()),
                              Expanded(flex: 5, child: _buildLoginPane()),
                            ],
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildIntroPane(),
                              _buildLoginPane(),
                            ],
                          ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}