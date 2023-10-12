class LessonsController < ApplicationController
  before_action :only_teachers_allowed, except: [:show, :list]
  $course_id = nil

  def new
    @lesson = Lesson.new
    $course_id = params[:id].to_i
    @course    = Course.find(params[:id].to_i)
  end

  def create
    lesson = Lesson.new
    lesson.name         = params[:lesson][:name]
    lesson.description  = params[:lesson][:description]
    lesson.lesson_files = params[:lesson][:lesson_files]
    lesson.course_id    = $course_id
    if lesson.save
      flash[:notice] = 'Lesson created'
      notification   = Notification.new
      notification.lesson_new_notification(lesson)
      notification.save
      redirect_to show_lesson_path(id: lesson.id)
    else
      flash[:alert]  = 'Something went wrong: lesson creation'
      render :new
    end
  end

  def edit
    @lesson = Lesson.find(params[:id].to_i)
    @course = Course.find(@lesson.course_id)
  end

  def update
    lesson = Lesson.find(params[:id].to_i)
    lesson.name         = params[:lesson][:name]
    lesson.description  = params[:lesson][:description]
    lesson.lesson_files = params[:lesson][:lesson_files] if params[:lesson][:lesson_files].present?
    if lesson.save
      flash[:notice] = 'Course successfully updated'
      notification   = Notification.new
      notification.lesson_updated_notification(lesson)
      notification.save
      redirect_to show_lesson_path(id: lesson.id)
    else
      flash[:alert]  = 'Something went wrong: updating lesson'
      render :edit
    end
  end

  def show
    @lesson = Lesson.find(params[:id].to_i)
    @course = Course.find(@lesson.course_id)
  end

  def list
    @lessons = Lesson.where(course_id: params[:id].to_i).all.order(id: :desc)
    @course  = Course.find(params[:id])
  end

  def destroy
    @lesson = Lesson.find(params[:id].to_i)
    course  = Course.find(@lesson.course_id)
    notification = Notification.new
    notification.lesson_deleted_notification(@lesson)
    notification.save
    @lesson.destroy
    flash[:notice] = 'Lesson destroyed'
    redirect_to show_course_path(id: course.id)
  end

  private

  def only_teachers_allowed
    redirect_to root_path, alert: 'Only teachers can do these things' if Current.user.teacher != true
  end

end
