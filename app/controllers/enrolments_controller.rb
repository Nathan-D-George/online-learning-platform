class EnrolmentsController < ApplicationController
  before_action :this_course_teacher_only, only: [:set_status]
  before_action :teachers_only, only: [:see_status, :set_status, :one_status]

  def new
    @enrolment = Enrolment.new
    @course    = Course.find(params[:id].to_i)
  end

  def create
    enrolment = Enrolment.new
    enrolment.user_id  = Current.user.id
    enrolment.course_id = params[:enrolment][:course].to_i
    enrolment.status    = "pending"
    if enrolment.save 
      flash[:notice] = "Applied for Course"
      notification   = Notification.new
      notification.enrolment_new_notification(enrolment)
      notification.save
      redirect_to root_path
    else
      flash[:alert]  = "Something went wrong"
      render :new
    end
  end

  def del_fake
    @enrolment = Enrolment.where(user_id: Current.user.id, course_id: params[:id].to_i).first
  end

  def destroy
    @enrolment = Enrolment.find(params[:id].to_i)
    notification = Notification.new
    notification.enrolment_deleted_notification(@enrolment)
    notification.save
    @enrolment.destroy
    flash[:notice] = "Enrolment destroyed"
    redirect_to root_path
  end

  def see_status
    console
    @course     = Course.find(params[:id].to_i)
    @enrolments = @course.enrolments 
  end

  def one_status
    @enrolment = Enrolment.find(params[:id].to_i)
    @user      = User.find(@enrolment.user_id)
    @course    = Course.find(@enrolment.course_id)
  end

  def set_status
    enrolment        = Enrolment.find(params[:id].to_i)
    enrolment.status = params[:status]
    if enrolment.save
      user           = User.find(enrolment.user_id)
      course         = Course.find(enrolment.course_id)
      flash[:notice] = "#{user.name} added to #{course.name}"
      redirect_to see_status_path(id: course.id)
    else
      flash[:alert]  = "Something went wrong: set_applicant_status"
      render :one_status
    end
  end

  private

  def this_course_teacher_only
    enrolment = Enrolment.find(params[:id].to_i)
    course    = Course.find(enrolment.course_id)
    redirect_to list_courses_path, alert: 'You dont have the authoriy!' if course.user_id != Current.user.id
  end

  def teachers_only
    url_parts = request.fullpath.split('/')
    redirect_to list_courses_path, alert: 'You dont have the authority' if url_parts[2].include?('status') && Current.user.teacher == false
  end

end
