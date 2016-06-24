class WelcomeController < ApplicationController
    def index
        flash[:notice] = "早晨！你妹!"
    end
end
