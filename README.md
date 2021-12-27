# Flutter - Internalization

> **obs1.:** Para uso do webApi de exemplo, vá a pasta **WebApiStudies** e no arquivo README tem toda a descrição de utilização.
> 
> **obs2.:** Senha padrão para transferências é o valor 1000. 
> 
> **obs3.:** Alterar a url do `webclient.dart` para o seu ip local `const String baseUrl = 'http://<IP DA SUA MAQUINA AQUI>:8080/transactions';`

## Objetivos ao completar os estudos
- Mostre o carregamento das mensagens
- Carregue as mensagens de várias idiomas de maneira assíncrona
- Trabalhe com um servidor externo para carregas as mensagens sob demanda
- Use cache local para otimizar o carregamento
- Organize o seu app em camadas e avance nas boas práticas

## Ementas:

### Componentes de Internacionalização
- Internacionalização
- Faça como eu fiz
- O que aprendi?
  - A *localização* (`l18n`) é relacionada com a formatação de data, moeda, números em geral, etc (o seu app se adapta ao local)
  - A *internacionalização* (`i18n`) é relacionada ao atender vários idiomas
  - Para trabalhar com a *Internacionalização*, usamos o `LocalizationContainer`, que deve estender o `StatelessContainer` (ou `BlocContainer`), que encapsula a linguagem (`Cubit<String>`) e associa ao *context*
  - Usamos um componente de i18n por tela, que encapsula a recuperação das mensagens

### Assert e mensagens eager
- Cuidados e Variações
- Eager ou Lazy?
- Preguiçoso ou Ansioso?
- Faça como eu fiz
- O que aprendi?

### i18n de maneira lazy
- Framework de i18n
- i18n Lazy
- Faça como eu fiz
- O que aprendi?

### Telas e Locale
- i18n do servidor remoto
- Várias Telas e Locale
- Faça como eu fiz
- O que aprendi?

### Cache local e boas práticas
- Cache local eterno
- LocalStorage
- BlocProvider e Builder
- Organizando o Código
- Faça como eu fiz
- Projeto completo do curso
- Conclusão
- O que aprendi?

***

## Flutter project screens - myBank App
<p float="left">
<!-- <img src="assets/img/Screenshot (1).png" width="200">
<img src="assets/img/Screenshot (2).png" width="200">
<img src="assets/img/Screenshot (3).png" width="200">
<img src="assets/img/Screenshot (4).png" width="200">
<img src="assets/img/Screenshot (5).png" width="200">
<img src="assets/img/Screenshot (6).png" width="200">
<img src="assets/img/Screenshot (7).png" width="200">
<img src="assets/img/Screenshot (8).png" width="200">
<img src="assets/img/Screenshot (9).png" width="200">
<img src="assets/img/Screenshot (10).png" width="200">
<img src="assets/img/Screenshot (11).png" width="200">
<img src="assets/img/Screenshot (12).png" width="200"> -->
</p>
