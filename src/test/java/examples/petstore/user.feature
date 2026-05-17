Feature: Casos de prueba del módulo de usuario

    Scenario: CP01 - Actualizar Usuario con payload completo y validación de respuesta parcial
        * def username = "Carlos"
    Given url 'https://petstore.swagger.io'
    And path "/v2/user/" + username
    And header Content-Type = 'application/json'
    And request
    """
      {  "id": 9009,
        "username": "Carlos",
        "firstName": "Carlos","lastName": "Gomez",
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

   Scenario: CP02 Login con query param y match
       Given url "https://petstore.swagger.io/v2"
       And path 'user','login'
       And param username = "Carlos"
       And param password = "123345"
       When method get
       Then status 200
       * match response.message == "#string"