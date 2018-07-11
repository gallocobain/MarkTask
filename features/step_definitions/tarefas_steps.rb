Dado('que eu tenho uma tarefa com os atributos:') do |table|
  @tarefa = table.rows_hash
  @tarefa['titulo'] = "#{@tarefa['titulo']} - #{Faker::Lorem.characters(10)}"
end

Dado('eu quero taguear esta tarefa com:') do |table|
  @tags = table.hashes
end

Dado('eu já cadastrei esta tarefa e não tinha percebido') do
  @tasks.botao_novo.click
  @tasks.adicionar.nova(@tarefa, @tags)
end

Quando('faço o cadastro desta tarefa') do
  @tasks.botao_novo.click
  @tasks.adicionar.nova(@tarefa, @tags)
end

Então('devo ver este cadastro com status {string}') do |status_tarefa|
  @tasks.wait_for_itens
  expect(@tasks.itens.first).to have_content status_tarefa

  @tasks.busca(@tarefa['titulo'])
  expect(@tasks.itens.size).to eql 1
end

Então('devo ver a mensagem {string} ao tentar fazer o cadastro') do |mensagem|
  expect(@tasks.adicionar.mensagem.text).to eql mensagem
end

# Remover

Dado('que eu tenho uma tarefa cadastrada') do
  @tarefa_para_remover = {
    'titulo' => "Tarefa muito legal para remover - #{Faker::Lorem.characters(10)}",
    'data' => '01/06/2018'
  }
  @tags = []

  @tasks.botao_novo.click
  @tasks.adicionar.nova(@tarefa_para_remover, @tags)
end

Quando('eu solicito a exclusão desta tarefa') do
  @tasks.wait_for_itens
  @tasks.apagar_por_titulo(@tarefa_para_remover['titulo'])
end

Quando('confirmo a solicitação') do
  @tasks.confirma_modal.click
end

Quando('cancelo a solicitação') do
  @tasks.cancela_modal.click
end

Então('esta tarefa não deve ser exibida a lista') do

  # validando através da busca
  # @tasks.busca(@tarefa_para_remover['titulo'])
  # expect(@tasks.conteudo_pagina).to have_content 'Hmm... nenhuma tarefa encontrada :('

  # validando quando a busca está com bug
  @tasks.wait_for_itens

  # resultado = @tasks.itens.include?(@tarefa_para_remover['titulo'])
  # expect(resultado).to be false

  expect(@tasks.itens).not_to have_content @tarefa_para_remover['titulo']

end

Então('esta tarefa permance cadastrada na lista') do
  @tasks.busca(@tarefa_para_remover['titulo'])
  expect(@tasks.itens.first).to have_content @tarefa_para_remover['titulo']
end
