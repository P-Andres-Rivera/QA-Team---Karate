Feature: Casos de prueba del módulo store

  Scenario: CP001 - Consulta de inventario sin request
    Given url 'https://petstore.swagger.io'
    And path '/v2/store/inventory'
    When method get
    Then status 200
    And print response

  Scenario: CP001.1 - Consulta de inventario sin request con validación de respuesta
    #Segmentación en el path
    Given url 'https://petstore.swagger.io'
    And path 'v2', 'store', 'inventory'
    When method get
    Then status 200
    And print response
     # VALIDACIÓN 1: Que sea un objeto
    * match response == '#object'
     # VALIDACIÓN 2: Validar tipos de datos
    * match response.sold == '#number'
    # VALIDACIÓN 3: Validar valores específicos
    #* match response.sold == 146
    # VALIDACIÓN 4: Validar múltiples campos
    * match response contains {sold: #number,available: #number,pending: #number,SOLD: #number}
    # VALIDACIÓN 5: Validar que contenga ciertas claves (no todas)
    #* match response contains { sold: 146, available: 447 }
    # VALIDACIÓN 6: Contar las claves
    * match Object.keys(response).length == 11
    # VALIDACIÓN 9: Validar estructura completa
    #* match response ==d match response ==
  #   """
  #     {
  #       sold: 137,
  #       SOLD: 1,
  #       salt: 1,
  #       string: 343,
  #       Busy: 1,
  #       avaliable: 1,
  #       pending: 60,
  #       available: 441,
  #       'not available': 1,
  #       avalible: 1,
  #       unknown: 1
  #     }
  #   """


  Scenario: CP02 - Crear una orden con payload completo y validación de respuesta parcial
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

  Scenario: CP02.2 - Crear una orden y validación con response
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

  Scenario: CP02.3 - Crear una orden con validación con variable expectedResponse
    Given url 'https://petstore.swagger.io'
    And path 'v2','store','order'
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