# Processo de Processamento e Validação de Formulários HTML

O processo de processamento e validação de formulários HTML é essencial para garantir a integridade e a precisão dos dados submetidos pelos usuários em uma página da web. Esse processo geralmente envolve várias etapas que vão desde a coleta dos dados até a sua verificação e eventual processamento. Aqui está uma visão geral das etapas típicas envolvidas:

## 1. Coleta de Dados:
O processo começa quando o usuário preenche um formulário HTML em uma página da web. O formulário pode conter campos para diferentes tipos de informações, como texto, números, datas, opções selecionadas, entre outros.

## 2. Submissão do Formulário e Envio dos Dados ao Servidor:
Após o preenchimento dos campos, o usuário submete o formulário, geralmente clicando em um botão "enviar" ou equivalente. Os dados do formulário são enviados para o servidor web usando o método HTTP especificado no atributo `method` do elemento `<form>` no HTML. Os métodos comuns são GET e POST.

Em uma aplicação web Java, esses dados são recebidos por uma `Servlet`, que é a classe que sabe receber dados vindos do cliente. O método implementados na `Servlet` dependerá do método de envio definido do formulário por meio do atributo "method", conforme mencionado acima.

É importante destacar, destacar que validações do lado do cliente, atributos dos elementos HTML, tais como `required` ou `type="number"` muitas vezes são consideradas apenas orientações com a maneira correta de preencher o formulário, já que o usuário pode alterar esses dados, usando recursos simples, como a ferramenta "inspecionar" do navegadores atuais.  

```html
<form action="<endereco_servlet>" method="post">
    <input type="text" name="nome">
    <input type="email" name="email">
    <button type="submit">Enviar</button>
</form>
```


## 3. Processamento no Servidor:
No servidor, o código do lado do servidor processa os dados recebidos do formulário. Isso pode envolver armazenamento em um banco de dados, envio por e-mail, processamento de pagamento, entre outras operações. Usando a API Jakarta EE do Java, a maneira de se obter os dados do formulário apresentado pode ser algo como:

```java
import jakarta.servlet.RequestDispatcher;  
import jakarta.servlet.ServletException;  
import jakarta.servlet.http.*;  
import jakarta.servlet.annotation.*;

@WebServlet(name = "servlet", value = "/servlet")
public class MeuServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");

        // Receber os dados do formulário
        String nome = request.getParameter("nome");
        String email = request.getParameter("email");

        // Aqui você pode fazer o que quiser com os dados recebidos, como salvar em um banco de dados
        // ou simplesmente imprimir na saída
        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println("<h2>Dados Recebidos:</h2>");
        out.println("Nome: " + nome + "<br>");
        out.println("Email: " + email + "<br>");
        out.println("</body></html>");
    }
}
 ```


## 4. Validação dos Dados e Feedback ao Usuário:
Após receber os dados do formulário, é importante validar sua integridade e precisão. A validação pode incluir:

- **Validação de Campos Obrigatórios:** Garantir que os campos obrigatórios estejam preenchidos.
- **Validação de Formato:** Verificar se os dados inseridos seguem um formato específico, como endereços de e-mail válidos, números de telefone, datas, etc.
- **Validação de Tamanho:** Limitar o tamanho máximo dos dados para evitar entradas excessivamente longas que possam causar problemas de segurança ou desempenho.
- **Validação de Segurança:** Proteger contra ataques de injeção de código, como SQL injection e XSS (Cross-Site Scripting).


Após a validação **bem-sucedida dos dados**, o servidor pode proceder com o processamento final, que pode incluir o armazenamento dos dados no banco de dados, envio de confirmações por e-mail, redirecionamento para outras páginas, etc. 

Se ocorrerem erros de validação, é importante fornecer feedback claro e útil ao usuário. Por exemplo podemos indicar ao usuário os campos precisam ser corrigidos e quais problemas foram encontrados. A melhor maneira de se apresentar um feedback ao usuário pode estar descrita nos requisitos não funcionais, regras de negócio ou do contrato feito para construção do sistema.

## 4. Onde colocar a validação dos dados?

Em aplicações modernas, a tendencia é a separação lógica  entre os componentes da aplicação. Essa separação ocorre por pastas, pacotes, classes, funções e etc. 

A separação de responsabilidades tem diversas vantagens, dentre as quais destaco duas: i) a separação permitirá mais facilmente a identificação de um erro. Se existe uma camada de validação, e um dado inválido está sendo inserido no banco de dados, eu tenho certeza que o problemas está na camada de validação e não esparso pela aplicação; ii) o segundo ponto está relacionado com o aproveitamento de código. Por exemplo, ao se criar um algoritmo de validação para um valor que vem direto do formulário ao invés de encapsular esse algoritmo em um um método, vai me obrigar a reescrever esse método no futuro se precisar da mesma validação. 

Uma arquitetura comum que atende bem aplicações web pequenas e médias, é a arquitetura [MVC](https://pt.wikipedia.org/wiki/MVC). Esse modelo arquitetural define a separação entre classes que recebem e retornam dados aos clientes (Camada Controller), as classes que representam as Entidades ou Modelos do mundo real no sistema  (Camada Model) e a camada de apresentação dos dados aos usuários (Camada View). Uma `camada` poderá ser uma `pasta`, um `package`, um `namespace`. Vai depender da linguagem de programação usada;

Aqui você pode estar se perguntando, se a arquitetura é MVC, então o parágrafo acima começou a descrição pela `Controller`? Isso por toda arquitetura define não somente as camadas, mas como se dará a comunicação entre elas, e isso é a coisa mais importante de uma arquitetura. Como princípio, a arquitetura MVC (ao menos a maioria das literaturas) orientam que toda processo de requisição deve começar por uma `Controller`. Você até pode chamar uma tela, da camada `View` sem passar pela `Controller` e isso poderia funcionar muito bem, mas estaria quebrando os princípios da arquitetura e esse habito pode ser perigoso para a saúde de aplicação.   

Outro ponto importante é que em uma arquitetura MVC, outras camadas podem ser criadas. Existe até uma variante chamada de MVCRS (Model, View, Controller, Repository, Services) adicionando duas novas camadas, sendo elas Repository e Services, permitindo uma separação ainda maior das responsabilidades e maior entendimento dos recursos.

Na aplicação deste repositório, os dados estão sendo validados em uma camada chamada `Services`:

```java

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;

public class FormularioService {

    private final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

    /*** Verifica se o texto não é nulo ou possui menos de 2 caracteres ***/
    public String validaTexto(String textParam) throws IllegalArgumentException {

        if (textParam == null || textParam.length() < 2){
            throw new IllegalArgumentException("O valor informado é inválido");
        }

        return textParam.trim();
    }

    /*** Verifica se o número é maior que zero ***/
    public Integer validaNumero(String numeroParam) throws IllegalArgumentException {

        Integer numero = Integer.valueOf(numeroParam);

        if (numero < 0){
            throw new IllegalArgumentException("O valor informado não pode ser negativo");
        }

        return numero;
    }

    /*** Verifica se a lista de herois não está vazia ***/
    public ArrayList<String> validaCheckbox(String[] herois){

        ArrayList<String> list = new ArrayList<>();

        if (herois == null){
            throw new IllegalArgumentException("A lista de herois não pode estar vazia");
        }

        for (String s : herois) {
            list.add(s.toUpperCase());
        }

        return list;
    }

    /*** Verifica se a lista de herois não está vazia ***/
    public LocalDate validaData(String dataTexto){

        LocalDate data;
        try {
            data = LocalDate.parse(dataTexto);

        } catch (DateTimeParseException e1){
            try {
                data = LocalDate.parse(dataTexto, formatter);
            }catch (DateTimeParseException e2) {
                throw new IllegalArgumentException("O texto " + dataTexto + " não pode ser interpretado como uma data");
            }
        }

        return data;
    }

    public String getDataBrasil(LocalDate date){
        return date.format(formatter);
    }

}

```

