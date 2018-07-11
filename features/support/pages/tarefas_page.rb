
require_relative 'sections'

class Adicionar < SitePrism::Section
  element :input_titulo, 'input[name=title]'
  element :input_data, 'input[name=dueDate]'
  element :input_tags, '.bootstrap-tagsinput input'
  element :salvar, '#form-submit-button'

  element :mensagem, '.alert-warn'

  def nova(tarefa, tags)
    input_titulo.set tarefa['titulo']
    input_data.set tarefa['data']

    tags.each do |tag|
      input_tags.set tag['tag']
      input_tags.send_keys :tab
      sleep 0.5 # think time \o/
    end

    salvar.click
  end
end

class TarefasPage < SitePrism::Page
  section :nav, Navbar, '#navbar'

  section :adicionar, Adicionar, '#add-task-view'

  element :confirma_modal, 'button[data-bb-handler=success]'
  element :cancela_modal, 'button[data-bb-handler=danger]'

  element :conteudo_pagina, '#tasks-view'

  element :titulo, '.header-title h3'
  element :botao_novo, '#insert-button'
  element :campo_busca, 'input[name=search]'
  element :botao_busca, '#search-button'

  element :table_body, 'table tbody'
  elements :itens, 'table tbody tr'


  def busca(titulo)
    campo_busca.set titulo
    botao_busca.click
  end

  def apaga_primeiro_item
    itens.first.find('#delete-button').click
  end

  def apagar_por_titulo(titulo)
    itens.each do |linha|
      if linha.text.include?(titulo)
        linha.find('#delete-button').click
      end
    end
  end


end
