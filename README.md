# README

## Setup:

- docker-compose up
- bundle install
- bundle exec rails db:setup
- bundle exec rails db:migrate
- bundle exec rails db:seed
- bundle exec rails s

# Endpoints:

`Sample endpoints included in the endpoints.json file`

## GET /nps?touchpoint=0

### Lists nps data

### Parameters:

- touchpoint (required) [Available touchpoints : realtor_feedback: 0, realtor_support: 1, closed_deal: 2]
- respondent_class (optional)
- object_class (optional)

### Examples:

- `/nps?touchpoint=0`
- `/nps?touchpoint=0&respondent_class=seller`
- `/nps?touchpoint=0&object_class=realtor`
- `/nps?touchpoint=0&respondent_class=seller&object_class=realtor`

## GET /nps_survey/:token?score=:score

### Handles Nps submissions

### Parameters:

- touchpoint (required)
- score (required)[0 ~ 10]

### Examples:

- `http://127.0.0.1:3000/nps_survey/eyJfcmFpbHMiOnsibWVzc2FnZSI6Ik5BPT0iLCJleHAiOm51bGwsInB1ciI6Im5wcy9ucHNfc3VydmV5In19--6b8721b323ff44028b8c8e580fac0ca22ef444daed78e2a6dd1c0b5cf69f1773?score=10`

## GET /mock

### Mocks a nps creation

# How I solved this problem:

```
  Since the nps survey can happen in different steps and multiple times, I came up with a solution that involves a background job (Not implemented, mocked on the /mock route) that would be triggered whenever the user executes an action that needs a nps survey.
  This background job would use the NpsCreatorService to create the nps record and send the email to the user, with the url containing a unique token created in the service.

  The url is going to hit the NpsSurveyController's index action updating the nps score, if everything is valid.

  The token is unique and the controller only changes the nps score, making it difficult to tamper with the user's data.

  Given that the nps record is created beforehand, multiple submissions would not be a problem.

  The tokens could also have an expiration date, so the user can only resubmit in a certain period of time.

```
