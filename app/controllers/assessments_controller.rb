class AssessmentsController < ApplicationController
  before_action :teacher_only, only: [:new, :edit, :new_quiz]
  $course_id = nil
  $quiz_id   = nil
  $question_id   = nil
  $assessment_id = nil
  $quiz = Quiz.new

  def new
    @assessment = Assessment.new
    $course_id  = params[:id].to_i
    @course     = Course.find(params[:id].to_i)
    console
  end

  def create
    assessment = Assessment.new
    assessment.name        = params[:assessment][:name]
    assessment.description = params[:assessment][:description]
    assessment.total       = params[:assessment][:total_marks].to_i
    assessment.assess_type = params[:assessment][:assess_type]
    assessment.course_id   = params[:assessment][:course].to_i
    debugger
    if assessment.save
      flash[:notice] = 'Assessment Created'
      notification   = Notification.new
      notification.assessment_new_notification(assessment)
      notification.save
      redirect_to new_quiz_path(id: assessment.id) if assessment.assess_type == "quiz"
      redirect_to new_test_path(id: assessment.id) if assessment.assess_type == "test"
    else
      flash[:alert]  = 'Something went wrong: assessment creation'
      render :new
    end
  end

  def new_test
    @assessment    = Assessment.find(params[:id].to_i)
    $assessment_id = @assessment.id
  end
  
  def add_paper
    assessment = Assessment.find($assessment_id)
    assessment.question_papers = params[:assessment][:file] if params[:assessment][:file].present?
    if assessment.save
      flash[:notice] = 'Successfully added question paper'
      redirect_to show_assessment_path(id: assessment.id)
    else
      flash[:alert]  = 'Something went wrong: adding paper to assessment'
      render :new_test
    end
  end

  def show
    @assessment = Assessment.find(params[:id].to_i)
    @course     = Course.find(@assessment.course_id) 
    @test       = Test.new
    test1       = Test.where(assessment_id: @assessment.id, user_id: Current.user.id).first
    redirect_to test_results_path(id: test1.id) if test1.present?
  end

  def edit
    @assessment = Assessment.find(params[:id].to_i)
    @course     = Course.find(@assessment.course_id)
  end

  def update
    assessment = Assessment.find(params[:id].to_i)
    assessment.name = params[:assessment][:name]
    assessment.description = params[:assessment][:description]
    assessment.total       = params[:assessment][:total_marks] if params[:assessment][:total_marks].present?
    assessment.assess_type = params[:assessment][:assess_type]
    assessment.question_papers = params[:assessment][:file]     if params[:assessment][:file].present?
    if assessment.save
      flash[:notice] = 'Assessment Updated'
      notification   = Notification.new
      notification.assessment_update_notification(assessment)
      notification.save
      redirect_to show_course_path(id: assessment.course_id)
    else
      flash[:alert]  = "Something went wrong"
      render :edit
    end
  end
  
  def list
    @course  = Course.find(params[:id].to_i)
    @quizzes = @course.quizzes.order(id: :desc) 
    @pic     = "https://images.unsplash.com/photo-1471107340929-a87cd0f5b5f3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8bm90ZXBhZCUyMGFuZCUyMHBlbnxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60"
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
    @assessment    = Assessment.find(params[:id].to_i)
    @course        = Course.find(@assessment.course_id)
    $assessment_id = @assessment.id
  end

  def create_quiz
    # create and initialize a quiz; give it questions and give each question 5 answers
    quiz = Quiz.new
    quiz.course_id        = params[:quiz][:course].to_i
    quiz.name             = params[:quiz][:name]
    quiz.number_questions = params[:quiz][:number_of_questions]
    quiz.assessment_id    = params[:quiz][:assessment].to_i
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
      flash[:alert]  = "Something went wrong"
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
    quiz     = Quiz.find($quiz_id)
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
    $quiz_id = params[:id].to_i
    mark  = Mark.where(user_id: Current.user.id, quiz_id: @quiz.id).first
    redirect_to quiz_results_path(id: @quiz.id), alert: 'Already written the quiz' if mark.present? && mark.achievable >= @quiz.total_marks
  end

  def submit_quiz
    quiz = Quiz.find($quiz_id)
    mark = Mark.new(user_id: Current.user.id, quiz_id: $quiz_id)         if Mark.where(user_id: Current.user.id, quiz_id: $quiz_id).first.blank?
    mark = Mark.where(user_id: Current.user.id, quiz_id: $quiz_id).first if Mark.where(user_id: Current.user.id, quiz_id: $quiz_id).first.present?
    quiz.questions.each_with_index do |question, index|
      if index+1 == params[:question][:question_no].to_i
        answer = question.answers[params[:question][:answer].to_i-1]
        mark.achieved   += question.total_marks if answer.correct == true
        mark.achievable += question.total_marks
        mark.save
      end
    end
    redirect_to quiz_results_path(id: quiz.course_id), notice: "You've completed the quiz" if mark.achievable >= quiz.total_marks
  end

  def results
    @quiz = Quiz.find(params[:id])
    @mark = Mark.where(quiz_id: @quiz.id, user_id: Current.user.id).first
    marks = Mark.where(quiz_id: @quiz.id).all
    total = 0
    marks.each {|mark|
      total += mark.achieved
    }
    @average = total.to_f / marks.length
  end

  def t_list
    @course = Course.find(params[:id].to_i)
    @tests  = @course.assessments.where(assess_type: "test").all
  end

  def t_results
    @test       = Test.find(params[:id].to_i)
    @assessment = Assessment.find(@test.assessment_id)
    @user       = User.find(@test.user_id)
  end

  def submit_test
    test = Test.new
    test.user_id       = Current.user.id
    test.assessment_id = params[:test][:assessment_id]
    test.answer_book   = params[:test][:answer_book]       # params[:test][:answer_book]
    assessment = Assessment.find(params[:test][:assessment_id].to_i)
    test.total = assessment.total
    course     = Course.find(assessment.course_id)
    if test.save
      flash[:notice] = 'Test submitted successfully'
      redirect_to show_course_path(id: course.id)
    else
      flash[:alert]  = 'Something went wrong: test submission'
      render :show 
    end
  end

end
