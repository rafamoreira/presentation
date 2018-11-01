terminal:

rails generate scaffold Comment name:string email:string content:text article:references

rake db:migrate

escreve os testes de integração

ve falhar

adiciona o form de comentários no article

instala o shoulda matchers

adiciona o relacionamento do article com comments

roda novamente os testes

ve falhar

adiciona os skips before action no controller de comments

continua falhando o primeiro teste

edita o controller para redirecionar para o artigo e não o comment

adiciona a renderização de comentários no artigo


adicion o comments no controller


agora os erros de validação

adiciona os testes unitários para o comments


corrige mais um redirect dos comments


adicionar o botão de delete comment na view


ajustar o redirect quando deletar comentarios
