class Notification < ApplicationRecord

  after_create_commit { broadcast_append_to "notifications" }

  enum kind: %i[notice alert]

  def new_registration_notification(user)
    self.kind = "notice"
    self.name = "#{DateTime.now.strftime("%Y %b %d %Hh%M")} - new user #{user.name}"
  end

  def course_new_notification(course)
    self.kind = "notice"
    self.name = "#{DateTime.now.strftime("%Y %b %d %Hh%M")} - New Course created #{course.name}"
  end
  
  def course_deleted_notification(course)
    self.kind = "alert"
    self.name = "#{DateTime.now.strftime("%Y %b %d %Hh%M")} - course #{course.name} deleted"
  end

  def assessment_results_notificaion(assessment)
    self.kind = "notice"
    self.name = "#{DateTime.now.strftime("%Y %b %d %Hh%M")} - assessment results released"
  end

  def assessment_new_notification(assessment)
    self.kind = "notice"
    self.name = "#{DateTime.now.strftime("%Y %b %d %Hh%M")} - new assessment created #{assessment.name}"
  end

  def assessment_update_notification(assessment)
    self.kind = "notice"
    self.name = "#{DateTime.now.strftime("%Y %b %d %Hh%M")} - assessment #{assessment.name} edited"
  end

  def enrolment_new_notification(enrolment)
    self.kind = "notice"
    self.name = "#{DateTime.now.strftime("%Y %b %d %Hh%M")} - new enrolment"
  end

  def enrolment_deleted_notification(enrolment)
    self.kind = "alert"
    self.name = "#{DateTime.now.strftime("%Y %b %d %Hh%M")} - enrolment cancelled"
  end

  def chatroom_message_notification(course)
    self.kind = "notice"
    self.name = "#{DateTime.now.strftime("%Y %b %d %Hh%M")} - new message in #{course.name} chatroom"
  end

  def lesson_new_notification(lesson)
    self.kind = "notice"
    self.name = "#{DateTime.now.strftime("%Y %b %d %Hh%M")} - new lesson in #{Course.find(lesson.course_id).name}"
  end

  def lesson_updated_notification(lesson)
    self.kind = "notice"
    self.name = "#{DateTime.now.strftime("%Y %b %d %Hh%M")} - lesson #{lesson.name} updated in course #{Course.find(lesson.course_id).name}"
  end

  def lesson_deleted_notification(lesson)
    self.kind = "alert"
    self.name = "#{DateTime.now.strftime("%Y %b %d %Hh%M")} - lesson #{lesson.name} from course #{Course.find(lesson.course_id).name} deleted"
  end

end
