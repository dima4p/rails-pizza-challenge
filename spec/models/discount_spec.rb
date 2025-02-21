# == Schema Information
#
# Table name: discounts
#
#  slug                 :string           not null, primary key
#  name                 :string
#  deduction_in_percent :decimal(10, 2)   not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
require 'rails_helper'

describe Discount, type: :model do

  subject(:discount) { create :discount }

  describe 'validations' do
    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of :name}
    it { is_expected.to validate_presence_of :deduction_in_percent}
    it do
      is_expected.to validate_numericality_of(:deduction_in_percent)
        .is_greater_than(0)
        .is_less_than(100)
    end
  end   # validations

  describe 'class methods' do
    describe 'scopes' do
      describe '.ordered' do
        it 'orders the records of Discount by :name' do
          expect(Discount.ordered).to eq Discount.order(:name)
        end
      end   # .ordered
    end   # scopes
  end   # class methods

  describe '#apply_to(price)' do
    subject(:apply_to) {discount.apply_to(price)}
    let(:price) {45.68}

    it 'recuces the price by #deduction_in_percent and rounds it to 2 digits' do
      is_expected.to eq (price * (100 - discount.deduction_in_percent) / 100).round 2
    end
  end
end
