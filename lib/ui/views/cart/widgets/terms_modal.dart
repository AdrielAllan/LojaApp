import 'package:flutter/material.dart';
import 'package:usanacaixaapp/data/constants/color_constants.dart';

void showTermsModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Permite ajuste do tamanho com base no teclado
    backgroundColor: Colors.transparent, // Faz o modal parecer flutuar
    builder: (context) {
      return FractionallySizedBox(
        heightFactor: 0.8, // O modal ocupará 80% da altura da tela
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : AppColors.kDarkColor2,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Indicador para arrastar o modal
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Termos e Condições',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      '''
Frete não está incluso nos valores informados do grupo e o valor estará disponível somente após cadastrarmos (foto e pesagem) seus produtos no sistema.

O grupo de compras tem uma comissão de 20% sobre o valor total (compra + 6.5% imposto Flórida), sem valor mínimo.

O prazo para cadastro dos produtos na sua suíte é de até 7 dias úteis após o encerramento do grupo para lojas físicas e 12 dias úteis para lojas online (no caso online pode ser alterado em função de problemas relacionados à logística da loja na entrega ou intempéries da natureza).

No caso de devolução de compras, será cobrado \$15 dólares como serviço de devolução, e os valores de serviço de compra serão mantidos, sendo estornado somente os valores referentes aos produtos. Lojas como Michael Kors não aceitam devolução, portanto todas as vendas são finais.

O estoque dos produtos pode ser afetado durante a compra. Caso algum produto não esteja disponível no momento que realizamos a sua compra, informaremos assim que possível (alguns casos durante a compra, em outros após finalizar, dependendo da dinâmica do grupo e variação de estoque na loja). Nosso foco é garantir que todos sejam atendidos em sua totalidade. Após o fechamento, podemos demorar até 3 dias para finalizar as compras devido ao volume ou visita em outras lojas para compra dos produtos. Em nenhuma hipótese haverá devolução de valores já pagos, pois estão envolvidos transações internacionais e pagamentos de impostos.

Importante saber: como todo envio internacional, poderá haver tributação (60% do valor declarado/apurado + ICMS - varia conforme o estado). Caso a alfândega entenda que o valor declarado não está correto, pode tributar, devolver ao remetente ou qualquer outra ação, conforme entendimento do fiscal. O cliente importador é responsável por informar o que será declarado (tipo de produto, quantidades e valores). Caso não saiba como declarar, solicite no atendimento orientações.

Ao entrar nos grupos de compras, você estará concordando com as regras acima. Dizer que não sabia ou que não leu as informações não descaracteriza o seu aceite e o serviço que foi prestado.

O envio não é automático. Uma vez cadastrado o produto na sua suíte, já está disponível para envio. Caso tenha dúvida sobre como solicitar o envio, acesse a página inicial do site e clique no ícone do YouTube, onde temos um vídeo explicativo do processo de solicitação.
                        ''',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      );
    },
  );
}
