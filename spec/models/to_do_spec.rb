require 'rails_helper'

describe ToDo do
  describe "Mongoid validations" do
    it { expect(subject).to validate_presence_of :title }
    it { expect(subject).to validate_presence_of :deadline }
  end
end
