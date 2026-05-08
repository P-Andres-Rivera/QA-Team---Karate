Feature: Casos de prueba del módulo de usuario

  Scenario: CP01 - Actualizar Usuario
    * def username = "Carlos"
    Given url 'https://petstore.swagger.io'
    And path "/v2/user/" + username
    And header Content-Type = 'application/json'
    And request
    """
      {  "id": 9009,
        "username": "Carlos",
        "firstName": "Carlos",
        "lastName": "Gomez",
        "email": "ss",
        "password": "ss",
        "phone": "ss",
        "userStatus": 0
      }
    """
    When method put
    Then status 200
    And match response contains {"code": 200,"type": "unknown","message": "9009"}
    And print response