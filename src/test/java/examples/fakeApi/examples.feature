Feature: Casos de prueba

  Scenario: CP001 - Crear un producto
    * def bodyProduct = read('bodyProducto.json')
    Given url "https://fakestoreapi.com"
    And path "/products"
    And request bodyProduct
    When method post
    Then status 201
    * match response == bodyProduct
    * match responseType == 'json'

Scenario: CP02 Actualizar cartas con archivo read con arreglo (each) y variables
  * def bodyCart = read('body-cart.json')
  * def id = 1
  Given url "https://fakestoreapi.com"
  And path "/carts/" + id
  And request bodyCart
  When method put
  Then status 200
  And match response.id == id
  * match each response.products[*] == {"id" : "#number"}
  * match response.products[0].id == 2

  Scenario: CP03 Get user single con variables de response
    * def userId = 1
    Given url "https://fakestoreapi.com"
    And path "users" , userId
    When method get
    Then status 200
    * def userIdResponse = response.id
    * match userId == userIdResponse
    #And match $.id  == userID : $ = response.id
    And match $.name contains {"firstname": "john","lastname": "doe"}

