# For more information see: http://emberjs.com/guides/routing/

App.Router.map ()->
  @resource 'surveyStep',
    path: 'survey_steps/:surveyStep_id'

App.SurveyStepRoute = Ember.Route.extend({
  model: (params) ->
    console.log("in SurveyStepRoute")
    @store.find('surveyStep', params.surveyStep_id)
    
  # need to populate allAnswerTypes in SurveyStepsController to populate a select
  # since pulling from a different model than surveyStep must do it from here
  setupController: (controller, model) ->
    @_super controller, model
    
    @store.find("answerType").then (answerTypes)->
      controller.set("answerTypes", answerTypes.sortBy('name'))
    
    return
})