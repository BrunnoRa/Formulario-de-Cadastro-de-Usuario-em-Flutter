import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const CadastroApp());
}

class CadastroApp extends StatelessWidget {
  const CadastroApp({super.key});

  @override
  Widget build(BuildContext context) {
    const roxo = Color(0xFF6750A4);

    return MaterialApp(
      title: 'Cadastro de usuário',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: roxo),
        scaffoldBackgroundColor: const Color(0xFFF7F5FA),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE5E0EC)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE5E0EC)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: roxo, width: 1.8),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFB3261E)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFB3261E), width: 1.8),
          ),
        ),
      ),
      home: const CadastroPage(),
    );
  }
}

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();
  final _senhaController = TextEditingController();
  final _confirmacaoController = TextEditingController();

  bool _mostrarSenha = false;
  bool _mostrarConfirmacao = false;

  @override
  void dispose() {
    _senhaController.dispose();
    _confirmacaoController.dispose();
    super.dispose();
  }

  String? _validarNome(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'Informe seu nome completo.';
    }
    return null;
  }

  String? _validarEmail(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'Informe seu e-mail.';
    }
    final emailValido = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (!emailValido.hasMatch(valor.trim())) {
      return 'Digite um e-mail válido.';
    }
    return null;
  }

  String? _validarCpf(String? valor) {
    if (valor == null || valor.isEmpty) return 'Informe seu CPF.';
    if (!RegExp(r'^\d{11}$').hasMatch(valor)) {
      return 'O CPF deve conter 11 números.';
    }
    return null;
  }

  String? _validarTelefone(String? valor) {
    if (valor == null || valor.isEmpty) return 'Informe seu telefone.';
    if (!RegExp(r'^\d+$').hasMatch(valor)) {
      return 'Use somente números.';
    }
    return null;
  }

  String? _validarSenha(String? valor) {
    if (valor == null || valor.isEmpty) return 'Crie uma senha.';
    if (valor.length < 6) return 'A senha deve ter pelo menos 6 caracteres.';
    return null;
  }

  String? _validarConfirmacao(String? valor) {
    if (valor == null || valor.isEmpty) return 'Confirme sua senha.';
    if (valor != _senhaController.text) return 'As senhas não coincidem.';
    return null;
  }

  void _cadastrar() {
    final valido = _formKey.currentState!.validate();
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();

    if (!valido) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Revise os campos destacados.'),
          backgroundColor: Color(0xFFB3261E),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    FocusScope.of(context).unfocus();
    messenger.showSnackBar(
      const SnackBar(
        content: Text('Cadastro realizado com sucesso!'),
        backgroundColor: Color(0xFF2E7D32),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar conta'),
        backgroundColor: Colors.transparent,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundColor: Color(0xFFEAE4F6),
                child: Icon(
                  Icons.person_add_alt_1_rounded,
                  color: Color(0xFF6750A4),
                  size: 30,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Seja bem-vindo(a)!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 24),
              Card(
                elevation: 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                  side: const BorderSide(color: Color(0xFFECE8F1)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.next,
                        validator: _validarNome,
                        decoration: const InputDecoration(
                          labelText: 'Nome completo',
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        autocorrect: false,
                        validator: _validarEmail,
                        decoration: const InputDecoration(
                          labelText: 'E-mail',
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(11),
                        ],
                        validator: _validarCpf,
                        decoration: const InputDecoration(
                          labelText: 'CPF',
                          prefixIcon: Icon(Icons.badge_outlined),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(11),
                        ],
                        validator: _validarTelefone,
                        decoration: const InputDecoration(
                          labelText: 'Telefone',
                          prefixIcon: Icon(Icons.phone_outlined),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _senhaController,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        obscureText: !_mostrarSenha,
                        validator: _validarSenha,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            tooltip: _mostrarSenha ? 'Ocultar senha' : 'Mostrar senha',
                            onPressed: () => setState(
                              () => _mostrarSenha = !_mostrarSenha,
                            ),
                            icon: Icon(
                              _mostrarSenha
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _confirmacaoController,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        obscureText: !_mostrarConfirmacao,
                        validator: _validarConfirmacao,
                        onFieldSubmitted: (_) => _cadastrar(),
                        decoration: InputDecoration(
                          labelText: 'Confirmar senha',
                          prefixIcon: const Icon(Icons.lock_reset_outlined),
                          suffixIcon: IconButton(
                            tooltip: _mostrarConfirmacao
                                ? 'Ocultar senha'
                                : 'Mostrar senha',
                            onPressed: () => setState(
                              () => _mostrarConfirmacao = !_mostrarConfirmacao,
                            ),
                            icon: Icon(
                              _mostrarConfirmacao
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        height: 54,
                        child: ElevatedButton(
                          onPressed: _cadastrar,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6750A4),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: const Text(
                            'CADASTRAR',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.1,
                            ),
                          ),
                        ),
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