class WelcomeController < ApplicationController

  def ubike

    @ubikes = Ubike.all

  end

end
