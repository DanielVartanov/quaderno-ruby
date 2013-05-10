# Quaderno-ruby

Quaderno-ruby is a ruby wrapper for [quaderno api] (https://github.com/recrea/quaderno-api).

As the api, it's mostly crud.

## Installation & Configuration

To install add the following to your Gemfile:

```ruby
	gem 'quaderno-ruby', require 'quaderno-ruby'
```

To configure just add this to your initializers

```ruby
	Quaderno::Base.configure do |config|
		config.auth_token = 'my_authenticate_token'
		config.subdomain = 'my_account_subdomain'
	end
```

## Ping the service
 You can ping the service in order to check if it is up with: 
 
```ruby
  Quaderno::Base.ping #=> Boolean
```

This will return true if the service is up or false if it is not.

## Check the rate limit

```ruby
  Quaderno::Base.rate_limit_info #=>  { :limit => 100, :remaining => 100 }
```

This will return a hash with information about the rate limit and your remaining requestes

## Reading the values

Quaderno-ruby parses all the json responses in human readable data, so you can access each value just like this:

```ruby
  contact.id 
  invoice.items
  estimates.payments
  etc.
```

## Managing contacts
 
### Getting contacts
```ruby
 Quaderno::Contact.all(1) #=> Array
```

 will return an array with all your contacts on the first page.
 
### Finding a contact
```ruby
 Quaderno::Contact.find(id) #=> Quaderno::Contact
```

will return the contact with the id passed as parameter.

### Creating a new contact
```ruby
 Quaderno::Contact.create(params) #=> Quaderno::Contact
```

will create a contact using the information of the hash passed as parameter and return an instance of Quaderno::Contact with the created contact.

### Updating an existing contact
```ruby
 Quaderno::Contact.update(id, params) #=> Quaderno::Contact
```

will update the specified contact with the data of the hash passed as second parameter.

### Deleting a contact
```ruby
  Quaderno::Contact.delete(id) #=> Boolean
```

will delete the contact with the id passed as parameter.

 
## Managing invoices

### Getting invoices
```ruby
  Quaderno::Invoice.all(1) #=> Array
```

 will return an array with all your invoices on the first page.
 
### Finding an invoice
```ruby
  Quaderno::Invoice.find(id) #=> Quaderno::Invoice
```

will return the invoice with the id passed as parameter.

### Creating a new invoice

```ruby
  Quaderno::Invoice.create(params) #=> Quaderno::Invoice
```

will create an invoice using the information of the hash passed as parameter.

### Updating an existing invoice
```ruby
  Quaderno::Invoice.update(id, params) #=> Quaderno::Invoice
```

will update the specified invoice with the data of the hash passed as second parameter.

### Deleting an invoice

```ruby
  Quaderno::Invoice.delete(id) #=> Boolean
```

will delete the invoice with the id passed as parameter.

 
###Adding or removing a payment
 In order to  add a payment you will need the Invoice instance you want to update.
 
```ruby
  invoice = Quaderno::Invoice.find(invoice_id)
  invoice.add_payment(params) #=> Quaderno::Payment
```

Where params is a hash with the payment information. The method will return the an instance of Quaderno::Payment wich contains the information of the payment.

In order to  remove a payment you will need the Invoice instance you want to update.
 
```ruby
  invoice = Quaderno::Invoice.find(invoice_id)
  invoice.remove_payment(payment_id) #=> Boolean
``` 
 
###Delivering the invoice

  In order to deliver the estimate to the default recipient you will need the estimate you want to send.
  
```ruby
  invoice = Quaderno::Invoice.find(invoice_id)
  invoice.deliver
```


## Managing estimates


### Getting estimates
```ruby
  Quaderno::Estimate.all(1) #=> Array
```

 will return an array with all your estimates on the first page.
 
### Finding an estimate
```ruby
  Quaderno::Estimate.find(id) #=> Quaderno::Estimate
```

will return the estimate with the id passed as parameter.

### Creating a new estimate

```ruby
  Quaderno::Estimate.create(params) #=> Quaderno::Estimate
```

will create an estimate using the information of the hash passed as parameter.

### Updating an existing estimate
```ruby
  Quaderno::Estimate.update(id, params)
```

will update the specified estimate with the data of the hash passed as second parameter.

### Deleting an estimate

```ruby
  Quaderno::Estimate.delete(id) #=> Boolean
```

will delete the estimate with the id passed as parameter.

 
###Adding or removing a payment
 In order to add a payment you will need the estimate you want to update.
 
```ruby
  estimate = Quaderno::Estimate.find(estimate_id)
  estimate.add_payment(params) #=> Quaderno::Payment
```

Where params is a hash with the payment information. The method will return the an instance of Quaderno::Payment wich contains the information of the payment.

In order to  remove a payment you will need the estimate you want to update.
 
```ruby
  estimate = Quaderno::Estimate.find(estimate_id)
  estimate.remove_payment(payment_id) #=> Boolean
``` 
 
###Delivering the estimate
  In order to deliver the estimate to the default recipient you will need the estimate you want to send.
  
```ruby
  estimate = Quaderno::Estimate.find(estimate_id)
  estimate.deliver
```

 
## Managing expenses

### Getting expenses
```ruby
 Quaderno::Expense.all(1) #=> Array
```

 will return an array with all your expenses on the first page.
 
### Finding an expense
```ruby
 Quaderno::Expense.find(id) #=> Quaderno::Expense
```

will return the expense with the id passed as parameter.

### Creating a new expense
```ruby
 Quaderno::Expense.create(params) #=> Quaderno::Expense
```

will create an expense using the information of the hash passed as parameter and return an instance of Quaderno::Expense with the created expense.

### Updating an existing expense
```ruby
 Quaderno::Expense.update(id, params) #=> Quaderno::Expense
```

will update the specified expense with the data of the hash passed as second parameter.

### Deleting an expense
```ruby
  Quaderno::Expense.delete(id) #=> Boolean
```

will delete the expense with the id passed as parameter.


## Quaderno-api 

For further information, please visit [quaderno api] (https://github.com/recrea/quaderno-api) wiki