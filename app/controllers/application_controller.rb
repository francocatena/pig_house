class ApplicationController < ActionController::Base
  protect_from_forgery

  # Cualquier excepción no contemplada es capturada por esta función. Se utiliza
  # para mostrar un mensaje de error personalizado
  rescue_from Exception do |exception|
    begin
      @title = t :'errors.title'

      unless response.redirect_url
        render :template => 'shared/show_error', :locals => {:error => exception}
      end

    # En caso que la presentación misma de la excepción no salga como se espera
    rescue => ex
      STDERR << "#{ex.class}: #{ex.message}\n\n"
      ex.backtrace.each { |l| STDERR << "#{l}\n" }
    end
  end
end