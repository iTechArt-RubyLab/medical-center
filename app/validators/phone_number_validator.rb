class PhoneNumberValidator < ActiveModel::Validator
  def validate(record)
    return if Phonelib.valid? record.phone_number

    record.errors.add :phone_number, 'Invalid telephone number'
  end
end
