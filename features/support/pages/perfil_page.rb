
require_relative 'sections'

class PerfilPage < SitePrism::Page
  set_url '/user_settings/profile'

  section :nav, Navbar, '#navbar'

  element :formulario, '#user-settings-profile-edit-form'
  element :input_empresa, 'input[name$=company]'
  element :combo_cargo, 'select[name$=job]'
  element :salvar, '#form-submit-button'

  def atualiza(empresa, cargo)
    input_empresa.set empresa
    combo_cargo.find('option', text: cargo).select_option
    salvar.click
  end

  def upload(foto)
    attach_file('profile-avatar', foto)
  end

end
