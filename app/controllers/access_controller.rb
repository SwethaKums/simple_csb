class AccessController < ApplicationController
  layout'admin'
  before_action :logged_in_restriction, :except=>[:login,:attempt_login,:logout]

  def menu
    @teacher=Teacher.find_by(id:session[:user_id])
  end

   def login
       #login
   end

  def attempt_login
    if params[:first_name].present? && params[:password].present?
      found_user = Teacher.where(:first_name => params[:first_name]).first
      if found_user
         authorized_user = found_user.authenticate(params[:password])
      end
    end

    if authorized_user

      session[:user_id] = authorized_user.id
      flash[:notice] = "You are now logged in."
      redirect_to(access_menu_path)
    else
      flash.now[:notice] = "Invalid username/password combination."
      render('login')
    end

  end

  def logout
      

    session[:user_id] = nil
    flash[:notice] = 'Logged out'
    redirect_to(access_login_path)
  end


end