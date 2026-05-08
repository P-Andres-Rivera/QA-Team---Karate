Feature: Casos de prueba del módulo store

    Scenario: CP001 - Consulta de inventario
        Given url 'https://petstore.swagger.io'
        And path '/v2/store/inventory'
        When method get
        Then status 200
        And print response


  Scenario: CP02 - Crear una orden
    Given url 'https://petstore.swagger.io'
    And path '/v2/store/order'
    And header Content-Type = 'application/json'
    And request
    """
    {
      "id": 12,
      "petId":100,
      "quantity": 5,
      "shipDate": "2026-06-01T00:00:00.000Z",
      "status": "placed",
      "complete": true
    }
     """
    When method post
    Then status 200
    And match response contains {"id" : 12}
    And print response

  Scenario: CP02.1 - Crear una orden
    Given url 'https://petstore.swagger.io'
    And path '/v2/store/order'
    And header Content-Type = 'application/json'
    And request
  """
  {
    "id": 12,
    "petId":100,
    "quantity": 5,
    "shipDate": "2026-06-01T00:00:00.000Z",
    "status": "placed",
    "complete": true
  }
  """
    When method post
    Then status 200
    And match response contains {"id" : 12, "petId": 100, "quantity": 5, "status": "placed", "complete": true}
    And print response

  Scenario: CP02.2 - Crear una orden
    Given url 'https://petstore.swagger.io'
    And path '/v2/store/order'
    And header Content-Type = 'application/json'
    And request
  """
  {
    "id": 12,
    "petId":100,
    "quantity": 5,
    "shipDate": "2026-06-01T00:00:00.000Z",
    "status": "placed",
    "complete": true
  }
  """
    When method post
    Then status 200
    * match response.petId == 100
    * match response.quantity == 5
    * match response.status == 'placed'
    And print response

  Scenario: CP02.3 - Crear una orden
    Given url 'https://petstore.swagger.io'
    And path '/v2/store/order'
    And header Content-Type = 'application/json'
    And request
  """
  {
    "id": 12,
    "petId":100,
    "quantity": 5,
    "shipDate": "2026-06-01T00:00:00.000Z",
    "status": "placed",
    "complete": true
  }
  """
    When method post
    Then status 200
    * def expectedResponse =
    """
    {
    id: 12,
    petId: 100,
    quantity: 5,
    status: 'placed',
    complete: true
    }
    """
    * match response contains expectedResponse
    And print response