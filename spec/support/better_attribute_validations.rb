shared_examples 'a better attribute validator' do |validatable_class|
  context 'with better_validations on attributes' do
    it 'should have the same errors with attribute in detailed_messages' do
      object = validatable_class.new(attribute_one: nil).tap(&:valid?)
      expect(object.errors.detailed_messages).to has_same_field_messages(
        :attribute_one,
        object.errors.messages
      )
    end

    it 'should have the same errors with another attribute in detailed_messages' do
      object = validatable_class.new(attribute_two: nil).tap(&:valid?)
      expect(object.errors.detailed_messages).to has_same_field_messages(
        :attribute_two,
        object.errors.messages
      )
    end
  end

  context 'with wrapped attributes in detailed_messages' do
    it 'should return wrapped attributes from detailed_messages for attribute' do
      object = validatable_class.new(attribute_one: nil).tap(&:valid?)
      wrapper = :fields

      expect(
        object.errors.detailed_messages(wrap_attributes_to: wrapper)[wrapper]
      ).to has_same_field_messages(
        :attribute_one,
        object.errors.messages
      )
    end

    it 'should return wrapped attributes from detailed_messages for another attribute' do
      object = validatable_class.new(attribute_two: nil).tap(&:valid?)
      wrapper = :fields

      expect(
        object.errors.detailed_messages(wrap_attributes_to: wrapper)[wrapper]
      ).to has_same_field_messages(
        :attribute_two,
        object.errors.messages
      )
    end
  end
end
