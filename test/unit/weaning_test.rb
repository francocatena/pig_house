require 'test_helper'

# Clase para probar el modelo "Weaning"
class WeaningTest < ActiveSupport::TestCase
  fixtures :weanings

  # Función para inicializar las variables utilizadas en las pruebas
  def setup
    @weaning = Weaning.find weanings(:recent).id
  end

  # Prueba que se realicen las búsquedas como se espera
  test 'find' do
    assert_kind_of Weaning, @weaning
    assert_equal weanings(:recent).date, @weaning.date
    assert_equal weanings(:recent).weaned, @weaning.weaned
    assert_equal weanings(:recent).nursed_weaned, @weaning.nursed_weaned
    assert_equal weanings(:recent).age, @weaning.age
    assert_equal weanings(:recent).average_weight, @weaning.average_weight
    assert_equal weanings(:recent).pig_id, @weaning.pig_id
  end

  # Prueba la creación de un cerdo
  test 'create' do
    assert_difference 'Weaning.count' do
      @weaning = Weaning.create(
        :date => Date.today,
        :weaned => 12,
        :nursed_weaned => 1,
        :age => 20,
        :average_weight => 1.5,
        :pig => pigs(:mother)
      )
    end
  end

  # Prueba de actualización de un cerdo
  test 'update' do
    assert_no_difference 'Weaning.count' do
      assert @weaning.update_attributes(:nursed_weaned => 5),
        @weaning.errors.full_messages.join('; ')
    end

    assert_equal 5, @weaning.reload.nursed_weaned
  end

  # Prueba de eliminación de cerdos
  test 'destroy' do
    assert_difference('Weaning.count', -1) { @weaning.destroy }
  end

  # Prueba que las validaciones del modelo se cumplan como es esperado
  test 'validates blank attributes' do
    @weaning.date = nil
    @weaning.weaned = nil
    @weaning.nursed_weaned = nil
    @weaning.age = nil
    @weaning.average_weight = nil
    assert @weaning.invalid?
    assert_equal 5, @weaning.errors.count
    assert_equal [error_message_from_model(@weaning, :date, :blank)],
      @weaning.errors[:date]
    assert_equal [error_message_from_model(@weaning, :weaned, :blank)],
      @weaning.errors[:weaned]
    assert_equal [error_message_from_model(@weaning, :nursed_weaned, :blank)],
      @weaning.errors[:nursed_weaned]
    assert_equal [error_message_from_model(@weaning, :age, :blank)],
      @weaning.errors[:age]
    assert_equal [error_message_from_model(@weaning, :average_weight, :blank)],
      @weaning.errors[:average_weight]
  end

  # Prueba que las validaciones del modelo se cumplan como es esperado
  test 'validates well formated attributes' do
    @weaning.date = '13/13/13'
    @weaning.weaned = '1x'
    @weaning.nursed_weaned = '1.0'
    @weaning.age = '1.0'
    @weaning.average_weight = '1x'
    assert @weaning.invalid?
    assert_equal 6, @weaning.errors.count
    assert_equal [error_message_from_model(@weaning, :date, :invalid_date),
      error_message_from_model(@weaning, :date, :blank)].sort,
      @weaning.errors[:date].sort
    assert_equal [error_message_from_model(@weaning, :weaned, :not_a_number)],
      @weaning.errors[:weaned]
    assert_equal [error_message_from_model(@weaning, :nursed_weaned,
        :not_an_integer)], @weaning.errors[:nursed_weaned]
    assert_equal [error_message_from_model(@weaning, :age, :not_an_integer)],
      @weaning.errors[:age]
    assert_equal [error_message_from_model(@weaning, :average_weight,
        :not_a_number)], @weaning.errors[:average_weight]
  end

  # Prueba que las validaciones del modelo se cumplan como es esperado
  test 'validates attributes boundaries' do
    @weaning.average_weight = '0'
    assert @weaning.invalid?
    assert_equal 1, @weaning.errors.count
    assert_equal [error_message_from_model(@weaning, :average_weight,
        :greater_than, :count => 0)], @weaning.errors[:average_weight]

    @weaning.average_weight = '100'
    assert @weaning.invalid?
    assert_equal 1, @weaning.errors.count
    assert_equal [error_message_from_model(@weaning, :average_weight,
        :less_than, :count => 100)], @weaning.errors[:average_weight]
  end
end