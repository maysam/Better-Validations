# Provides a way to merge multiple validators in order to get
# merged errors from all of them. Usage:
#
#   validator = validator_one.merge(validator_two, validator_three)
#   validator.valid?
#   validator.errors.detailed_messages
#
class BetterValidations::ValidatorsList
  def initialize(*validators)
    @validators = validators
  end

  def errors
    self
  end

  def valid?
    if @invalid_validators.nil?
      @invalid_validators = @validators.select(&:invalid?)
    end

    @invalid_validators.blank?
  end

  def invalid?
    !valid?
  end

  def detailed_messages(wrap_attributes_to: nil)
    (@invalid_validators || []).reduce({}) do |all_messages, validator|
      messages = validator.errors.detailed_messages(
        wrap_attributes_to:
      )

      deep_merge(all_messages, messages)
    end
  end

  def deep_merge(hash_one, hash_two)
    # Use a standard method to do a deep merge by specify
    # a values concatination logic
    hash_one.deep_merge(hash_two) do |_key, this_value, other_value|
      # Arrays has a complex logic - they must be merged
      if this_value.is_a?(Array) || other_value.is_a?(Array)
        merge_arrays(this_value, other_value)
      else
        this_value.nil? ? other_value : this_value
      end
    end
  end

  def merge_arrays(one, two)
    # If we have arrays of strings it means that we have arrays of errors:
    # ['Error 1', 'Error 2'] and ['Error 3', 'Error 4']. In this case we
    # just concat arrays and get unique values.
    if one.first.is_a?(String) || two.first.is_a?(String)
      return (one + two).uniq
    end

    # Other type of arrays is an array of hashes. Each hash is
    # an object with attributes:
    # [{ id: 1, client_id: 2, key: "String", another_key: {} }]
    merge_arrays_with_errors(one, two)
  end

  # Merges arrays of hashes to a single array by deep merging items
  # with the same ":id" and ":client_id".
  def merge_arrays_with_errors(one, two)
    all = one + two
    all = merge_hashes_by_key(all, :id)
    merge_hashes_by_key(all, :client_id)
  end

  def merge_hashes_by_key(hashes, key)
    hashes_by_id = hashes.group_by { |hash| hash[key] }
    hashes_by_id.map do |id, hashes_with_id|
      next hashes_with_id if id.nil?

      # Merge all hashes with the same id to the single hash.
      # Wrap to array in order to save a format (hashes_with_id is a array)
      [hashes_with_id.reduce({}) { |result, hash| deep_merge(result, hash) }]
    end.flatten(1)
  end
end
