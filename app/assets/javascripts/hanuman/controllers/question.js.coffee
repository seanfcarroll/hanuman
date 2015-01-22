App.QuestionController = Ember.ObjectController.extend({
  needs: ["answer_choices", "answer_types", "survey_step"]
  
  # called inside question controller because of has_many relationship for each question-kdh
  answer_choices: (->
    Ember.ArrayProxy.createWithMixins Ember.SortableMixin,
      sortProperties: ["group_text","option_text"],
      content: @get("content.answer_choices")
  ).property("content.answer_choices")
  
  # sort answer_choices by group_text, option_text
  # filter out null group_text since those are parents and don't want them in select
  grouped_answer_choices: (->
    Ember.ArrayProxy.createWithMixins Ember.SortableMixin,
      sortProperties: ["group_text","option_text"],
      content: @.get("content.answer_choices").filter (answer_choice) ->
        if answer_choice.get('group_text') 
          answer_choice
  ).property("content.answer_choices")
  
  root_level_answer_choices: (-> 
    return @.get("content.answer_choices").filterBy('group_text', '')
  ).property("content.answer_choices")
  
  # retrieve fully editable flag from survey template to determine editing rules
  isFullyEditable: (->
    return @get('survey_step').get('survey_template').get('fully_editable')
  ).property('survey_step.survey_template.fully_editable')
  
  actions:
    editQuestion: ->
      @set "isEditing", true
      question = @get('model')
      if question.get('answer_type').get('hasAnswerChoices')
        @set "showAnswerChoices", true
      
    exitEditQuestion: ->
      @set "isEditing", false
      
    saveQuestion: ->
      question = @get('model')
      question.save()
      @set "isEditing", false
      
    deleteQuestion: ->
      question = @get('model')
      question.deleteRecord()
      question.save()
      
    newAnswerChoice: ->
      @set "isNewAnswerChoice", true
      
    exitCreateAnswerChoice: ->
      @set "isNewAnswerChoice", false
      
    createAnswerChoice: ->
      question = @get('model')
      answer_choice = @store.createRecord('answer_choice',
        option_text: @get('option_text')
        question: @get('model')
      )
      controller = @
      answer_choice.save().then (answer_choice) ->
        controller.set('option_text', '')
        question.get('answer_choices').addObject(answer_choice)
      @set "isNewAnswerChoice", false
  
  isEditing: false
  isNewAnswerChoice: false
  showAnswerChoices: false
})