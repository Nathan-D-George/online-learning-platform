class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new
    user.name     = params[:user][:name]
    user.email    = params[:user][:email]
    user.teacher  = true  if params[:user][:teacher] == "teacher"
    user.teacher  = false if params[:user][:teacher] == "learner"
    user.photo    = params[:user][:photo] if params[:user][:photo].present?
    user.password = params[:user][:password]
    user.password_confirmation = params[:user][:password_confirmation]
    if user.save
      flash[:notice] = "Account Created"
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:alert]  = 'Something went wrong'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.name  = params[:user][:name]
    user.email = params[:user][:email]
    user.photo = params[:user][:photo] if params[:user][:photo].present?
    user.teacher = true  if params[:user][:teacher] == "teacher"
    user.teacher = false if params[:user][:teacher] == "learner"
    if user.save
      flash[:notice] = 'Account Information Updated'
      redirect_to show_user_path(id: user.id)
    else
      flash[:alert]  = 'Something went wrong: updating account'
      render :edit
    end    
  end

  def show
    @user = User.find(params[:id].to_i)
    if @user.teacher == true
      @courses = []
      Course.all.each{|course|
        @courses.append(course) if course.user_id == Current.user.id
      }
    else
      @courses = []
      enrolments = Current.user.enrolments
      enrolments.each{|enrolment|
        @courses.append(Course.find(enrolment.course_id))
      }
    end
  end

  def destroy
    @user = User.find(params[:id])
    return if @user.id != Current.user.id
    @user.destroy
    flash[:notice] = "Account has been Permanently Deleted"
    redirect_to root_path
  end
end
