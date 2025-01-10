module BetterValidations::Object
  extend ActiveSupport::Concern
  included do

    # A helper method to get messages without a reference to 'errors'
    def detailed_errors_messages(wrap_attributes_to)
      errors.detailed_messages(wrap_attributes_to:)
    end

    # Define a 'client_id' attribute for ActiveRecord::Base that can
    # be used to identify objects in the error response.
    def client_id
      @client_id
    end

    # A setter for 'client_id' attribute. Client can pass this attribute
    # to API and fill it to identify objects in the error response.
    def client_id=(value)
      @client_id = value
    end

    # Returns relation object for providing nested messages.
    # By default it is the object itself.
    def relation_for_nested_messages(relation)
      public_send(relation)
    end
  end
end
