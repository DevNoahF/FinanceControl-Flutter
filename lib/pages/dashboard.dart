import 'package:flutter/material.dart';
import 'package:finance_control/core/auth/auth_service.dart';
import 'package:go_router/go_router.dart';
import '../models/transacao.dart';
import '../components/menuDropdown.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Transacao> transacoesTeste = [
    Transacao(
      titulo: 'Salário',
      descricao: 'Pagamento mensal',
      valor: 3000,
      isEntrada: true,
    ),
    Transacao(
      titulo: 'Freelance',
      descricao: 'Projeto web replica do ifood',
      valor: 2500,
      isEntrada: true,
    ),
    Transacao(
      titulo: 'Consultoria',
      descricao: 'Reunião cliente',
      valor: 3100,
      isEntrada: true,
    ),
    Transacao(
      titulo: 'Conta de luz',
      descricao: 'Fatura de maio, cara por deixar ia rodando no servidor',
      valor: 700,
      isEntrada: false,
    ),
  ];

  double get totalEntradas => transacoesTeste
      .where((t) => t.isEntrada)
      .fold(0, (sum, t) => sum + t.valor);

  double get totalSaidas => transacoesTeste
      .where((t) => !t.isEntrada)
      .fold(0, (sum, t) => sum + t.valor);

  double get restante => totalEntradas - totalSaidas;

  void _excluirTransacao(int index) {
    setState(() => transacoesTeste.removeAt(index));
  }

  void _editarTransacao(int index) {
    final transacao = transacoesTeste[index];
    final formKey = GlobalKey<FormState>();
    final tituloCtrl = TextEditingController(text: transacao.titulo);
    final descricaoCtrl = TextEditingController(text: transacao.descricao);
    final valorCtrl = TextEditingController(text: transacao.valor.toString());
    bool isEntrada = transacao.isEntrada;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Editar Transação'),
        content: StatefulBuilder(
          builder: (ctx, setDialogState) => SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: tituloCtrl,
                    decoration: const InputDecoration(labelText: 'Título'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Informe o título da transação';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: descricaoCtrl,
                    decoration: const InputDecoration(labelText: 'Descrição'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Informe a descrição';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: valorCtrl,
                    decoration: const InputDecoration(labelText: 'Valor'),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Informe um valor';
                      }
                      final parsedValue =
                          double.tryParse(value.replaceAll(',', '.'));
                      if (parsedValue == null || parsedValue <= 0) {
                        return 'Informe um valor numérico válido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Entrada:'),
                      Switch(
                        value: isEntrada,
                        onChanged: (value) {
                          setDialogState(() => isEntrada = value);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                setState(() {
                  transacoesTeste[index] = Transacao(
                    titulo: tituloCtrl.text,
                    descricao: descricaoCtrl.text,
                    valor: double.tryParse(valorCtrl.text.replaceAll(',', '.')) ??
                        transacao.valor,
                    isEntrada: isEntrada,
                  );
                });
                Navigator.pop(ctx);
              }
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE0E0E0),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(child: MenuDropdown(nomeUsuario: 'Maria')),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color.fromARGB(255, 3, 148, 24)),
              child: Text(
                'Finanças',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: const Text('Dashboard'),
              leading: const Icon(Icons.dashboard),
              onTap: () {
                Navigator.pop(context);
                context.go('/home');
              },
            ),
            ListTile(
              title: const Text('Cadastrar Transação'),
              leading: const Icon(Icons.person_add),
              onTap: () {
                Navigator.pop(context);
                context.go('/input');
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Cards de resumo
            Row(
              children: [
                _CardResumo(
                  titulo: 'Entradas',
                  valor: totalEntradas,
                  cor: Colors.green,
                ),
                const SizedBox(width: 12),
                _CardResumo(
                  titulo: 'Saídas',
                  valor: totalSaidas,
                  cor: Colors.red,
                ),
                const SizedBox(width: 12),
                _CardResumo(
                  titulo: 'Restante',
                  valor: restante,
                  cor: Colors.blue[800]!,
                ),
              ],
            ),
            const SizedBox(height: 40),
            // Tabela de transações
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    // Cabeçalho
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 70,
                            child: Text(
                              'status',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'título',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'descrição',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 70,
                            child: Text(
                              'valor',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          SizedBox(width: 60),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    // Lista
                    Expanded(
                      child: ListView.separated(
                        itemCount: transacoesTeste.length,
                        separatorBuilder: (context, index) =>
                            const Divider(height: 1),
                        itemBuilder: (ctx, i) {
                          final t = transacoesTeste[i];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 70,
                                  child: Center(
                                    child: Icon(
                                      t.isEntrada
                                          ? Icons.add_circle
                                          : Icons.remove_circle,
                                      color: t.isEntrada
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    t.titulo,
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    t.descricao,
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ),
                                SizedBox(
                                  width: 70,
                                  child: Text(
                                    'R\$ ${t.valor.toStringAsFixed(0)}',
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ),
                                // Botões editar/excluir
                                SizedBox(
                                  width: 60,
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.orange,
                                          size: 20,
                                        ),
                                        onPressed: () => _editarTransacao(i),
                                        constraints: const BoxConstraints(),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 4,
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.cancel,
                                          color: Colors.red,
                                          size: 20,
                                        ),
                                        onPressed: () => _excluirTransacao(i),
                                        constraints: const BoxConstraints(),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardResumo extends StatelessWidget {
  final String titulo;
  final double valor;
  final Color cor;

  const _CardResumo({
    required this.titulo,
    required this.valor,
    required this.cor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titulo,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'R\$ ${valor.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}