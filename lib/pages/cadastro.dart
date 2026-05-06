import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:finance_control/core/auth/auth_service.dart';
import 'package:finance_control/models/usuario.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _formKey = GlobalKey<FormState>();

  final nomeController = TextEditingController();
  final sobrenomeController = TextEditingController();
  final profissaoController = TextEditingController();
  final dataNascimentoController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  bool _mostrarSenha = false;

  @override
  void dispose() {
    nomeController.dispose();
    sobrenomeController.dispose();
    profissaoController.dispose();
    dataNascimentoController.dispose();
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  int _calcularIdade(DateTime nascimento) {
    final hoje = DateTime.now();
    int idade = hoje.year - nascimento.year;

    if (hoje.month < nascimento.month ||
        hoje.month == nascimento.month && hoje.day < nascimento.day) {
      idade--;
    }

    return idade;
  }

  DateTime? _converterDataNascimento(String value) {
    try {
      final partes = value.split('/');

      final dia = int.parse(partes[0]);
      final mes = int.parse(partes[1]);
      final ano = int.parse(partes[2]);

      return DateTime(ano, mes, dia);
    } catch (_) {
      return null;
    }
  }

  void _cadastrar() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final nascimento = _converterDataNascimento(
      dataNascimentoController.text.trim(),
    );

    if (nascimento == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data de nascimento inválida'),
        ),
      );
      return;
    }

    final usuario = Usuario(
      id: DateTime.now().millisecondsSinceEpoch,
      nome: nomeController.text.trim(),
      sobrenome: sobrenomeController.text.trim(),
      email: emailController.text.trim(),
      senha: senhaController.text.trim(),
      idade: _calcularIdade(nascimento),
      created_at: DateTime.now(),
    );

    authService.cadastrar(usuario);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Conta criada com sucesso!'),
      ),
    );

    context.go('/login');
  }

  String? _validarTextoObrigatorio(String? value, String campo) {
    if (value == null || value.trim().isEmpty) {
      return '$campo é obrigatório';
    }

    if (value.trim().length < 2) {
      return '$campo deve ter pelo menos 2 caracteres';
    }

    return null;
  }

  String? _validarEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email é obrigatório';
    }

    final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');

    if (!emailRegex.hasMatch(value.trim())) {
      return 'Digite um email válido';
    }

    return null;
  }

  String? _validarSenha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Senha é obrigatória';
    }

    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres';
    }

    return null;
  }

  String? _validarDataNascimento(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Data de nascimento é obrigatória';
    }

    final regex = RegExp(r'^\d{2}/\d{2}/\d{4}$');

    if (!regex.hasMatch(value.trim())) {
      return 'Use o formato dd/mm/aaaa';
    }

    final data = _converterDataNascimento(value.trim());

    if (data == null) {
      return 'Data inválida';
    }

    if (data.isAfter(DateTime.now())) {
      return 'Data não pode ser no futuro';
    }

    return null;
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
                    child: Flex(
                      direction: isWide ? Axis.horizontal : Axis.vertical,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            color: const Color(0xFFF7F6F3),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 28,
                              vertical: 36,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Crie sua conta',
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
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            color: const Color(0xFF363B43),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 28,
                              vertical: 28,
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Text(
                                    'Cadastre-se',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 34,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      height: 1,
                                    ),
                                  ),
                                  const SizedBox(height: 22),

                                  Row(
                                    children: [
                                      Expanded(
                                        child: _FieldColumn(
                                          label: 'Nome',
                                          controller: nomeController,
                                          validator: (value) =>
                                              _validarTextoObrigatorio(
                                            value,
                                            'Nome',
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: _FieldColumn(
                                          label: 'Sobrenome',
                                          controller: sobrenomeController,
                                          validator: (value) =>
                                              _validarTextoObrigatorio(
                                            value,
                                            'Sobrenome',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 14),

                                  Row(
                                    children: [
                                      Expanded(
                                        child: _FieldColumn(
                                          label: 'Profissão',
                                          controller: profissaoController,
                                          validator: (value) =>
                                              _validarTextoObrigatorio(
                                            value,
                                            'Profissão',
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: _FieldColumn(
                                          label: 'Data de nascimento',
                                          controller:
                                              dataNascimentoController,
                                          keyboardType:
                                              TextInputType.datetime,
                                          validator: _validarDataNascimento,
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 14),

                                  _FieldColumn(
                                    label: 'Email',
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: _validarEmail,
                                  ),

                                  const SizedBox(height: 14),

                                  _FieldColumn(
                                    label: 'Senha',
                                    controller: senhaController,
                                    obscureText: !_mostrarSenha,
                                    validator: _validarSenha,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _mostrarSenha
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: const Color(0xFF363B43),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _mostrarSenha = !_mostrarSenha;
                                        });
                                      },
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  SizedBox(
                                    height: 38,
                                    child: ElevatedButton(
                                      onPressed: _cadastrar,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor:
                                            const Color(0xFF3A3A3A),
                                        elevation: 0,
                                        shape: const StadiumBorder(),
                                        textStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      child: const Text('Cadastrar'),
                                    ),
                                  ),

                                  const SizedBox(height: 16),

                                  const Divider(
                                    color: Colors.white54,
                                    thickness: 1,
                                    height: 1,
                                  ),

                                  const SizedBox(height: 10),

                                  TextButton(
                                    onPressed: () => context.go('/login'),
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.white,
                                    ),
                                    child: const Text('Ou faça Login'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
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

class _FieldColumn extends StatelessWidget {
  const _FieldColumn({
    required this.label,
    required this.controller,
    required this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
  });

  final String label;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: Colors.white,
            errorMaxLines: 2,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: Color(0xFFB9C9D8),
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}