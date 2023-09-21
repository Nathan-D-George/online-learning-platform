class CoursesController < ApplicationController
  before_action :this_course_teacher_only, only:[:edit, :destroy]

  def new 
    @course = Course.new
    console
  end 
 
  def create 
    course = Course.new 
    course.name = params[:course][:name] 
    course.description = params[:course][:description] 
    course.user_id     = Current.user.id
    if course.save 
      flash[:notice] = 'Course Created' 
      redirect_to show_course_path(id: course.id) 
    else 
      flash[:alert]  = 'Something went wrong: course creation' 
      render :new 
    end 
  end 

  def show
    @course = Course.find(params[:id])
  end

  def list
    @courses = Course.all
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    course = Course.find(params[:id])
    course.name        = params[:course][:name]
    course.description = params[:course][:description]
    if course.save
      flash[:notice] = 'Course Updated'    
      redirect_to show_course_path(id: course.id)
    else
      flash[:alert]  = 'Something went wrong: course editing'
      render :edit
    end
  end

  def destroy
    @course = Course.find(params[:id].to_i)
    @course.destroy
    flash[:notice] = 'Course deleted'
    redirect_to root_path
  end

  private

  def this_course_teacher_only
    course = Course.find(params[:id].to_i)
    redirect_to show_course_path(id: course.id), alert: "Only this course's teacher can do this!" if Current.user.id != course.user_id
  end
end
