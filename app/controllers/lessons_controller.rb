class LessonsController < ApplicationController
  before_action :only_teachers_allowed, except: [:show, :list]
  $course_id = nil
  def new
    @lesson = Lesson.new
    $course_id = params[:id].to_i
    debugger
  end

  def create
    lesson = Lesson.new
    lesson.name         = params[:lesson][:name]
    lesson.description  = params[:lesson][:description]
    lesson.lesson_files = params[:lesson][:lesson_files]
    lesson.course_id    = $course_id
    debugger
    if lesson.save
      flash[:notice] = 'Lesson created'
      redirect_to show_lesson_path(id: lesson.id)
    else
      flash[:alert]  = 'Something went wrong: lesson creation'
      render :new
    end
  end

  def edit
    @lesson = Lesson.find(params[:id].to_i)
  end

  def update
    lesson = Lesson.find(params[:id].to_i)
    debugger
  end

  def show
    @lesson = Lesson.find(params[:id].to_i)
  end

  def list
    @lessons = Lesson.all
  end

  def destroy
    @lesson = Lesson.find(params[:id].to_i)
    course  = Course.find(@lesson.courses_id)
    @lesson.destroy
    flash[:notice] = 'Lesson destroyed'
    redirect_to show_course_path(id: course.id)
  end

  private

  def only_teachers_allowed
    redirect_to root_path, alert: 'Only teachers can do these things' if Current.user.teacher != true
  end

end
