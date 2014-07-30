# FormRelayer

Makes it easier to relay received POST params in current form for further POSTing. This is ideal if you want to insert an intermediate page during POSTing, such as an order confirmation page.

## Installation

Add this line to your application's Gemfile:

    gem 'form_relayer'

And then execute:

    $ bundle install

## Usage

In Rails view, place a call to `relay_received_post_params` inside the form.

    <%= form_for @post do |f| %>
      Are you sure you want to continue?
      <%= relay_received_post_params %>
      <%= f.submit 'Yes' %>
    <% end %>

This will automatically turn POST params received by the current action into hidden input tags.

## Contributing

1. Fork it ( https://github.com/GoodLife/form_relayer/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
