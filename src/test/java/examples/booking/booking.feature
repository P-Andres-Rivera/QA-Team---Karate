Feature: Casos de booking

  Scenario: CP001 Filtro por fecha de libros con param
    Given url "https://restful-booker.herokuapp.com"
    And path "/booking"
    And param checkin = "2014-03-13"
    And param checkout = "2020-05-21"
    When method get
    Then status 200

  Scenario: CP001.1 Filtro por fecha de libros con params
    Given url "https://restful-booker.herokuapp.com"
    And path "/booking"
    #And params checkin = "2014-03-13" , checkout = "2020-05-21"
    And params {checkin : "2014-03-13" , checkout : "2020-05-21"}
    When method get
    Then status 200



