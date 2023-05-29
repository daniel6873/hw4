class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by({ "email" => params["email"] })
    if @user
      if BCrypt::Password.new(@user["password"]) == BCrypt::Password.params["password"]
        session["user_id"] = @user["id"]
        flash["notice"] = "Welcome, #{@user["username"]}."
        redirect_to "/companies"
      else
        flash["notice"] = "Nope."
        redirect_to "/login"
      end
    else
      flash["notice"] = "Nope."
      redirect_to "/login"
    end

  end

  def destroy
    flash["notice"] = "Goodbye."
    session["user_id"] = nil
    redirect_to "/login"
  end
end
  