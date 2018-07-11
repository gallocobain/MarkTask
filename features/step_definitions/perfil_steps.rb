Dado('que estou autenticado com {string} e {string}') do |email, senha|
  @login.load
  @login.logar(email, senha)
  @tasks.wait_for_table_body
end

Dado('acesso o meu perfil') do
  # @perfil.load # > usuário acessa via URL

  # > usuário acessa via link do menu superior
  @tasks.nav.menu_usuario.click
  @tasks.nav.meu_perfil.click
end

Quando('completo o meu cadastro com {string} e {string}') do |empresa, cargo|
  @perfil.atualiza(empresa, cargo)
end

Então('vejo a mensagem {string}') do |mensagem|
  expect(@perfil.formulario).to have_content mensagem
end

# upload

Dado('eu tenho uma foto muito bonita') do
  # @minha_foto = File.join(Dir.pwd, 'features/support/fixtures/foto1.png')
  @minha_foto = File.join(Dir.pwd, 'features/support/fixtures/foto2.jpg')
end

Quando('faço o upload da minha foto') do
  @perfil.upload(@minha_foto)
end

Então('devo ver a mensagem de upload com o texto {string}') do |mensagem|
  expect(@perfil.formulario).to have_content mensagem
end
