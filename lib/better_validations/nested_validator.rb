class BetterValidations::NestedValidator < ActiveModel::EachValidator
  def validate_each(record, attr_name, value)
    return if value.nil?

    validator = value
    return if validator_valid?(validator)

    add_errors(validator, record, attr_name)
  end

  protected

  def validator_valid?(validator)
    validators = validator.is_a?(Enumerable) ? validator : [validator]
    validators.map(&:valid?).all?
  end

  def add_errors(validator, record, attr_name)
    # Should copy all errors from nested object to the record
    # in order to emulate active record nested errors.
    # But in case of list should merge errors of all items together.
    details = if validator.is_a?(Enumerable)
                collect_nested_errors_details(validator)
              else
                validator.errors.details
              end

    add_errors_details(details, record, attr_name)
  end

  def add_errors_details(details, record, attr_name)
    details.each do |field_name, errors|
      errors.each do |error|
        record.errors.add("#{attr_name}.#{field_name}",
                          error[:error],
                          **error.except(:error))
      end
    end
  end

  def collect_nested_errors_details(validators)
    result = {}

    validators.each do |validator|
      validator.errors.details.each do |field_name, errors|
        # Use set to remove duplicates automalically
        result_errors = result[field_name] || Set.new
        result[field_name] = result_errors + errors
      end
    end

    result.transform_values(&:to_a)
  end
end
