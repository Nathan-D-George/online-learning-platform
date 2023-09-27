class AssessmentsController < ApplicationController
  before_action :teacher_only, only: [:new, :edit, :new_quiz]
  $course_id = nil
  $quiz_id   = nil

  def new
    @assessment = Assessment.new
    $course_id  = params[:id].to_i
  end

  def create
    assessment = Assessment.new
    assessment.name        = params[:assessment][:name]
    assessment.description = params[:assessment][:description]
    assessment.total       = params[:assessment][:total_marks].to_i
    assessment.assess_type = params[:assessment][:assessment_type]
    assessment.course_id   = $course_id
    if assessment.save
      flash[:notice] = 'Assessment created'
      redirect_to root_path
    else
      flash[:alert]  = 'Something went wrong: assessment creation'
      render :new
    end

  end

  def edit
    @assessment = Assessment.find(params[:id].to_i)
  end

  def update
    assessment = Assessment.find(params[:id].to_i)
    assessment.name = params[:assessment][:name]
    assessment.description = params[:assessment][:description]
    assessment.total       = params[:assessment][:total_marks]     if params[:assessment][:total_marks].present?
    assessment.assess_type = params[:assessment][:assessment_type]
    if assessment.save
      flash[:notice] = 'Assessment Created'
      redirect_to show_course_path(id: assessment.course_id)
    else
      flash[:alert]  = "Something went wrong"
      render :edit
    end
  end

  def destroy
    @assessment = Assessment.find(params[:id].to_i)
    course = Course.find(@assessment.course_id)
    flash[:notice] = "#{ @assessment.name }"
    @assessment.destroy
    redirect_to show_course_id(id: course.id)
  end

  def new_quiz
    @quiz       = Quiz.new
    @question   = Question.new
    @answer     = Answer.new
    @assessment = Assessment.new
    $course_id  = params[:id].to_i
  end

  def create_quiz
    quiz = Quiz.new
    quiz.course_id        = $course_id
    quiz.total            = params[:quiz][:total]
    quiz.number_questions = params[:quiz][:number_of_questions]
    if quiz.save
      $quiz_id = quiz.id
      flash[:notice] = 'Quiz initialized'
      redirect_to new_question_path(id: quiz.id)
    else
      flash[:alert] = 'Something went wrong'
      render :new_quiz
    end
  end

  def new_question
    @question = Question.new
    @quiz     = Quiz.find($quiz_id) if $quiz_id.present?
  end

  def create_question
    question = Question.new(body: params[:question][:body], quiz_id: $quiz_id)
    question.save

    if params[:question][:option_1].present?
      answer1 = Answer.new(body: params[:question][:option_1], correct: params[:question][:option_1_correct])
      answer1.question_id = question.id
      params[:question][:option_1_correct] == "true" ? answer1.correct = true : answer1.correct = false
      answer1.save
    end
    
    if params[:question][:option_2].present?
      answer2  = Answer.new(body: params[:question][:option_2], correct: params[:question][:option_2_correct])
      answer2.question_id = question.id
      params[:question][:option_2_correct] == "true" ? answer2.correct = true : answer2.correct = false
      answer2.save
    end

    if params[:question][:option_3].present?
      answer3  = Answer.new(body: params[:question][:option_3], correct: params[:question][:option_3_correct]) 
      answer3.question_id = question.id
      params[:question][:option_3_correct] == "true" ? answer3.correct = true : answer3.correct = false
      answer3.save
    end

    if params[:question][:option_4].present?
      answer4  = Answer.new(body: params[:question][:option_4], correct: params[:question][:option_4_correct]) 
      answer4.question_id = question.id
      params[:question][:option_4_correct] == "true" ? answer4.correct = true : answer4.correct = false
      answer4.save
    end

    if params[:question][:option_5].present?
      answer5  = Answer.new(body: params[:question][:option_5], correct: params[:question][:option_5_correct]) 
      answer5.question_id = question.id
      params[:question][:option_5__correct] == "true" ? answer5.correct = true : answer5.correct = false
      answer5.save
    end

    question.assign_answer
    question.save
    debugger
  end

end
