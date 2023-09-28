class AssessmentsController < ApplicationController
  before_action :teacher_only, only: [:new, :edit, :new_quiz]
  $course_id = nil
  $quiz_id   = nil
  $question_id   = nil
  $assessment_id = nil

  def new
    @assessment = Assessment.new
    $course_id  = params[:id].to_i
    console
  end

  def create
    assessment = Assessment.new
    assessment.name        = params[:assessment][:name]
    assessment.description = params[:assessment][:description]
    assessment.total       = params[:assessment][:total_marks].to_i
    assessment.assess_type = params[:assessment][:assessment_type]
    assessment.course_id   = $course_id
    debugger
    if assessment.save
      flash[:notice] = 'Assessment created'
      redirect_to new_quiz_path(id: assessment.id)
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
    # page for making a new quiz; specifiy num questions and total marks of the quiz
    @quiz          = Quiz.new
    @question      = Question.new
    @answer        = Answer.new
    @assessment    = Assessment.find(params[:id])
    $course_id     = @assessment.course_id
    $assessment_id = @assessment.id
  end

  def create_quiz
    # create and initialize a quiz; give it questions and give each question 5 answers
    quiz = Quiz.new
    quiz.course_id        = $course_id
    quiz.name             = params[:quiz][:name]
    quiz.number_questions = params[:quiz][:number_of_questions]
    quiz.assessment_id    = $assessment_id
    debugger
    if quiz.save
      quiz.number_questions.times do |iteration|
        question = Question.new(quiz_id: quiz.id)
        question.body = "Q#{iteration+1} "
        question.save
        5.times do |time|
          answer = Answer.new(question_id: question.id)
          answer.save
        end
      end
      flash[:notice] = "Quiz Initialized"
      redirect_to new_question_path(id: quiz.id)
    else
      flash[:alert] = "Something went wrong"
      render :new_quiz
    end
  end

  def new_question
    @question = Question.new
    @quiz     = Quiz.find(params[:id].to_i)
    $quiz_id  = params[:id].to_i
  end

  def create_question
    # question = Question.new(body: params[:question][:body], quiz_id: $quiz_id)
    quiz          = Quiz.find($quiz_id)
    question = quiz.questions.first  if params[:question][:question_no] == "1"
    question = quiz.questions.second if params[:question][:question_no] == "2"
    question = quiz.questions.third  if params[:question][:question_no] == "3"
    question = quiz.questions.fourth if params[:question][:question_no] == "4"
    question = quiz.questions.fifth  if params[:question][:question_no] == "5"
    question.body        = params[:question][:body]
    question.total_marks = params[:question][:total_marks]
    if question.save
      answers = question.answers
      answer1 = answers.first
      answer2 = answers.second
      answer3 = answers.third
      answer4 = answers.fourth
      answer5 = answers.fifth
      if params[:question][:option_1].present?
        answer1.body        = params[:question][:option_1]
        answer1.correct     = params[:question][:option_1_correct]
        answer1.question_id = question.id
        params[:question][:option_1_correct] == "true" ? answer1.correct = true : answer1.correct = false
        answer1.save
      end
      
      if params[:question][:option_2].present?
        answer2.body        = params[:question][:option_2]
        answer2.correct     = params[:question][:option_2_correct]
        answer2.question_id = question.id
        params[:question][:option_2_correct] == "true" ? answer2.correct = true : answer2.correct = false
        answer2.save
      end

      if params[:question][:option_3].present?
        answer3.body        = params[:question][:option_3]
        answer3.correct     = params[:question][:option_3_correct]
        answer3.question_id = question.id
        params[:question][:option_3_correct] == "true" ? answer3.correct = true : answer3.correct = false
        answer3.save
      end

      if params[:question][:option_4].present?
        answer4.body        = params[:question][:option_4]
        answer4.correct     = params[:question][:option_4_correct]
        answer4.question_id = question.id
        params[:question][:option_4_correct] == "true" ? answer4.correct = true : answer4.correct = false
        answer4.save
      end

      if params[:question][:option_5].present?
        answer5.body        = params[:question][:option_5]
        answer5.correct     = params[:question][:option_5_correct]
        answer5.question_id = question.id
        params[:question][:option_5__correct] == "true" ? answer5.correct = true : answer5.correct = false
        answer5.save
      end

      question.assign_answer
      question.save
      quiz.calculate_total_marks
      quiz.save
      flash[:notice] = "Added Question #{params[:question][:question_no].to_i}"
      # redirect_to new_question_path(id: quiz.id)
      redirect_to show_quiz_path(id: quiz.id)
    else
      flash[:alert] = 'Something went wrong: question and answer creation'
    end
  end

  def show_quiz
    # show structure of quiz, view num questions, access to edit questions and answers
    @quiz = Quiz.find(params[:id])
    @question = Question.new
  end

  def review_quiz
    @quiz = Quiz.find(params[:id].to_i)
  end

  def take_quiz
    @quiz = Quiz.find(params[:id].to_i)
  end
end
