Feature:  Request and Response
  #Background:
   # Given url "https://restful-booker.herokuapp.com"

  Scenario: CP01 Crear token
    Given url "https://restful-booker.herokuapp.com"
    And path "/auth"
    And header Content-Type = "application/json"
    And request {"username" : "admin","password" : "password123"}
    When method post
    Then status 200
    And match response contains {"token" : "#string"}
    #* match $.token == "#string"

    Scenario: CP02 Create booking con request invocado desde un archivo json (read)
      Given url "https://restful-booker.herokuapp.com"
      And path "/booking"
      And request read('create-booking.json')
      When method post
      Then status 418
      #Flujo no se puede automatizar en karate por ambiente

  Scenario: CP02.1 Create booking con variables
    * def bodyBooking = read('create-booking.json')
    Given url "https://restful-booker.herokuapp.com"
    And path "/booking"
    And request bodyBooking
    When method post
    Then status 418
    #Flujo no se puede automatizar en karate por ambiente

  Scenario: CP03 Update booking con request form urlencoded y token
    * def id = 12
    Given url "https://restful-booker.herokuapp.com"
    And path "/booking/" + id
    And header Content-Type = "application/x-www-form-urlencoded"
    And header Authorization = "Basic YWRtaW46cGFzc3dvcmQxMjM="
    And  form field firstname = "Jim"
    And  form field lastname = "Brown"
    And  form field totalprice = 111
    And  form field depositpaid = true
    And  form field bookingdates[checkin] = "2018-01-01"
    And  form field bookingdates[checkout] = "2018-01-02"
    When method put
    Then status 418
    #Flujo no se puede automatizar en karate por ambiente

  Scenario: CP03.1 Update de request form urlencoded con read y form fields
    * def id = 12
    * def bodyBooking = read('update-booking.json')
    Given url "https://restful-booker.herokuapp.com"
    And path "/booking/" + id
    And header Content-Type = "application/x-www-form-urlencoded"
    And header Authorization = "Basic YWRtaW46cGFzc3dvcmQxMjM="
    And form fields read('update-booking.json')
    When method put
    Then status 400
    #Flujo no se puede automatizar en karate por ambiente

  Scenario: CP04 Delete booking con token
    * def id = 12
    Given url "https://restful-booker.herokuapp.com"
    And path "/booking/" + id
    And header Authorization = "token=da5f34b4425a9d2"
    When method delete
    Then status 201

