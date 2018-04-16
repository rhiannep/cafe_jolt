# Cafe Jolt

This implementation has:
* Two models, one for `Order` and one for `OrderItem`,
* A service to get items from the Kitchen API, that points to https://kitchen-service.herokuapp.com
* A service to post a new order to the Kitchen API http://localhost:5000
* A view and controller action to list the menu items from the Kitchen API
* A form and controller actions to create a new order
* A button and controller action to send the order to the Kitchen API
* A view and controller action to show the status of an order, including errors when the kitchen rejects the order

This implementation doesn't have:
* A job to listen for updates or an orders status
