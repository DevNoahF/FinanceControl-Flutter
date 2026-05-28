import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../notifiers/transacao_notifier.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {

  String tipo = 'entrada';

  final TextEditingController tituloCtrl   = TextEditingController();
  final TextEditingController valorCtrl    = TextEditingController();
  final TextEditingController descricaoCtrl = TextEditingController();

  @override
  void dispose() {
    tituloCtrl.dispose();
    valorCtrl.dispose();
    descricaoCtrl.dispose();
    super.dispose();
  }

  void _limparCampos() {
    tituloCtrl.clear();
    valorCtrl.clear();
    descricaoCtrl.clear();
    setState(() => tipo = 'entrada');
  }



  Future<void> _salvar() async {

    final notifier = context.read<TransacaoNotifier>();


    final erroValidacao = notifier.validar(
      titulo:   tituloCtrl.text,
      valorRaw: valorCtrl.text,
      descricao: descricaoCtrl.text,
    );

    if (erroValidacao != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(erroValidacao)),
      );
      return;
    }

    final sucesso = await notifier.salvar(
      titulo:    tituloCtrl.text,
      descricao: descricaoCtrl.text,
      valorRaw:  valorCtrl.text,
      tipo:      tipo,
    );

    if (sucesso && mounted) {
      _limparCampos();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Transação adicionada com sucesso!')),
      );
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F7),
      body: Center(
        child: Container(
          width: 1100,
          height: 650,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(35, 0, 0, 0),
                blurRadius: 18,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [

              Expanded(
                flex: 4,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      bottomLeft: Radius.circular(24),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFBFD0C5),
                        Color(0xFFAEBFB4),
                      ],
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 50,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Spacer(),
                        Text(
                          'Controle suas finanças\ncom clareza e elegância.',
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                            color: Color(0xFF20322D),
                          ),
                        ),
                        SizedBox(height: 18),
                        Text(
                          'Registre entradas e despesas de forma simples.',
                          style: TextStyle(
                            fontSize: 17,
                            height: 1.5,
                            color: Color(0xFF32453F),
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              ),

              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 45,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Novo lançamento',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () => context.go('/home'),
                            icon: const Icon(Icons.arrow_back),
                            label: const Text('Voltar'),
                          ),
                        ],
                      ),

                      const SizedBox(height: 35),

                      // TIPO
                      const _CustomLabel('Tipo de transação'),
                      const SizedBox(height: 10),

                      Row(
                        children: [
                          _TipoChip(
                            label: 'Entrada',
                            selected: tipo == 'entrada',
                            onTap: () => setState(() => tipo = 'entrada'),
                          ),
                          const SizedBox(width: 10),
                          _TipoChip(
                            label: 'Saída',
                            selected: tipo == 'saida',
                            onTap: () => setState(() => tipo = 'saida'),
                          ),
                        ],
                      ),

                      const SizedBox(height: 22),


                      const _CustomLabel('Título'),
                      const SizedBox(height: 10),
                      _CustomInput(
                        controller: tituloCtrl,
                        hintText: 'Ex: Salário, Mercado, Aluguel...',
                        icon: Icons.title_rounded,
                      ),

                      const SizedBox(height: 22),

                      // VALOR
                      const _CustomLabel('Valor'),
                      const SizedBox(height: 10),
                      _CustomInput(
                        controller: valorCtrl,
                        hintText: 'Digite o valor',
                        icon: Icons.attach_money,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                      ),

                      const SizedBox(height: 22),

                      // DESCRIÇÃO
                      const _CustomLabel('Descrição'),
                      const SizedBox(height: 10),
                      _CustomInput(
                        controller: descricaoCtrl,
                        hintText: 'Ex: salário mensal, compra no mercado...',
                        icon: Icons.edit_note_rounded,
                      ),

                      const Spacer(),


                      Consumer<TransacaoNotifier>(
                        builder: (context, notifier, _) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Exibe erro vindo do Notifier
                              if (notifier.erro != null)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    notifier.erro!,
                                    style: const TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 13,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),

                              Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 56,
                                      child: OutlinedButton(
                                        // Desabilitado durante o loading
                                        onPressed: notifier.loading
                                            ? null
                                            : _limparCampos,
                                        child: const Text('Limpar'),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: SizedBox(
                                      height: 56,
                                      child: ElevatedButton(
                                        // Desabilitado durante o loading
                                        onPressed: notifier.loading
                                            ? null
                                            : _salvar,
                                        child: notifier.loading
                                            ? const SizedBox(
                                                width: 22,
                                                height: 22,
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                ),
                                              )
                                            : const Text('Salvar lançamento'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class _CustomLabel extends StatelessWidget {
  final String text;

  const _CustomLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _CustomInput extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  const _CustomInput({
    required this.hintText,
    required this.icon,
    required this.controller,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}

class _TipoChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TipoChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF111827) : Colors.grey[200],
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}