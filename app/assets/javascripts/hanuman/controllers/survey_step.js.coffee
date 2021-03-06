App.SurveyStepController = Ember.ObjectController.extend(
  needs: ["answerChoices", "answerTypes"]
  
  questionText: null
  selected_answerType_id: null
  isNewQuestion: false
  validationError: false
  
  # retrieve fully editable flag from survey template to determine editing rules
  isFullyEditable: (->
    return @get('surveyTemplate').get('fullyEditable')
  ).property('surveyTemplate.fullyEditable')
  
  # questionsCount used to determine next sortOrder value when adding a new question to a step
  questionsCount: (->
    return @get('questions').get('length')
  ).property('questions.length')
  
  # drag and drop sort order method
  updateSortOrder: (indexes) ->
    console.log "in updateSortOrder"
    @beginPropertyChanges()
    @get('questions').forEach (question) ->
      index = indexes[question.get("id")]
      question.set "sortOrder", index + 1
      question.save()
    @endPropertyChanges()
    
)